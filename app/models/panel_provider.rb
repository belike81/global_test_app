class PanelProvider < ActiveRecord::Base
  has_one :country
  has_one :location_group
  has_one :target_group
end
