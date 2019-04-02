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
end
