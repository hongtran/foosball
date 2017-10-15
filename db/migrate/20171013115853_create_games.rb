class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :team1_score
      t.integer :team2_score
      t.references :team_win
      t.references :match, foreign_key: true

      t.timestamps
    end
  end
end
