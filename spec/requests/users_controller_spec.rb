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
    let!(:available_user1){create :user}
    let!(:available_user2){create :user}
    let!(:unavailable_user1){create :user, :unavailable}

    context "id exists" do
      context "user is available" do
        context "there is one user" do
          it do
            delete user_url(id: available_user1.id)
            expect(response).to redirect_to(users_url)
          end
          it do
            delete user_url(id: available_user1.id)
            expect(available_user1.reload.archived_at).not_to be_nil
          end
        end
        context "there are multiple user" do
          context "there are only available user" do
            it do
              delete user_url(id: "#{available_user1.id},#{available_user2.id}")
              expect(response).to redirect_to(users_url)
              expect(available_user1.available?).to be_falsey
              expect(available_user2.available?).to be_falsey
            end
          end
          context "there ain't only available user" do
            it do
              delete user_url(id: "#{available_user1.id},#{unavailable_user1},#{available_user2.id}")
              expect(response.status).to eq 404
              expect(available_user1.available?).to be_truthy
              expect(available_user2.available?).to be_truthy
            end
          end
        end
      end
      context "user isn't available" do
        it do
          delete user_url(id: unavailable_user.id)
          expect(response.status).to eq 404
        end
      end
    end
    context "id doesn't exist" do
      it do
        delete user_url(id: "x123")
        expect(response.status).to eq 404
      end
    end
  end
end
