module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_user, only: [:create]

      def create
        comment = @user.comments.new(comment_params)
        if comment.save
          comment.notice(comment.user_id, comment.post_id)
          render json: comment.as_json(include: [{ user: { methods: :image_url } }, :post]), status: :created
        else
          render json: comment.errors, status: :unprocessable_entity
        end
      end

      def destroy
        comment = Comment.find(params[:id])
        comment.destroy!
      end

      private

      def set_user
        @user = User.find(comment_params[:user_id])
      end

      def comment_params
        params.require(:comment).permit(:user_id, :post_id, :content)
      end
    end
  end
end
