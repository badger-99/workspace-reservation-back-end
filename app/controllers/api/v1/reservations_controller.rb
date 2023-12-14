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
    start = Date.parse(params[:start_date])
    ending = Date.parse(params[:end_date])
    # puts(start)
    # puts(ending)

    if start < Date.today || ending < Date.today
      render json: { errors: 'The selected dates cannot be in the past.' }, status: :bad_request
      return
    end

    if start > ending
      render json: { errors: 'The start date cannot be after the end date.' }, status: :bad_request
      return
    end
    @reservation = Reservation.new(reservation_params)

    # Same-day dates have a 0-day difference, and 2 consecutive dates have a 1-day difference, and so on.
    # To account for this, 1 is added to the difference between start and end dates to get the total number of days
    # in those dates.
    days = (ending - start) + 1
    @reservation.reservation_cost = @workspace.price_per_day * days
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
    params.require(:reservation).permit(:start_date, :end_date, :city, :workspace, :reservation_cost)
  end
end
