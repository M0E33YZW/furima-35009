class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user,         null: false, foreign_key: true
      t.string     :title,        null: false 
      t.string     :description,  null: false 
      t.integer    :category_id,  null: false 
      t.integer    :status_id,    null: false 
      t.integer    :shipping_id,  null: false
      t.integer    :area_id,      null: false
      t.integer    :day_id,       null: false
      t.integer    :price,        null: false
      t.timestamps
    end
  end
end
