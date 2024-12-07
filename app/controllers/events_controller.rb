class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :new, :register, :update] 
  before_action :set_event, only: %i[ show edit update destroy register ]

  # GET /events or /events.json
  def index
    Rails.logger.debug "Filter parameter: #{params[:filter]}"

    if params[:filter].present?
      @selected_filter = params[:filter]
      @events = filter_events(@selected_filter)
    else
      @selected_filter = "All"
      @events = Event.all
    end
  end


  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    @event.user = current_user 
    @event.creator_name = current_user.full_name 

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

    # POST /events/:id/register
  # def register
  #     if @event.user == current_user
  #       redirect_to @event, alert: "You cannot register for your own event."
  #       return
  #     end
  
  #     if @event.registered_users_count >= @event.capacity
  #       redirect_to @event, alert: "Event is fully booked."
  #       return
  #     end
  
  #     @event.increment!(:registered_users_count)
  
  #     redirect_to @event, notice: "You have successfully registered for the event."
  # end
  def register
    @event = Event.find(params[:id])

    if @event.registered_users_count < @event.capacity && @event.user != current_user
      current_user.increment!(:registered_events_count)
      @event.increment!(:registered_users_count)

      redirect_to @event, notice: "You have successfully registered for the event."
    else
      redirect_to @event, alert: "Unable to register for this event."
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_path, status: :see_other, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :description, :location, :start_time, :end_time, :status, :user_id)
    end

    private

    def filter_events(filter)
      case filter.downcase
      when "upcoming"
        Event.where("start_time > ? AND status = ?", Time.current, "scheduled").order(:start_time)
      when "scheduled"
        Event.where(status: "scheduled").order(:start_time)
      when "completed"
        Event.where(status: "completed").order(:start_time)
      when "cancelled"
        Event.where(status: "cancelled").order(:start_time)
      when "no flag"
        Event.where(flags_count: "no flag").order(:start_time)
      else
        Event.all.order(:start_time)
      end
    end
end
