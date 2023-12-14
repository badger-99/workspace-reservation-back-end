require 'rails_helper'

RSpec.describe Reservation, type: :model do
  before :all do
    @user = User.create(username: 'robot')
    @image = fixture_file_upload('app/assets/images/pizza meme.jpg', 'image/jpg')
    @workspace = Workspace.create(name: 'name', description: 'testing the model', price_per_day: 10, image: @image)
    Reservation.create(city: 'Reykjavik', start_date: Date.today, end_date: Date.today,
                       user_id: @user.id, workspace_id: @workspace.id, reservation_cost: 100.10)
  end

  describe 'associations' do
    it 'belongs to a user' do
      reservation = Reservation.reflect_on_association(:user)
      expect(reservation.macro).to eq(:belongs_to)
    end

    it 'belongs to a user' do
      reservation = Reservation.reflect_on_association(:workspace)
      expect(reservation.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'is valid with all attributes' do
      expect(Reservation.new(city: 'Tashkent', start_date: Date.today, end_date: Date.today,
                             user_id: @user.id, workspace_id: @workspace.id, reservation_cost: 100.10)).to be_valid
    end

    describe 'validates the start date' do
      it 'should be present' do
        reservation = Reservation.new(city: 'Reykjavik', start_date: nil, end_date: Date.today,
                                      user_id: @user.id, workspace_id: @workspace.id)
        expect(reservation).not_to be_valid
      end

      it 'cannot be blank' do
        reservation = Reservation.new(city: 'Copenhagen', start_date: '', end_date: Date.today,
                                      user_id: @user.id, workspace_id: @workspace.id)
        expect(reservation).not_to be_valid
      end
    end

    describe 'validates the end date' do
      it 'should be present' do
        reservation = Reservation.new(city: 'Oslo', start_date: Date.today, end_date: nil,
                                      user_id: @user.id, workspace_id: @workspace.id)
        expect(reservation).not_to be_valid
      end

      it 'cannot be blank' do
        reservation = Reservation.new(city: 'Vienna', start_date: Date.today, end_date: '',
                                      user_id: @user.id, workspace_id: @workspace.id)
        expect(reservation).not_to be_valid
      end
    end

    describe 'validates the city' do
      it 'should be present' do
        reservation = Reservation.new(city: nil, start_date: Date.today, end_date: Date.today,
                                      user_id: @user.id, workspace_id: @workspace.id)
        expect(reservation).not_to be_valid
      end

      it 'cannot be blank' do
        reservation = Reservation.new(city: '', start_date: Date.today, end_date: Date.today,
                                      user_id: @user.id, workspace_id: @workspace.id)
        expect(reservation).not_to be_valid
      end
    end

    describe 'validates the workspace' do
      it 'should be present' do
        reservation = Reservation.new(city: 'Stockholm', start_date: Date.today, end_date: Date.today,
                                      user_id: @user.id, workspace_id: nil)
        expect(reservation).not_to be_valid
      end

      it 'cannot be blank' do
        reservation = Reservation.new(city: 'Tokyo', start_date: Date.today, end_date: Date.today,
                                      user_id: @user.id, workspace_id: '')
        expect(reservation).not_to be_valid
      end
    end

    describe 'validates the user' do
      it 'should be present' do
        reservation = Reservation.new(city: 'Nicosia', start_date: Date.today, end_date: Date.today,
                                      user_id: nil, workspace_id: @workspace.id)
        expect(reservation).not_to be_valid
      end

      it 'cannot be blank' do
        reservation = Reservation.new(city: 'Miami', start_date: Date.today, end_date: Date.today,
                                      user_id: '', workspace_id: @workspace.id)
        expect(reservation).not_to be_valid
      end
    end

    describe 'validates reservation_cost' do
      it 'should be present' do
        reservation = Reservation.new(city: 'Nicosia', start_date: Date.today, end_date: Date.today,
                                      user_id: @user.id, workspace_id: @workspace.id, reservation_cost: nil)
        expect(reservation).not_to be_valid
      end

      it 'cannot be blank' do
        reservation = Reservation.new(city: 'Miami', start_date: Date.today, end_date: Date.today,
                                      user_id: @user.id, workspace_id: @workspace.id, reservation_cost: '')
        expect(reservation).not_to be_valid
      end
    end

    describe 'validates uniqueness' do
      it 'A workspace cannot be reserved twice in the same time and city' do
        Reservation.create(start_date: Date.today, end_date: Date.new(2023, 12, 23),
                           city: 'Dallas', workspace_id: @workspace.id, user_id: @user.id)
        reservation = Reservation.new(start_date: Date.today, end_date: Date.new(2023, 12, 23),
                                      city: 'Dallas', workspace_id: @workspace.id, user_id: @user.id)
        expect(reservation).not_to be_valid
      end
    end
  end
end
