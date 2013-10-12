class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.string :name
      t.text :description
      t.string :company
      t.text :address
      t.date :start_date
      t.date :end_date
      t.string :status
      t.float :amount
      t.float :interest_rate
      t.string :time_period
      t.string :description_typetext
      t.text :description_fulltext

      t.timestamps
    end
  end
end
