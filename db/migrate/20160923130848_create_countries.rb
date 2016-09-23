class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.integer :country_code
      t.integer :panel_provider_id
    end
  end
end
