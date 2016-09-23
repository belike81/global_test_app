class Country < ActiveRecord::Base
  belongs_to :panel_provider
  has_one :location_group
  has_many :locations, through: :location_group
  has_many :target_groups, through: :panel_provider
end
