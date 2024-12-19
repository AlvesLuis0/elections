class CreateElections < ActiveRecord::Migration[8.0]
  def change
    create_table :elections, id: :uuid do |t|
      t.string :title
      t.text :description
    end

    add_index :elections, :id
  end
end
