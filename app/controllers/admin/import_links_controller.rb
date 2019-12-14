class Admin::ImportLinksController < ApplicationController
  def create
    urls = params[:links].split("\r\n")
    debugger
    urls.each do |url|
      good = TaoBaoApi::Good.new(url)
      good.get_info
    end
    redirect_to admin_importlink_path
  end
end
