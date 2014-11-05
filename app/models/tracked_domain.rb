class TrackedDomain < ActiveRecord::Base

  belongs_to :user
  has_many :events

  scope :recent, lambda { order("tracked_domain.updated_at DESC, tracked_domain.created_at DESC") }

end
