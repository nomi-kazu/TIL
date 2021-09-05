class User < ApplicationRecord
  include UserAuth::Tokenizable
  before_validation :downcase_email
  has_secure_password
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/.freeze
  attr_accessor :current_password

  has_one_attached :image

  # 他テーブルとのアソシエーション
  has_many :posts
  has_many :tags, through: :user_tag_maps
  has_many :user_tag_maps, dependent: :destroy

  # カラムのバリデーション
  validates :name, presence: true, uniqueness: true,
                   length: { maximum: 15, allow_blank: true }
  validates :description, length: { maximum: 1000, allow_blank: true }
  validates :password, presence: true,
                       length: { minimum: 8 },
                       format: {
                         with: VALID_PASSWORD_REGEX
                       },
                       allow_nil: true

  def save_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # すでに登録されている古いタグの削除
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    # タグの生成
    new_tags.each do |new_name|
      user_tag = Tag.find_or_create_by(name: new_name)
      self.tags << user_tag
    end
  end

  def image_url
    image.attached? ? url_for(image) : nil
  end

  private

  # emailの小文字化
  def downcase_email
    self.email.downcase! if email
  end
end
