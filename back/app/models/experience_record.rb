class ExperienceRecord < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :experience_point, presence: true, numericality: { only_integer: true }
end
