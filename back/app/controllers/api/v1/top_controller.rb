module Api
  module V1
    class TopController < ApplicationController
      def index
        posts = Post.includes(:liked_users).sort {|a, b| b.liked_users.size <=> a.liked_users.size}
        events = Event.all
        render json: posts
      end
    end
  end
end