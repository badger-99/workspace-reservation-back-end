class Api::V1::ReservationsController < Api::V1::ApplicationController
  def index
    @reservations = Reservation.all.where(user_id: @current_user.id).order(created_at: :desc)
    render json: { reservations: @reservations }
  end

  def show
    @reservation = Reservation.find(params[:id])
    if @reservation.user_id == @current_user.id
      render json: { reservation: @reservation }
    else
      render json: { errors: @reservation.errors.full_messages }
    end
  end

  def create
    @workspace = Workspace.find(params[:workspace])
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = @current_user.id
    @reservation.workspace = @workspace
    if @reservation.save
      render json: { reservation: @reservation, success: 'Reservation has been created.' }
    else
      render json: { errors: @reservation.errors.full_messages }
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :city, :workspace)
  end
end
