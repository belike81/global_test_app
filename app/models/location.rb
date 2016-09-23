class Location < ActiveRecord::Base
  belongs_to :panel_provider, foreign_key: :external_id
  has_many :location_groups, through: :panel_provider
end
