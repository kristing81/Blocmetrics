class User < ActiveRecord::Base

  has_many :tracked_domains

end
