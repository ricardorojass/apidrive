class User < ActiveRecord::Base
  has_many :documents
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
