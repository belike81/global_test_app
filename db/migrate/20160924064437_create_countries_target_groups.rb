class CreateCountriesTargetGroups < ActiveRecord::Migration
  def change
    create_table :countries_target_groups do |t|
      t.integer :country_id, index: true
      t.integer :target_group_id, index: true
    end
  end
end
