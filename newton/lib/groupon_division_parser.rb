require 'faraday'
require 'json'

class GrouponDivisionParser
  def initialize(entry)
    @entry ||= entry
  end

  def name
    @entry['name']
  end

  def lat
    @entry['lat']
  end

  def long
    @entry['lng']
  end

  def division_id
    @entry['id']
  end

  def timezone
    @entry['timezone']
  end

  def country
    @entry['country']
  end

  def as_json(*params)
    {
      :lat => lat,
      :long => long,
      :country => country,
      :timezone => timezone,
      :name => name,
      :division_id => division_id
    }
  end
end