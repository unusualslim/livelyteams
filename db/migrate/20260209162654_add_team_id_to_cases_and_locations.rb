class AddTeamIdToCasesAndLocations < ActiveRecord::Migration[7.0]
  def change
    add_reference :cases, :team, foreign_key: true, index: true
    add_reference :locations, :team, foreign_key: true, index: true
  end
end
