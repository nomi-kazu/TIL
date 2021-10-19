module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_user, only: :create
      before_action :set_post, except: %i[index create]

      def show
        render json: @post.as_json(include: [{ user: { include: %i[followings followers], methods: :image_url } },
                                             { comments: { include: { user: { methods: :image_url } } } },
                                             :tags, :liked_users, :experience_record])
      end

      def create
        post = Post.new(post_params)
        post.user = @user

        ActiveRecord::Base.transaction do
          if post.save
            post.save_tags(tags_params[:tags]) if tags_params[:tags]
            experience_record = ExperienceRecorder.new(post.user).record(post)
            experience = Experience.find_by(user_id: post.user.id)
            required_exp = RequiredExp.find_by(level: experience.level)
            render json: { post: post, experience_record: experience_record, experience: experience, required_exp: required_exp, message: '投稿を作成しました' }, status: :created
          else
            render json: post.errors, status: :unprocessable_entity
          end
        end
      end

      def update
        ActiveRecord::Base.transaction do
          if @post.update(post_params)
            @post.save_tags(tags_params[:tags]) if tags_params[:tags]
            experience_record = ExperienceRecorder.new(@post.user).record(@post)
            experience = Experience.find_by(user_id: @post.user.id)
            required_exp = RequiredExp.find_by(level: experience.level)
            render json: { post: @post, experience_record: experience_record, experience: experience, required_exp: required_exp, message: '投稿を編集しました' }
          else
            render json: @post.errors, status: :unprocessable_entity
          end
        end
      end

      def destroy
        ActiveRecord::Base.transaction do
          if @post.destroy
            ExperienceRecorder.new(@post.user).delete_record(@post)
            experience = @post.user.experience
            required_exp = RequiredExp.find_by(level: experience.level)
            render json: { experience: experience, required_exp: required_exp, message: '投稿を削除しました', status: :ok }
          else
            render json: @post.errors, status: :unprocessable_entity
          end
        end
      end

      private

      def set_user
        @user = User.find(post_params[:user_id])
      end

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:user_id, :content, :study_time, :study_date)
      end

      def tags_params
        params.require(:post).permit(tags: [])
      end
    end
  end
end