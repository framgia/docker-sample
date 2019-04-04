require "rails_helper"

RSpec.describe UsersController, type: :request do
  let!(:available_user){create :user}
  let!(:unavailable_user){create :user, :unavailable}
  
  describe "GET #index" do
    it do
      get users_url
      expect(response.status).to eq 200
    end
  end
  describe "GET #show" do
    context "id exists" do
      context "user is available" do
        it do
          get user_url(id: available_user.id)
          expect(response.status).to eq 200
        end
      end
      context "user isn't available" do
        it do
          get user_url(id: unavailable_user.id)
          expect(response.status).to eq 404
        end
      end
    end
    context "id doesn't exist" do
      it do
        get user_url(id: "x123")
        expect(response.status).to eq 404
      end
    end
  end

  describe "DELETE #destroy" do
    context "id exists" do
      context "user is available" do
        context "tere is one user" do
        end
        context "there are multiple user" do
        end
      end
      context "user isn't available" do
      end
    end
    context "id doesn't exist" do
      it do
        get user_url(id: "x123"), params:{_method: :delete}
        expect(response.status).to eq 404
      end
    end
  end
end
