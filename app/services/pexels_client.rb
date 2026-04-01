require "net/http"
require "json"

class PexelsClient
  def search(query)
    make_request(URI("https://api.pexels.com/v1/search?query=#{query}"))  
  end

  def curated
    make_request(URI("https://api.pexels.com/v1/curated"))   
  end

  def make_request(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = ENV["PEXELS_API_KEY"]

    response = http.request(request)

    data = JSON.parse(response.body)

    photos = data["photos"] || []

    photos.map do |photo|
    {
      id: photo["id"],
      image_url: photo["src"]["medium"],
      photographer: photo["photographer"],
      photographer_url: photo["photographer_url"]
    }
    end    
  end  
end