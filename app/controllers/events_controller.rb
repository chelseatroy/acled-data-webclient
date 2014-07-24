class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
  end

  def create
    @event = Unirest.post("http://localhost:3000/events.json", 
                          headers:{ "Accept" => "application/json"},
                          parameters: attributes_hash).body
    puts @event
    redirect_to event_path(@event["id"])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Unirest.patch("http://localhost:3000/events.json", 
                          headers:{ "Accept" => "application/json"},
                          parameters: attributes_hash).body
    puts @event
    redirect_to event_path(@event["id"])
  end

  def destroy
    @event = Unirest.delete("http://localhost:3000/events/#{params[:id]}.json", headers:{ "Accept" => "application/json" }).body
    redirect_to events_path
  end

  private

  def attributes_hash
    {:event => {
                :event_date => params[:event_date], 
                :event_type => params[:event_type], 
                :actor1 => params[:actor1], 
                :actor2 => params[:actor2], 
                :country => params[:country], 
                :source => params[:source], 
                :notes => params[:notes], 
                :total_fatalities => params[:total_fatalities], 
                :latitude => params[:latitude], 
                :longitude => params[:longitude]
              }
            }
  end

end
