class CreateDestinations < ActiveRecord::Migration[6.0]
  def change
    create_table :destinations do |t|
      t.references :order   , null: false, foreign_key: true
      t.string     :zipcode , null: false
      t.integer    :area_id , null: false
      t.string     :city    , null: false
      t.string     :address , null: false
      t.string     :building 
      t.string     :phone   , null: false
      t.timestamps
    end
  end
end
