class ProductJob < ActiveJob::Base
  queue_as :product
  def perform(*args)
    args[0].each do |url|
      good = TaoBaoApi::Good.new(url[0], url[1])
      good.get_info
    end
  end
end
