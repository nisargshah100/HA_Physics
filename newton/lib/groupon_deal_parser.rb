class GrouponDealParser
  def initialize(entry)
    @entry ||= entry
  end

  def id
    @entry['options'].first['id']
  end

  def title
    @entry['title']
  end

  def date_added
    DateTime.parse(@entry['startAt']) if @entry['startAt']
  end

  def quantity
    @entry['soldQuantity']
  end

  def end_date
    DateTime.parse(@entry['endAt']) if @entry['endAt']
  end

  def price
    @entry['options'].first['price']['amount']
  end

  def value
    @entry['options'].first['discount']['amount']
  end

  def subtitle
    @entry['announcementTitle']
  end

  def original_url
    @entry['dealUrl']
  end

  def affiliate_url
    original_url
  end

  def image_url
    @entry['largeImageUrl']
  end

  def source
    @entry['type']
  end

  def division_name
    @entry['division']['name']
  end

  def division_latlon
    [ @entry['division']['lat'].to_f, @entry['division']['lng'].to_f]
  end

  def category
    @entry['tags'][0]['name'] if @entry['tags'] and @entry['tags'].length > 0
  end

  def subcategory
    @entry['tags'][1]['name'] if @entry['tags'] and @entry['tags'].length > 1
  end

  def as_json(*params)
    {
      :title => title,
      :date_added => date_added,
      :end_date => end_date,
      :price_cents => price,
      :value_cents => value,
      :subtitle => subtitle,
      :original_url => original_url,
      :affiliate_url => affiliate_url,
      :image_url => image_url,
      :division_name => division_name,
      :division_latlon => division_latlon,
      :source => source
    }
  end
end