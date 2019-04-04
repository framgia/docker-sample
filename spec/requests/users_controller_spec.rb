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
      end
      context "user isn't available" do
      end
    end
    context "id doesn't exist" do
    end
  end
end
