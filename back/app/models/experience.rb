class Experience < ApplicationRecord
  alias_attribute :total, :lifelong_exp
  alias_attribute :to_next, :experience_to_next

  belongs_to :user

  validates :level, presence: true, numericality: { only_integer: true }
  validates :total, presence: true, numericality: { only_integer: true }
  validates :to_next, presence: true, numericality: { only_integer: true }
end
