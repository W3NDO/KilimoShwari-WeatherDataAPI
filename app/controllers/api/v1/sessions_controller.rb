class Api::V1::SessionsController < Devise::SessionsController
    before_action :sign_in_params, only: :create
    before_action :load_user, only: :create

    #sign in
    def create
        if @user.valid_password?(sign_in_params[:password])
            sign_in "user", @user
            render json: {
                messages: "Sign in Successful",
                is_success: true,
                data: {user: @user}
            }, status: :ok
        else
            render json: {
                messages: "Sign in Failed - Unauthorized",
                is_success: false,
                data: {}
            }, status: :unauthorized
        end
    end

    def show
        if :authenticate_api_v1_user!
            render json: {
                message: "User Info",
                is_success: true,
                data: {user: @user}
            }, status: :ok
        else
            render json: {
                messages: "Unauthorized",
                is_success: false,
                data: {}
            }, status: :unauthorized
    end

    private
        def sign_in_params
            params.require(:user).permit(:email, :password)
        end

        def load_user
            @user = User.find_for_database_authentication(email: sign_in_params[:email])
            if @user
                return @user
            else
                render json: {
                    messages: "Cannot find User",
                    is_success: false,
                    data: {}
                }, status: :not_found
            end
        end
end