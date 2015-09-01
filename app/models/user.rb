class User < ActiveRecord::Base
  has_secure_password
  
  has_many :team_members
  has_many :teams, through: :team_members

  validates :email, presence: true, uniqueness: true,  on: :create
  validates :password, length: {minimum: 5}, allow_nil: true
end