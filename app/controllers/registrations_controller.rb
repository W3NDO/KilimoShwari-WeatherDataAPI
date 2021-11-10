class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    def create
        @user = User.new(sign_up_params)
        if @user.save
            render json: {user: @user }, status: :ok
        else
            render json: {errors: @user.errors}, status: :unprocessable_entity
        end
    end

    def update
        user = current_user        
        if user.update(update_params)
            render json: user
        else
            render json: {errors: user.errors}
        end
    end

    def destroy
        user = current_user
        if user.destroy
            render json: {message: "user successfully deleted"}
        else
            render json: {message: "failed to delete user"}
        end
    end

    private
        def sign_up_params
            params.permit(:email, :password, :password_confirmation)
        end

        def update_params
            params.permit(:email, :first_name, :last_name, :d_o_b, :gender, :phone_number)
        end
end