module Api
  module V1
    class TagsController < ApplicationController
      before_action :set_tag, only: %i[create destroy]

      def show
        tag = Tag.includes({ users: { image_attachment: :blob } }, { posts: [{ user: { image_attachment: :blob } }, :liked_users, :tags] }).find(params[:id])
        render json: tag.as_json(include: [{ users: { methods: :image_url } },
                                           { posts: { include: [{ user: { methods: :image_url } }, :liked_users, :tags] } }])
      end

      def create
        @tag.user_tag_maps.create(user_id: @user.id)
        render json: @tag.as_json(include: %i[users posts]), status: :created
      end

      def destroy
        user_tag_map = UserTagMap.find_by(user_id: @user.id, tag_id: @tag.id)
        if user_tag_map.destroy
          render json: @tag.as_json(include: %i[users posts]), status: :ok
        else
          render json: user_tag_map.errors, status: :unprocessable_entity
        end
      end

      def delete_tag
        tag = Tag.find(params[:tag_id])
        if tag.destroy
          render json: { message: 'タグを削除しました', status: :ok }
        else
          render json: tag.errors, status: :unprocessable_entity
        end
      end

      private

      def set_tag
        @tag = Tag.find(params[:id])
        @user = User.find(params[:user_id])
      end
    end
  end
end
