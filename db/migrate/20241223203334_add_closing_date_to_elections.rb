class AddClosingDateToElections < ActiveRecord::Migration[8.0]
  def change
    add_column :elections, :closing_date, :date
  end
end
