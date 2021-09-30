module Api
  module V1
    class NoticesController < ApplicationController
      def index
        user = User.find(params[:user_id])
        notices = user.passive_notices.all
        notices.where(checked: false).each do |notice|
          notice.update(checked: true)
        end
        render json: notices
      end

      def unchecked
        user = User.find(params[:user_id])
        count = user.passive_notices.where(checked: false).count
        render json: count
      end

      def checked
        user = User.find(params[:user_id])
        notices = user.passive_notices.where(checked: false)
        render json: notices.as_json(include: [{ action_user: { methods: :image_url } }, :received_user, :post])
        notices.each do |notice|
          notice.update(checked: true)
        end
      end
    end
  end
end
