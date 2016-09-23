class LocationGroup < ActiveRecord::Base
  belongs_to :panel_provider
  belongs_to :country
  has_many :locations, through: :panel_provider
end
