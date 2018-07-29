class Applist::Scraper 
  attr_accessor :url, :doc 
  
  def self.scrape

    doc = Nokogiri::HTML(open("https://www.apple.com/itunes/charts/free-apps"))
    
    doc.css("div.section-content li").collect do |app, i|
      name = app.css("h3 a").text
      category = app.css("h4 a").text
      link = app.css("a").attribute("href").value
      details = Nokogiri::HTML(open(link, 'User-Agent' => 'firefox'))
      desc = details.css(".section__description").text
      avg_rating = details.css(".we-customer-ratings__averages__display").text
      
      apple = Applist::Apps.create(name: name, category: category, link: link, desc: desc, avg_rating: avg_rating)
      
    end

  end
end

#https://www.apple.com/itunes/charts/free-apps

# http://www.gigablast.com/get?q=https%3A%2F%2Fwww.apple.com%2Fitunes%2Fcharts%2Ffree-apps%2F&qlang=en&c=main&d=58634480158&cnsp=0