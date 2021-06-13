require 'faraday'
require 'json'

class PublicHolidayService
  attr_reader :upcoming_3_holidays
#why is attr_reader not working? see view
  def initialize
    @upcoming_3_holidays = next_three
  end

  def next_three
    response = Faraday.get("https://date.nager.at/api/v2/NextPublicHolidays/us")
    JSON.parse(response.body, symbolize_names: true)[0..2]
  end
end
