class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def notice(action_user_id, post_id)
    post = Post.find(post_id)
    action_user = User.find(action_user_id)

    if action_user.id != post.user.id && post.user.setting.notice_post_like
      notice = action_user.active_notices.new(
        action_user_id: action_user.id,
        received_user_id: post.user.id,
        post_id: post.id,
        action: 'like'
      )
      notice.save
    end
  end
end
