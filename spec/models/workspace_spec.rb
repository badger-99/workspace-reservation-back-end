require 'rails_helper'

RSpec.describe Workspace, type: :model do
  before :all do
    @user = User.create(username: 'bot')
    @image = fixture_file_upload('app/assets/images/pizza meme.jpg', 'image/jpg')
    @taken_workspace = Workspace.create(name: 'workspace', description: 'testing the model', image: @image)
    # sleep(10)
    Reservation.create(city: 'Zagreb', start_date: Date.today, end_date: Date.today,
                       user_id: @user.id, workspace_id: @taken_workspace.id)
  end

  describe 'validations' do
    it 'is valid with attributes (name, description, image)' do
      expect(Workspace.new(name: 'valid', description: 'testing the model', image: @image)).to be_valid
    end

    describe 'validates the name' do
      it 'has to be present' do
        expect(Workspace.new(name: nil, description: 'testing the model', image: @image)).not_to be_valid
      end

      it 'has to be unique' do
        expect(Workspace.new(name: 'workspace', description: 'this one is not unique', image: @image)).not_to be_valid
      end

      it 'cannot be blank' do
        expect(Workspace.new(name: '', description: 'testing the model', image: @image)).not_to be_valid
      end
    end

    describe 'validates the description' do
      it 'has to be present' do
        expect(Workspace.new(name: 'name', description: nil, image: @image)).not_to be_valid
      end

      it 'cannot be blank' do
        expect(Workspace.new(name: 'name', description: '', image: @image)).not_to be_valid
      end
    end

    it 'must have an image' do
      expect(Workspace.new(name: 'name', description: 'testing the model', image: nil)).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many reservations' do
      workspace = Workspace.reflect_on_association(:reservations)
      expect(workspace.macro).to eq(:has_many)
    end

    it 'destroys the associated reservation when destroyed' do
      expect { @taken_workspace.destroy }.to change { Reservation.count }.by(-1)
    end
  end

  describe 'images' do
    before :all do
      @workspace_images = Workspace.create(name: 'images', description: 'testing the model', image: @image)
    end

    it 'has one attached image' do
      expect(@workspace_images).to respond_to(:image)
      expect(@workspace_images.image).to be_an_instance_of(ActiveStorage::Attached::One)
    end

    it 'returns the image URL' do
      expect(URI.parse(@workspace_images.image_url)).to be_a(URI::HTTP)
      expect { URI.parse(@workspace_images.image_url) }.not_to raise_error
    end
  end
end
