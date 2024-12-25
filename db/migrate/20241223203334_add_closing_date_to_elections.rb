class AddClosingDateToElections < ActiveRecord::Migration[8.0]
  def change
    add_column :elections, :closing_date, :date
    add_index :elections, :closing_date
  end
end
