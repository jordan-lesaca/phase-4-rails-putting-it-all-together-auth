class RecipesController < ApplicationController
    before_action :authorize

    def index
        recipes = Recipe.all 
        render json: recipes, status: :created   
    end

    def create
        recipe = Recipe.create!(recipe_params)
        render json: recipe, status: :created
    end

    private

    def authorize
        render json: { errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id
    end

    def recipe_params
        params.permit(:user_id, :title, :instructions, :minutes_to_complete).with_defaults(user_id:session[:user_id])
    end

end
