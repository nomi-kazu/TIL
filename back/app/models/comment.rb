class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  # カラムのバリデーション
  validates :content, presence: true
end

