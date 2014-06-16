class User < ActiveRecord::Base
  has_secure_password

  has_many :feeds
  has_many :favorite_articles, dependent: :destroy
  has_many :articles, through: :favorite_articles

  validates :email, email: true, presence: true, uniqueness: true

  before_create :generate_api_token

  def refresh_api_token!
    generate_api_token
    save
  end

  def generate_api_token
    self.api_token = Digest::SHA1.hexdigest([Rails.configuration.secret_token, Time.now.to_f.to_s].join)
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user
      user.authenticate(password)
    end
  end
end