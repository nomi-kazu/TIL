module Api
  module V1
    class TopController < ApplicationController
      def index
        posts = Post.joins(:likes).group(:id).order('count(likes.post_id) desc').limit(6)
        render json: { posts: posts.as_json(include: [{ user: { methods: :image_url } }, :liked_users, :tags]) }
      end

      def exp_ranking
        if params[:weekly]
          term = Time.current.beginning_of_week.since(4.hours)
        elsif params[:monthly]
          term = Time.current.beginning_of_month.since(4.hours)
        end
        users = User.exp_ranking(term)
        render json: { users: users.as_json(methods: :image_url)}
      end
    end
  end
end
