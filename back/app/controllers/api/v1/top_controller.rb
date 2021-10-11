module Api
  module V1
    class TopController < ApplicationController
      def index
        posts = Post.joins(:likes).group(:id).order('count(likes.post_id) desc').limit(6)
        render json: { posts: posts.as_json(include: [{ user: { methods: :image_url } }, :liked_users, :tags]) }
      end
    end
  end
end
