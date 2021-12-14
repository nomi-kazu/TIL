module Api
  module V1
    class UsersController < ApplicationController
      def show
        @user = User.join_exp.includes({ image_attachment: :blob },
                                       { posts: [{ images_attachments: :blob }, { user: { image_attachment: :blob } }, :tags, :experience_record] },
                                       { liked_posts: [{ user: { image_attachment: :blob } }, :tags, :experience_record] },
                                       { followings: { image_attachment: :blob } },
                                       { followers: { image_attachment: :blob } }, :tags).find(params[:id])
        required_exp = RequiredExp.find_by(level: @user.level)
        render json: { user: @user.as_json(include: [{ posts: { include: [{ user: { methods: :image_url } }, :tags, :liked_users, :experience_record], methods: :images_data } },
                                                     { liked_posts: { include: [{ user: { methods: :image_url } }, :tags, :liked_users, :experience_record] } },
                                                     { followings: { include: %i[followings followers], methods: :image_url } },
                                                     { followers: { include: %i[followings followers], methods: :image_url } }, :tags], methods: %i[image_url tag_ranking]),
                       required_exp: required_exp }
      end

      def create
        user = User.new(user_params)

        if user.save && user.create_experience! && user.create_setting!
          user = User.join_exp.find(user.id)
          render json: user, methods: [:image_url], status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def edit
        user = User.find(params[:id])
        render json: { user: user }
      end

      def update
        user = User.find(params[:id])

        if user.update(user_params)
          render json: user.as_json(only: %i[id name email description], methods: [:image_url]), status: :ok
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        user = User.find(params[:id])
        if user.destroy
          render json: { message: '退会しました', status: :ok }
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