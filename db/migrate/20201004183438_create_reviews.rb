class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :rating,            null: false, default: 0
      t.string :title,              null: false, default: ""
      t.text :comment,              null: false
      t.boolean :visible,           null: false, default: true
      t.references :user,           null: false, foreign_key: true
      t.references :dealership,     null: false, foreign_key: true

      t.timestamps
    end
  end
end
