class TrackedDomain < ActiveRecord::Base

  belongs_to :user
  has_many :events

  before_create :set_verfication_code

  scope :recent, lambda { order("tracked_domains.updated_at DESC, tracked_domains.created_at DESC") }
  scope :verified, -> {where(verified: true)}
  
  def check_verification
    doc = Nokogiri::HTML(HTTParty.get(self.url))
    vercode = doc.xpath("//meta[@name='verification_code']").first["content"]
    if vercode == self.verification_code
      self.verified = true
      return self.save
    else
      return false
    end
  end

  protected

  def set_verfication_code
    self.verification_code = SecureRandom.hex(30)
  end

end
