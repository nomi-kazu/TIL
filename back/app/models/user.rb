class User < ApplicationRecord
  include UserAuth::Tokenizable
  before_validation :downcase_email
  has_secure_password
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/.freeze
  attr_accessor :current_password

  # 他テーブルとのアソシエーション
  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_many :user_tag_maps, dependent: :destroy
  has_many :tags, through: :user_tag_maps
  has_many :comments, dependent: :destroy
  has_many :event_comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :join_events, dependent: :destroy
  has_many :event_joins, through: :join_events, source: :event
  has_many :active_notices, class_name: 'Notice', foreign_key: 'action_user_id', dependent: :destroy
  has_many :passive_notices, class_name: 'Notice', foreign_key: 'received_user_id', dependent: :destroy
  has_many :experience_records, dependent: :destroy
  has_one :experience, dependent: :destroy

  scope :join_exp, -> { joins(:experience).select('users.*, experiences.experience_to_next, experiences.lifelong_exp, experiences.level') }

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

    # すでに登録されているがフォームに含まれていない古いタグの削除
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    # タグの生成
    new_tags.each do |new_name|
      user_tag = Tag.find_or_create_by(name: new_name)
      self.tags << user_tag
    end
  end

  # フォロー
  def follow(other_user)
    self.relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  # フォロー解除
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship&.destroy
  end

  def image_url
    image.attached? ? url_for(image) : nil
  end

  # 使用頻度の高いタグにランキングをつける
  def tag_ranking
    lists = self.posts.includes(:tags) + self.liked_posts.includes(:tags) + self.events.includes(:tags) + self.event_joins.includes(:tags)
    tags = []

    lists.each do |post|
      post.tags.each { |tag| tags.push(tag) } if post.tags.length.positive?
    end

    # タグの重複をなくす
    tags_data = tags.group_by(&:itself).map { |key, value| { name: key.name, counter: value.count } }
    tags_data = tags_data.sort { |a, b| b[:counter] <=> a[:counter] }
    tags_data.first(5)
  end

  def notice_follow(action_user_id, received_user_id)
    action_user = User.find(action_user_id)
    received_user = User.find(received_user_id)
    follow_notice = action_user.active_notices.new(
      action_user_id: action_user.id,
      received_user_id: received_user.id,
      action: 'follow'
    )
    follow_notice.save
  end

  private

  # emailの小文字化
  def downcase_email
    self.email.downcase! if email
  end
end
