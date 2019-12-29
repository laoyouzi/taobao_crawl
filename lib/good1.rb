require 'faraday'
#require 'faraday_middleware'

module TaoBaoApi

  class Good
    def initialize(url)
      @url = url
      @url_info = filter_url(url)

      @conn = Faraday.new(:url => @init_url, ssl: {verify: false}) do |f|
        #f.use FaradayMiddleware::FollowRedirects , limit: 10

        f.request  :url_encoded
        f.adapter  :net_http
        #f.adapter :em_http
        f.proxy "http://221.1.232.219:53664"
        f.headers[:referer] = @init_url
        f.headers[:user_agent] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:26.0) Gecko/20100101 Firefox/26.0'
      end if @url_info
    end

    #得到产品信息
    def get_info
      return 'good.url.error' if !@url_info

      #response = @conn.get @url_info[:url]
      response = RestClient::Request.execute(method: :get, url: @url_info[:url], proxy: "http://183.161.7.30:41670")
      data = JSON.parse response.body

      title = data['data']['item']['title']

      sku_base = data['data']['skuBase']['skus']

      sku_with_prop_hash = {}
      sku_with_prop_path = sku_base.each do |obj|
        sku_with_prop_hash[obj["skuId"]] = obj["propPath"]
      end

      # props
      props = data['data']['skuBase']['props']
      # sku price quantity
      sku_price_quantity_list = data['data']['apiStack'][0]['value'].scan /"(\d*?)":{"price":{.*?"priceText":"(.*?)",.*?,"quantity":"(.*?)"/

      props_data_list = []

      @product = Product.find_or_create_by(spu: @url_info[:id]) do |p|
        p.title = title
        p.url = @url
      end

      props.each do |prop|
        pid = prop["pid"]
        prop_name = prop["name"]
        prop["values"].each do |value|
          value_name = value['name']
          vid = value['vid']
          num = [pid, vid].join(':')
          # size:L or color:red
          text = [prop_name, value_name].join(':')
          props_data_list.push([num, text])
        end
      end

      new_sku_price_quantity_list = []
      sku_price_quantity_list.each do |sku_price_quantity|
        prop_path = sku_with_prop_hash[sku_price_quantity[0]]
        if prop_path
          # [["1231", "100", "20", "123:125;565:899"]]
          new_sku_price_quantity_list.push(sku_price_quantity.push(prop_path))
        end
      end
      new_sku_price_quantity_list.each do |list|
        sku_nums = list[3].split(';')
        text_tmp_list = []
        sku_nums.each do |num|
          puts "num ===> #{num}"
         prop_data = props_data_list.find{|x| x[0] == num}
         if prop_data
           text_tmp_list.push(prop_data[1])
         end
        end
        text_tmp = text_tmp_list.join(';')
        ret = {sku: list[0], price: list[1], quantity: list[2], option_values: text_tmp}
        @product.variants.find_or_create_by(sku: ret[:sku]) do |variant|
          variant.price = ret[:price]
          variant.quantity = ret[:quantity]
          variant.option_values = ret[:option_values]
        end
      end
    end

  private
    #过滤url得到产品hash
    def filter_url(url)
      ids = /id=(\d+)/.match(url)
      return false if ids.to_a.size == 0

      id = ids.to_a.last
      #if url.include? 'tmall'
      #  url = "http://detail.tmall.com/item.htm?id=#{id}"
      #  @init_url = 'http://www.tmall.com'
      #else
      #  #url = "http://item.taobao.com/item.htm?id=#{id}"
      #  @init_url = 'http://www.taobao.com'
      #end

      time = rand(1000..9999)
      # url
      url = "https://h5api.m.taobao.com/h5/mtop.taobao.detail.getdetail/6.0/?jsv=2.4.8&appKey=12574478&t=#{time}&api=mtop.taobao.detail.getdetail&v=6.0&dataType=jsonp&ttid=2017%40taobao_h5_6.6.0&AntiCreep=true&type=jsonp&data=%7B%22itemNumId%22%3A%22#{id}%22%7D"

      {:url => url,:id => id}
    end

  end
end

