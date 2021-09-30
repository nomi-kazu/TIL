class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :notices, dependent: :destroy

  # カラムのバリデーション
  validates :content, presence: true

  def notice_comment(action_user_id, post_id)
    post = Post.find(post_id)
    action_user = User.find(action_user_id)

    # 投稿者への通知
    contributor_notice = action_user.active_notices.new(
      action_user_id: action_user.id,
      received_user_id: post.user.id,
      post_id: post.id,
      action: 'post_comment'
    )
    if action_user_id != post.user.id
      contributor_notice.save
    end

    # 他にコメントしていた人への通知
    users = []
    post.comments.each do |c|
      users.push(c.user)
    end
    users.uniq.each do |user|
      comment_notice = action_user.active_notices.new(
        action_user_id: action_user.id,
        received_user_id: user.id,
        post_id: post.id,
        action: 'post_comments'
      )
      if action_user_id != user.id
        comment_notice.save
      end
    end
  end
end

