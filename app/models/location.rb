class Location < ActiveRecord::Base
  belongs_to :panel_provider, foreign_key: :external_id
  has_and_belongs_to_many :location_groups
end
