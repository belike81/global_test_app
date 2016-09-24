require 'open-uri'

class ProviderPriceFetcher
  PROVIDER_LOGIC = {
    '1' => :logic_one,
    '2' => :logic_two,
    '3' => :logic_three
  }

  def initialize(provider)
    @provider = provider
    @price = 0
  end

  def get_price
    send(PROVIDER_LOGIC[@provider.code]) if @price == 0
    @price
  end

  private

  def logic_one
    open('http://time.com') do |page|
      page.each_line do |line|
        @price += line.count('a')
      end
    end
    @price = @price/100.0
  end

  def logic_two
    open('https://ajax.googleapis.com/ajax/services/feed/find?v=1.0&q=news') do |page|
      page.each_line do |line|
        @price += line.scan(/\\u003cb\\u003e/).count
      end
    end
  end

  def logic_three
    page  = Nokogiri::HTML(open('http://time.com'))
    page.traverse { |n| @price += 1 if n.element? }
    @price = @price/100.0
  end
end