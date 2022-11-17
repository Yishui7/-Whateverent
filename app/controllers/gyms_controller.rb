class GymsController < ApplicationController
  def index
    @gyms = Gym.all
  end

  def show
    @gym = Gym.find(params[:id])
    @booking = Booking.new
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

  private

  def gym_params
    params.require(:gym).permit(:price_per_hour, :address, :name, :category, :capacity, :description, photos: [])
  end
end
