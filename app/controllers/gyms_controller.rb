class GymsController < ApplicationController
  def index
    query = params[:query]
    if query.present?
      @gyms = Gym.search_by_category(query)
    else
      @gyms = Gym.all
    end
  end

  def show
    @gym = Gym.find(params[:id])
    @booking = Booking.new
    @markers = Gym.where(id: params[:id]).geocoded.map do |gym|
      {
        lat: gym.latitude,
        lng: gym.longitude
      }
    end
  end

  def new
    @gym = Gym.new
  end

  def create
    @user = current_user
    @gym = Gym.new(gym_params)
    @gym.user = current_user
    if @gym.save
      redirect_to gym_path(@gym)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @gym = Gym.find(params[:id])
  end

  def update
    @gym = Gym.find(params[:id])
    @gym.update(gym_params)
    if @gym.save
      redirect_to gym_path(@gym)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @gym = Gym.find(params[:id])
    @gym.destroy
    flash[:notice] = "Your gym listing was successfully deleted"
    redirect_to bookings_path
  end

  private

  def gym_params
    params.require(:gym).permit(:price_per_hour, :address, :name, :category, :capacity, :description, photos: [])
  end
end
