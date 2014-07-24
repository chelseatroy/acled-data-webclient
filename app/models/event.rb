class Event

  attr_accessor :id, :event_date, :event_type, :actor1, :actor2, :country, :source, :notes, :total_fatalities, :latitude, :longitude, :created_at, :updated_at

  def initialize(attributes)
    @id = attributes["id"]
    @event_date = attributes["event_date"]
    @event_type = attributes["event_type"]
    @actor1 = attributes["actor1"]
    @actor2 = attributes["actor2"]
    @country = attributes["country"]
    @source = attributes["source"]
    @notes = attributes["notes"]
    @total_fatalities = attributes["total_fatalities"]
    @latitude = attributes["latitude"]
    @longitude = attributes["longitude"]
    @created_at = attributes["created_at"]
    @updated_at = attributes["updated_at"]
  end

  def self.find(id)
    hash = Unirest.get("http://localhost3000/events/#{id}.json", 
                        headers:{ "Accept" => "application/json" }).body
    Event.new(hash)
  end

  def self.all
    array = Unirest.get("http://localhost:3000/events.json", headers:{ "Accept" => "application/json" }).body
    events = []
    array.each do |event|
      events << Event.new(event)
    end
    events
  end
end