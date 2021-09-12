class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  
  def created_date
    self.created_at&.strftime('%Y/%m/%d')
  end
end
