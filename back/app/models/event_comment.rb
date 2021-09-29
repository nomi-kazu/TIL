class EventComment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :notices, dependent: :destroy

  # カラムのバリデーション
  validates :content, presence: true
end
