class Admin::ImportLinksController < ApplicationController
  def create
    urls = params[:links].split("\r\n")
    url_arr = urls.each_with_object([]) do |url, arr|
      new_url = url.split(";")
      arr << [new_url[0], new_url[1]]
    end
    #url_arr.each do |url|
    #  good = TaoBaoApi::Good.new(url[0], url[1])
    #  good.get_info
    #end
    ProductJob.perform_later url_arr
    redirect_to admin_importlink_path
  end
end
