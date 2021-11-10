class Api::V1::PoliciesContorller < ApiController
    def create
        user_id = current_user.id
        policy = Policy.new(policy_params)
        policy.user_id = user_id
        if policy.save
            render json: {status: "SUCCESS", message: "new policy created", data: policy}, status: :ok
        else
            render json: {status: failure, message: "failed to create policy"}, status: :unprocessable_entity
        end
    end

    def index
        policies = Policy.where({user_id: current_user.id})
        render json: {status: "SUCCESS", message: "Policies for #{current_user.email}", data: policies}, status: :ok
    end

    def show
        policy = Policy.find_by(id: policy_params_id[:id])
        if policy
            render json: {status: "SUCCESS", data: policy}, status: :ok
        else
            render json: {status: "Failure", message: "Could not find a policy with that ID"}, status: :not_found
        end
    end

    def edit
        policy = Policy.find(params[:id])
        if policy.update(edit_policy_params)
            render json: {status: "SUCCESS", message: "successfully updated policy", data: policy}, status: :ok
        else
            render json: {status: "FAILURE", message: policy.errors}, status: :unprocessable_entity
    end

    def destroy
        policy = Policy.fins(params[:id])
        if policy.destroy
            render json: {status: "SUCCESS", message: "Successfully Deleted Policy"}, status: :ok
        else
            render json: {status: "FAILURE", message: "failed"}, status: :unprocessable_entity
        end
    end

    private
        def policy_params
            params.require(:policy).permit(:location, :maize_variety, :start_date, :end_date)
        end

        def policy_params_id
            params.require(:policy).permit(:id)
        end

        def edit_policy_params
            params.require(:policy).permit(:location, :maize_variety, :start_date, :end_date)
        end
end