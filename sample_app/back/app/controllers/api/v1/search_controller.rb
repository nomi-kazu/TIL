module Api
  module V1
    class SearchController < ApplicationController
      def users
        users = if params[:keyword].empty?
                  []
                else
                  User.where('name Like ? OR description Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                end
        render json: users.as_json(include: %i[followings followers tags], methods: :image_url)
      end

      def posts
        posts = if params[:keyword].empty?
                  []
                else
                  Post.where('content Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                end
        render json: posts.as_json(include: [{ user: { methods: :image_url } }, :liked_users, :tags])
      end

      def tags
        tags = if params[:keyword].empty?
                 []
               else
                 Tag.where('name Like ?', "%#{params[:keyword]}%")
               end
        render json: tags.as_json(include: %i[users posts])
      end
    end
  end
end