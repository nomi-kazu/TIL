module Api
  module V1
    class NoticesController < ApplicationController
      def index
        user = User.find(params[:user_id])
        notices = user.passive_notices.includes({ action_user: { image_attachment: :blob } },
                                                  :received_user, :post, :comment, :event, :event_comment)
        render json: notices.as_json(include: [{ action_user: { methods: :image_url } }, :received_user, :post, :event])
      end

      def unchecked
        user = User.find(params[:user_id])
        count = user.passive_notices.where(checked: false).count
        render json: count
      end

      def checked
        user = User.find(params[:user_id])
        notices = user.passive_notices.where(checked: false)
        render json: notices.as_json(include: [{ action_user: { methods: :image_url } }, :received_user, :post, :event])
        notices.each do |notice|
          notice.update(checked: true)
        end
      end
    end
  end
end
