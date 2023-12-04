class Api::V1::ReservationsController < Api::V1::ApplicationController
  def index
    @reservations = Reservation.all.where(user_id: @current_user.id).order(created_at: :desc)
    render json: { reservations: @reservations }
  end

  def create
    @workspace = Workspace.find(params[:workspace_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user
    @reservation.workspace_id = @workspace
    if @reservation.save
      render json: { reservation: @reservation }
    else
      render json: { errors: @reservation.errors.full_messages }
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :city, :workspace_id)
  end
end
