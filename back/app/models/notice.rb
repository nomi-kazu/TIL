class Notice < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :action_user, class_name: 'User', foreign_key: 'action_user_id', optional: true
  belongs_to :received_user, class_name: 'User', foreign_key: 'received_user_id', optional: true
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  belongs_to :event, optional: true
  belongs_to :event_comment, optional: true
end
