class EventComment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :notices, dependent: :destroy

  # カラムのバリデーション
  validates :content, presence: true

  def notice_comment(action_user_id, event_id)
    event = Event.find(event_id)
    action_user = User.find(action_user_id)

    # イベントの投稿者への通知
    contributor_notice = action_user.active_notices.new(
      action_user_id: action_user.id,
      received_user_id: event.user.id,
      event_id: event.id,
      action: 'event_comment'
    )
    if action_user_id != event.user.id
      contributor_notice.save
    end

    # 他にコメントしていた人への通知
    users = []
    event.event_comments.each do |c|
      users.push(c.user)
    end
    users.uniq.each do |user|
      comment_notice = action_user.active_notices.new(
        action_user_id: action_user.id,
        received_user_id: user.id,
        event_id: event.id,
        action: 'event_comments'
      )
      if action_user_id != user.id
        comment_notice.save
      end
    end
  end
end
