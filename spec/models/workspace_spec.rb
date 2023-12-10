require 'rails_helper'

RSpec.describe Workspace, type: :model do
  let(:image) { fixture_file_upload('app/assets/images/pizza meme.jpg', 'image/jpg') }

  describe 'validations' do
    describe 'validates the name' do
      it 'has to be present' do
        workspace = Workspace.create(name: nil, description: 'testing the model', image:)
        expect(workspace).not_to be_valid
      end

      it 'has to be unique' do
        Workspace.create(name: 'name', description: 'testing the model', image:)
        workspace = Workspace.new(name: 'name', description: 'this one is not unique', image:)
        expect(workspace).not_to be_valid
      end

      it 'cannot be blank' do
        workspace = Workspace.create(name: '', description: 'testing the model', image:)
        expect(workspace).not_to be_valid
      end
    end

    describe 'validates the description' do
      it 'has to be present' do
        workspace = Workspace.create(name: 'name', description: nil, image:)
        expect(workspace).not_to be_valid
      end

      it 'cannot be blank' do
        workspace = Workspace.create(name: 'name', description: '', image:)
        expect(workspace).not_to be_valid
      end
    end

    it 'must have an image' do
      workspace = Workspace.create(name: 'name', description: 'testing the model', image: nil)
      expect(workspace).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many reservations' do
      workspace = Workspace.reflect_on_association(:reservations)
      expect(workspace.macro).to eq(:has_many)
    end

    it 'destroys the associated reservation when destroyed' do
      user = User.create(username: 'bot')
      workspace = Workspace.create(name: 'name', description: 'testing the model', image:)
      Reservation.create(city: 'Reykjavik', start_date: Date.today, end_date: Date.today,
                         user_id: user.id, workspace_id: workspace.id)
      expect { workspace.destroy }.to change { Reservation.count }.by(-1)
    end

    it 'has one attached image' do
      workspace = Workspace.create(name: 'name', description: 'testing the model', image:)
      expect(workspace).to respond_to(:image)
      expect(workspace.image).to be_an_instance_of(ActiveStorage::Attached::One)
    end
  end

  it 'returns the image URL' do
    workspace = Workspace.create(name: 'name', description: 'testing the model', image:)
    expect(URI.parse(workspace.image_url)).to be_a(URI::HTTP)
    expect { URI.parse(workspace.image_url) }.not_to raise_error
  end
end
