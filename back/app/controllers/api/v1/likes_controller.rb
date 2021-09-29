module Api
  module V1
    class LikesController < ApplicationController
      before_action :set_user, only: [:create]

      def create
        like = @user.likes.create(post_id: like_params[:post_id])
        if like.save
          like.notice_post_like(like.user_id, like.post_id)
          render json: like.as_json(include: [:post]), status: :created
        end
      end

      def destroy
        like = Like.find_by(post_id: params[:id], user_id: @user.id)
        if like.destroy
          render json: like, status: :ok
        else
          render json: like.errors, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = User.find(like_params[:user_id])
      end

      def like_params
        params.require(:like).permit(:user_id, :post_id)
      end
    end
  end
end