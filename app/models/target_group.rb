class TargetGroup < ActiveRecord::Base
  belongs_to :panel_provider
  belongs_to :parent, class_name: 'TargetGroup'
  has_many :children, class_name: 'TargetGroup', foreign_key: 'parent_id'
  has_many :countries, through: :panel_provider
end
