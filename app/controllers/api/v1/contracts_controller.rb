class Api::V1::ContractsController < ApiController

    def create
        user_id = current_user.id
        contract = Contract.new(contract_params)
        contract.policy_id = policy_id
        if contract.save
            render json: {status: "SUCCESS", message: "new contract created", data: contract}, status: :ok
        else
            render json: {status: failure, message: "failed to create contract"}, status: :unprocessable_entity
        end
    end


    def show
        contract = Contract.find(params[:id])
        if contract
            render json: {status: "SUCCESS", data: contract}, status: :ok
        else
            render json: {status: "Failure", message: "Could not find a contract with that ID"}, status: :not_found
        end
    end

    def destroy
        contract = Contract.find(params[:id])
        if contract.destroy
            render json: {status: "SUCCESS", message: "Successfully Deleted Contract"}, status: :ok
        else
            render json: {status: "FAILURE", message: "Failed to delete Contract"}, status: :unprocessable_entity
        end
    end

    private
        def contract_params
            params.require(:contract).permit(:address, :maize_variety, :start_date, :end_date)
        end
    
end