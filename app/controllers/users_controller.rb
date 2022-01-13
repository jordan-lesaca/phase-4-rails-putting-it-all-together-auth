class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        user = User.find(session[:user_id])
        if user.valid? 
            session[:user_id] = user.id
            render json: user 
        else
            render json: { errors: user.errors.full_messages }, status: :unauthorized
        end
    end

    private

    def record_not_found
        render json: { error: "Article not found" }, status: :unauthorized
    end

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
 
end
