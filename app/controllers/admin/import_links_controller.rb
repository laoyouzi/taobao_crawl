class Admin::ImportLinksController < ApplicationController
  def create
    urls = params[:links].split("\r\n")
    ProductJob.perform_later urls
    redirect_to admin_importlink_path
  end
end
