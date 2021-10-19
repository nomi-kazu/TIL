class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :notices, dependent: :destroy

  # カラムのバリデーション
  validates :content, presence: true

  def notice(action_user_id, post_id)
    post = Post.find(post_id)
    action_user = User.find(action_user_id)

    # 投稿者への通知
    if action_user_id != post.user.id && post.user.setting.notice_comment
      contributor_notice = action_user.active_notices.new(
        action_user_id: action_user.id,
        received_user_id: post.user.id,
        post_id: post.id,
        action: 'post_comment'
      )
      contributor_notice.save
    end
  end
end

