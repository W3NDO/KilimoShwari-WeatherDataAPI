class Api::V1::PoliciesController < ApiController
    include TimeConvertHelper  #helper functions to convert between epoch time used in smart contracts and regular time used in the db
    include SmartContractFunctionHelper #for interacting with the smart contract functions
    include WeatherCallHelper #get the weather for the location => daily and weekly for the specified duration

    def create
        policy = Policy.new(policy_params)
        policy.user_id = current_user.id
        
        # convert date to regular
        if policy_params[:start_date] > policy_params[:end_date] #move this check to front end
            render json: {status: "FAILURE", message: "Failed to create policy", data: "start date can not be after end date"}, status: :unprocessable_entity
        else
            # policy.start_date = epoch_2_regular(policy_params[:start_date].to_i)
            # policy.end_date = epoch_2_regular(policy_params[:end_date].to_i)
            policy.start_date = regular_2_epoch(policy_params[:start_date])
            policy.end_date = regular_2_epoch(policy_params[:end_date])
        end

        if policy.save #save the new policy
            contract = Contract.new({
                maize_variety: policy_params[:maize_variety],
                start_date: policy_params[:start_date],
                end_date: policy_params[:end_date],
                policy_id: policy.id
            })
            cwd = ClientWeatherDatum.new({
                name: policy_params[:location],
                user_id: current_user.id,
                geo_location: policy_params[:coordinates],
                start_date: epoch_2_regular(policy_params[:start_date].to_i),
                end_date: epoch_2_regular(policy_params[:end_date].to_i),
                weather_data: nil,
                policy_id: policy.id,
                counter: (policy.end_date - policy.start_date).to_i
            })
            if cwd.save
                WeatherAccountingJob.perform_later (cwd.id)
                puts true
            end
            puts get_weather(policy_params[:coordinates].split(',')[0], policy_params[:coordinates].split(',')[1])
            contractPurchase = buyPolicy([current_user.id, policy.id, policy_params[:maize_variety], policy_params[:start_date].to_i, policy_params[:end_date].to_i])
            contractPurchase = contractPurchase.wait
            if contractPurchase[0] == 200
                contract.blockhash = contractPurchase[1]
                contract.save
                render json: {status: "SUCCESS", message: "new contract && policy created at #{contractPurchase[1]}", data: [contract, policy, contractPurchase[1], cwd]}, status: :ok
            else
                render json: {status: "FAILURE", message: "Failed to create policy", data: contract.errors}, status: :unprocessable_entity
            end
        else
            render json: {status: "FAILURE", message: "failed to create policy", data: policy.errors}, status: :unprocessable_entity
        end
    end

    def index
        Rails.logger.info(params.inspect)
        policies = Policy.where({user_id: current_user.id})
        _contracts = {}
        for policy in policies
            _contracts[policy.id] = Contract.where(policy_id: policy.id)             
        end
        render json: {status: "SUCCESS", data: {"policies" => policies}}, status: :ok
    end

    def show
        policy = Policy.find(params[:id])
        if policy
            res = getPolicy(params[:id])
            render json: {status: "SUCCESS", data: [policy, res]}, status: :ok
        else
            render json: {status: "Failure", message: "Could not find a policy with that ID"}, status: :not_found
        end
    end

    def edit
        policy = Policy.find(params[:id])
        if policy.update(edit_policy_params)

            #convert times
            policy.start_date = epoch_2_regular(edit_policy_params[:start_date].to_i)
            policy.end_date = epoch_2_regular(edit_policy_params[:end_date].to_i)
            policy.save
            
            render json: {status: "SUCCESS", message: "successfully updated policy", data: policy}, status: :ok
        else
            render json: {status: "FAILURE", message: policy.errors}, status: :unprocessable_entity
        end
    end

    def destroy
        policy = Policy.find(params[:id])
        if policy.delete
            render json: {status: "SUCCESS", message: "Successfully Deleted Policy"}, status: :ok
        else
            render json: {status: "FAILURE", message: "failed"}, status: :unprocessable_entity
        end
    end

    private
        def policy_params
            params.require(:policy).permit(:location, :maize_variety, :coordinates, :start_date, :end_date)
        end

        def edit_policy_params
            params.require(:policy).permit(:location, :maize_variety, :start_date, :end_date)
        end
end