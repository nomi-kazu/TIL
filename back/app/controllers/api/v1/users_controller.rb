module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user, only: %i[update destroy]

      def login_user
        render json: current_user.as_json(methods: [:image_url]), status: :ok
      end

      def index; end

      def show
        user = User.find(params[:id])
        render json: user.as_json(methods: :image_url)
      end

      def create
        user = User.new(user_params)

        if user.save
          render json: user, methods: [:image_url], status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def update
        user = User.find(params[:id])

        if user.update(user_params)
          render json: user.as_json(methods: [:image_url]), status: :ok
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        user = User.find(params[:id])
        if user.destroy
          render json: user, status: :ok
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :description, :image, :password)
      end
    end
  end
end