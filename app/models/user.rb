class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id, dependent: :destroy

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }
  after_initialize :set_default_photo

  def set_default_photo
    self.photo ||= ActionController::Base.helpers.asset_path('avatars/13.png') if photo.blank?
  end

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
