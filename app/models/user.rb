class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
#  devise :database_authenticatable, :registerable,
 #        :recoverable, :rememberable, :trackable, :validatable
         # :confirmable
  has_many :cases
  has_many :tasks
  has_many :comment
  has_many :cases, through: :case_users

#  has_many :team_members
#  has_many :teams, through: :team_members
#  has_many :roles, through: :team_members
end
