class PhotosController < ApplicationController
  def index
    client = PexelsClient.new
    @photos = client.curated
    puts "API KEY: #{ENV["PEXELS_API_KEY"]}"

    if params[:query].present?
      @photos = client.search(params[:query])
    else
      @photos = client.curated
    end
  end
end
