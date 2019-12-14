class TaobaoApiJob < ActiveJob::Base
  queue_as :taobao

  def perform(*args)
    Product.all.each do |product|
      good = TaoBaoApi::Good.new(product.url)
      good.get_info
    end
  end
end
