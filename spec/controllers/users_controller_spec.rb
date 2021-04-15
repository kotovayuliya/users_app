require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_success
    end

    it "returns a 200 response" do
      get :index
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #show" do
    let(:user) { User.create(firstname: "Taras", lastname: "Verhov", salary: 4000) }
    it "returns a success response" do
      get :show, params: { id: user }
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    it "checks that user can be created" do
      expect { User.create(firstname: "Olha", lastname: "Krutelyova", salary: 8000) }.to change{ User.count }.by(1)
    end
  end

  describe "PUT #update" do
    let(:user) { User.create(firstname: "Natalia", lastname: "Kravtsova", salary: 5000) }
    it "checks that user can be updated" do
      user.update(firstname: "Olha")
      expect(User.find_by(firstname: "Olha")).to eq(user)
    end
  end

  describe "DELETE #destroy" do
    let(:user) { User.create(firstname: "Elena", lastname: "Krotova", salary: 3000) }
    it "checks that user can be deleted" do
      delete :destroy, params: { id: user }
      expect(User.find_by(id: user.id)).to be_nil
    end
  end

end
