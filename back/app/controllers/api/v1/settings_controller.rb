module Api
  module V1
    class SettingsController < ApplicationController
      def edit
        user = User.find(params[:user_id])
        setting = user.setting
        render json: setting
      end

      def update
        user = User.find(params[:user_id])
        if user.setting.update(setting_params)
          setting = user.setting
          render json: setting
        end
      end

      private

      def setting_params
        params.require(:setting).permit(:notice_post_like, :notice_comment, :notice_follow)
      end
    end
  end
end