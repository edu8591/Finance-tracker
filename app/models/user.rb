class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_stocks, dependent: :destroy
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def under_stock_limit?
    stocks.count < 10
  end

  def stock_already_tracked?(ticker)
    stock = Stock.check_db(ticker)
    return false unless stock

    stocks.where(id: stock.id).exists?
  end

  def can_track_stock?(ticker)
    under_stock_limit? && !stock_already_tracked?(ticker)
  end

  def full_name
    first_name || last_name ?  "#{first_name} #{last_name}" : 'Anonymous'
  end

  def self.search(param)
    param.strip!
    to_return = first_name_matches(param) + last_name_matches(param) + email_matches(param)
    return nil unless to_return

    to_return.uniq
  end

  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def not_friends_with?(friend)
    !self.friends.include? friend
  end
end
