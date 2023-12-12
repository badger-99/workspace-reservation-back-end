class Api::V1::ReservationsController < Api::V1::ApplicationController
  def index
    @reservations = Reservation.all.where(user_id: @current_user.id).order(created_at: :desc)
    render json: { reservations: @reservations }
  end

  def show
    @reservation = Reservation.find(params[:id])
    if @reservation.user_id == @current_user.id
      render json: { reservation: @reservation }, status: :ok
    else
      render json: { errors: @reservation.errors.full_messages }
    end
  end

  def create
    @workspace = Workspace.find(params[:workspace])
    if params[:start_date].to_date < Date.today || params[:end_date].to_date < Date.today
      render json: { errors: 'The selected dates cannot be in the past.' }, status: :bad_request
      return
    end
    if params[:start_date].to_date > params[:end_date].to_date
      render json: { errors: 'The start date cannot be after the end date.' }, status: :bad_request
      return
    end
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = @current_user.id
    @reservation.workspace = @workspace
    if @reservation.save
      render json: { reservation: @reservation, success: 'Reservation has been created.' }, status: :created
    else
      render json: { errors: @reservation.errors.full_messages }, status: :bad_request
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :city, :workspace)
  end
end
