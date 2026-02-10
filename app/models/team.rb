class Team < ApplicationRecord
  has_many :team_members, dependent: :destroy
  has_many :users, through: :team_members

  has_many :cases, dependent: :nullify
  has_many :locations, dependent: :nullify
end
