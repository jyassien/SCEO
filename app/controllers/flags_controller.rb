class FlagsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :update] 
  before_action :set_event, only: [:new, :create]

  # GET /flags or /flags.json
  def index
    @flags = Flag.all
  end

  # GET /flags/1 or /flags/1.json
  def show
    @flag = Flag.find(params[:id])
  end

  # GET /flags/new
  def new
    @flag = Flag.new
  end

  # GET /flags/1/edit
  def edit
  end

  # POST /flags or /flags.json
  def create
    @flag = Flag.new(flag_params)
  Rails.logger.debug("Flag Params: #{@flag.inspect}") 

    @flag.user = current_user
    @flag.event = @event
    @flag.flagged_at = Time.current


    if @flag.save
      redirect_to @event, notice: "Event flagged successfully."
    else
      redirect_to @event, alert: "There was an issue flagging the event."
    end

    # respond_to do |format|
    #   if @flag.save
    #     format.html { redirect_to @flag, notice: "Flag was successfully created." }
    #     format.json { render :show, status: :created, location: @flag }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @flag.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /flags/1 or /flags/1.json
  def update
    respond_to do |format|
      if @flag.update(flag_params)
        format.html { redirect_to @flag, notice: "Flag was successfully updated." }
        format.json { render :show, status: :ok, location: @flag }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flags/1 or /flags/1.json
  def destroy
    @flag.destroy!

    respond_to do |format|
      format.html { redirect_to flags_path, status: :see_other, notice: "Flag was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flag
      @flag = Flag.find(params[:id])
    end

    def flag_params
      params.require(:flag).permit(:reason, :description, :flagged_at, :user_id, :event_id)
    end

    def set_event
      @event = Event.find(params[:event_id])
    end
end
