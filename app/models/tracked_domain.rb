class TrackedDomain < ActiveRecord::Base
  require 'HTTParty'
  require 'nokogiri'

  belongs_to :user
  has_many :events

  before_create :set_verfication_code

  scope :recent, lambda { order("tracked_domains.updated_at DESC, tracked_domains.created_at DESC") }

  def check_verification
    url = tracked_domain.url
    # Use HTTParty to fetch the HTML of the trakced domain.
    response = HTTParty.get(url)
    # Use nokogiri using XPATH to get the content of the meta tag and compare to current tracked domain verification code.
    doc = Nokogiri::HTML(open(url).read)
    vercode = doc.xpath("//meta")
    # return true or false
    if vercode == tracked_domain.verification_code
      puts "The Domain has been verified"
    else
      puts "This Domain is not verified"
    end
  end

  protected

  def set_verfication_code
    self.verification_code = SecureRandom.hex(30)
  end

end
