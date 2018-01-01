#require 'digest/md5'

class User < ActiveRecord::Base
  # see: https://github.com/plataformatec/devise
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :follows
  has_many :retwets
  has_many :twets

  has_one :user_profile, dependent: :destroy

  validates :name, :presence => true
  validates :username, :presence => true, :uniqueness => true

  def self.find_by_username_ignore_case(username)
    username = username.from(1) if username.at(0) == '@'
    User.where('lower(username) = ?', username.downcase).first
  end

  # Scope method to get all users except the one passed.
  #
  def self.all_except(user)
    User.where(arel_table[:id].not_eq(user.id)).order(:name)
  end

  # Leverages Twet.by_user_ids to return all twets created by this user
  # and all users that this user follows.
  #
  def all_twets
    Twet.by_user_ids(id, *follows.map(&:following_id))
  end
end
