module Api
  module V1
    class EventCommentsController < ApplicationController
      before_action :set_user, only: [:create]

      def create
        event_comment = @user.event_comments.new(event_comment_params)
        if event_comment.save
          event_comment.notice_comment(event_comment.user_id, event_comment.event_id)
          render json: event_comment.as_json(include: [{ user: { methods: :image_url } }, :event]), status: :created
        else
          render json: event_comment.errors, status: :unprocessable_entity
        end
      end

      def destroy
        event_comment = EventComment.find(params[:id])
        event_comment.destroy!
      end

      private

      def set_user
        @user = User.find(event_comment_params[:user_id])
      end

      def event_comment_params
        params.require(:event_comment).permit(:user_id, :event_id, :content)
      end
    end
  end
end
