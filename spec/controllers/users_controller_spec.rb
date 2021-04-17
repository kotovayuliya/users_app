require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    before do
      User.create(firstname: "Taras", lastname: "Verhov", salary: 4000)
    end

    context "for json format" do
      it "returns a success response" do
        get :index, format: :json
        expect(response).to be_success
        json_response = JSON.parse(response.body).map do |user|
          user.slice("firstname", "lastname", "salary")
        end
        expect(json_response).to eq [
          {
            "firstname" => "Taras",
            "lastname" => "Verhov",
            "salary" => 4000
          }
        ]
      end
    end

    context "for html format" do
      it "returns a success response" do
        get :index
        expect(response).to be_success
        assert_template :index
      end
    end
  end

  describe "GET #show" do
    let(:user) { User.create(firstname: "Taras", lastname: "Verhov", salary: 4000) }

    it "returns a success response" do
      get :show, params: { id: user.id }
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    it "checks that user can be created" do
      expect do
        post :create, params: { user: { firstname: "Olha", lastname: "Krutelyova", salary: 8000 } }
      end.to change{ User.count }.by(1)
    end
  end

  describe "PUT #update" do
    let(:user) { User.create(firstname: "Natalia", lastname: "Kravtsova", salary: 5000) }

    it "checks that user can be updated" do
      put :update, params: { id: user.id, user: { firstname: "Olha" } }
      expect(user.reload.firstname).to eq "Olha"
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
