class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.references :player1
      t.references :player2

      t.timestamps
    end
  end
end
