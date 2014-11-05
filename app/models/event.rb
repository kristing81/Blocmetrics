class Event < ActiveRecord::Base

  belongs_to :tracked_domain

  scope :recent, lambda { order("events.updated_at DESC, events.created_at DESC") }
 
 
end
