class Api::V1::PoliciesController < ApiController
    include TimeConvertHelper  #helper functions to convert between epoch time used in smart contracts and regular time used in the db
    include SmartContractFunctionHelper #for interacting with the smart contract functions

    def create
        policy = Policy.new(policy_params)
        policy.user_id = current_user.id
        
        # convert date to regular
        policy.start_date = epoch_2_regular(policy_params[:start_date].to_i)
        policy.end_date = epoch_2_regular(policy_params[:end_date].to_i)

        if policy.save #save the new policy

            # ========================
            # For when the smart contracts are up and running
            contract = Contract.new({
                maize_variety: policy_params[:maize_variety],
                start_date: policy_params[:start_date],
                end_date: policy_params[:end_date],
                policy_id: policy.id
            }) 
            contractPurchase = buyPolicy([current_user.id, policy.id, policy_params[:maize_variety], policy_params[:start_date].to_i, policy_params[:end_date].to_i])
            if contract.save and contractPurchase
                render json: {status: "SUCCESS", message: "new contract && policy  created", data: [contract, policy]}, status: :ok
            else
                render json: {status: "SUCCESS", message: "Failed to create policy", data: contract.errors}, status: :unprocessable_entity
            end
        else
            render json: {status: "FAILURE", message: "failed to create policy", data: policy.errors}, status: :unprocessable_entity
        end
    end

    def index
        policies = Policy.where({user_id: current_user.id})
        render json: {status: "SUCCESS", message: "Policies for #{current_user.email}", data: policies}, status: :ok
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
            params.require(:policy).permit(:location, :maize_variety, :start_date, :end_date)
        end

        def edit_policy_params
            params.require(:policy).permit(:location, :maize_variety, :start_date, :end_date)
        end
end