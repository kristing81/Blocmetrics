desc "Check Verification Code"
task :verification_code => :environment do
  require 'nokogiri'
  require 'Httparty'

  #@tracked_domain = TrackedDomain.find(:id)
    url = tracked_domain.url
    # Use HTTParty to fetch the HTML of the trakced domain.
    response = HTTParty.get(url)

    # Use nokogiri using XPATH to get the content of the meta tag and compare to current tracked domain verification code.
    doc = Nokogiri::HTML(open(url).read)
    vercode = doc.xpath("//meta")
    # return true or false
    if vercode == url.verification_code
      puts "The Domain has been authorized"
    else
      puts "This Domain is not authorized"
    end
  
end