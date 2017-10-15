class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.references :team_one
      t.references :team_two
      t.references :winner

      t.timestamps
    end
  end
end
