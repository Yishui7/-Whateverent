class BookingsController < ApplicationController
  def index
    @users_gyms = current_user.gyms

    @user_gym_booking_requests = []
    @users_gyms.each do |gym|
      @user_gym_booking_requests.push(gym.bookings)
    end
    @user_gym_booking_requests.flatten!

    @bookings_pending = @user_gym_booking_requests.select do |gym|
                        gym.status = "pending"
    end
    @bookings_confirmed = @user_gym_booking_requests.select do |gym|
      gym.status = "confirmed"
    end
    @bookings_rejected = @user_gym_booking_requests.select do |gym|
      gym.status = "rejected"
    end
    @bookings_cancelled = @user_gym_booking_requests.select do |gym|
      gym.status = "cancelled"
    end

    @booking_requests = current_user.bookings

  end

  def create
    @gym = Gym.find(params[:gym_id])
    @booking = Booking.new(booking_params)
    @booking.duration = (@booking.end_time - @booking.start_time) / 3600
    @booking.total_price = @gym.price_per_hour * @booking.duration
    @booking.user = current_user
    @booking.status = "pending"
    @booking.gym = Gym.find(params[:gym_id])
    if @booking.save
      redirect_to bookings_path
    else
      render "gyms/show", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update

  end

  private

  def booking_params
    params.require(:booking).permit(:date, :start_time, :end_time, :clients)
  end

  def user_params
    params.require(:user).permit(:active)
  end

  def cancel_booking
    @booking.status = "inactive"
  end
end
