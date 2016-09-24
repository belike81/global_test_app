class AddIndexForParentIdToTargetGroup < ActiveRecord::Migration
  def change
    add_index :target_groups, :parent_id
  end
end
