class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :notices, dependent: :destroy

  # カラムのバリデーション
  validates :content, presence: true
end

