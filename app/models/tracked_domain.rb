class TrackedDomain < ActiveRecord::Base

  belongs_to :user
  has_many :events

  before_create :set_verfication_code

  scope :recent, lambda { order("tracked_domains.updated_at DESC, tracked_domains.created_at DESC") }

  def check_verification
    doc = Nokogiri::HTML(HTTParty.get(self.url))
    vercode = doc.xpath("//meta[@name='verfication_token']").first["content"]
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
