class CreateLocationGroupsLocations < ActiveRecord::Migration
  def change
    create_table :location_groups_locations do |t|
      t.integer :location_group_id, index: true
      t.integer :location_id, index: true
    end
  end
end
