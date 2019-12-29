class TaobaoApiJob < ActiveJob::Base
  queue_as :taobao

  def perform(*args)
    Product.order('id desc').each do |product|
      good = TaoBaoApi::Good.new(product.custom_id,  product.url)
      good.get_info
    end
  end
end
