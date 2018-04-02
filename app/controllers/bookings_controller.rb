class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_room, except: [:index]

  def index
    @bookings = current_user.booked_rooms
  end

  def create
    @booking = current_user.bookings.create(booking_params.merge({
     room:  @room }))

    redirect_to @booking.room, notice: "Thank you for booking!"
  end

  # def create
  #   @booking = current_user.bookings.new(booking_params)
  #   @booking.room_id = params[:room_id]
  #
  #   if @booking.room_available?
  #     @booking.set_total_price
  #     @booking.save
  #     redirect_to @booking.room, notice: "Thank you for booking!"
  #   else
  #     redirect_to @booking.room, notice: "Sorry! This listing is not available during the dates you requested."
  #   end
  # end

  private
  def calculate_total_price
    duration * @room.price
  end

  def duration
    checkin  =  Date.new(booking_params["starts_at(1i)"].to_i,
                         booking_params["starts_at(2i)"].to_i,
                         booking_params["starts_at(3i)"].to_i)

    checkout =  Date.new(booking_params["ends_at(1i)"].to_i,
                         booking_params["ends_at(2i)"].to_i,
                         booking_params["ends_at(3i)"].to_i)

    (checkout - checkin).to_i
  end

  def booking_params
    params.require(:booking).permit(:starts_at, :ends_at, :total)
  end

  def load_room
    @room = Room.find(params[:room_id])
  end
end
