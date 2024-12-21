class CreateVotes < ActiveRecord::Migration[8.0]
  def change
    create_table :votes do |t|
      t.references :candidate, foreign_key: true, type: :uuid
    end

    add_index :votes, :id
  end
end
