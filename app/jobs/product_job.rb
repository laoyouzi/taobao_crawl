class ProductJob < ActiveJob::Base
  queue_as :product

  def perform(urls)
    urls.each do |url|
      good = TaoBaoApi::Good.new(url)
      good.get_info
    end
  end
end
