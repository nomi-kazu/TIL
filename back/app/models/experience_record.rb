class ExperienceRecord < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :obtained_exp, presence: true, numericality: { only_integer: true }
end
