class CreateDealerships < ActiveRecord::Migration[5.2]
  def change
    create_table :dealerships do |t|
      t.string :name,        null: false, default: ""
      t.string :location,    null: false, default: ""
      t.text :description,   null: false
      t.references :user,    null: false, foreign_key: true
      t.string :phone,       default: ""
      t.string :email,       default: ""

      t.timestamps
    end
  end
end
