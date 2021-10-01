class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def notice_post_like(action_user_id, post_id)
    post = Post.find(post_id)
    action_user = User.find(action_user_id)
    notice = action_user.active_notices.new(
      action_user_id: action_user.id,
      received_user_id: post.user.id,
      post_id: post.id,
      action: 'like'
    )
    if action_user.id != post.user.id
      notice.save
    end
  end
end
