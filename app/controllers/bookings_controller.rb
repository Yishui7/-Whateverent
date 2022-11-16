class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.duration = @booking.end_time - @booking.start_time
    @booking.total_price = @booking.gym.price_per_hour * @booking.duration
    @booking.user = current_user
    @booking.status = "pending"
    @booking.gym = Gym.find(params[:gym_id])
    if @booking.save
      redirect_to(@gym)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  private

  def booking_params
    params.require(:booking_form).permit(:date, :start_time, :end_time)
  end

  def cancel_booking
    @booking.status = "inactive"
  end
end
