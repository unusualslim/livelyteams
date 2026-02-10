class TeamMember < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :role

  def move_to!(team_name:, role_name:)
    new_team = Team.find_by!(name: team_name)
    new_role = Role.find_by!(role: role_name)

    update!(
      team: new_team,
      role: new_role
    )
  end
end
