class Api::V1::AuthenticationController < ApiController
    skip_before_action :authenticate_user!, only: [:create]

    def create
        user = User.find_by(email: params[:email])
        #puts params[:password]
        if user&.valid_password?(params[:password])
            render json: {token: JsonWebToken.encode(sub: user.id)}
        else
            render json: {errors: 'invalid'}
        end
    end

    def fetch
        if current_user
            render json: current_user
        else
            render json: {error: "Can't find that user"}
        end
    end
end