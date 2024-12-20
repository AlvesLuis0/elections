class CreateCandidates < ActiveRecord::Migration[8.0]
  def change
    create_table :candidates, id: :uuid do |t|
      t.string :name
      t.references :election, foreign_key: true, type: :uuid
    end

    add_index :candidates, :id
    add_index :candidates, :name
  end
end
