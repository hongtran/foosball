class RemoveColumnsFromTeams < ActiveRecord::Migration[5.1]
  def change
    remove_reference :teams, :player1
    remove_reference :teams, :player2
  end
end
