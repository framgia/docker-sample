require "rails_helper"

describe User, type: :model do
  describe "#available?" do
    let(:user){create :user, archived_at: archived_at}
    let(:archived_at){nil}
    subject{user.available?}
    context "archived_at is set" do
      let(:archived_at){Time.zone.now}
      it{is_expected.to be_falsey}
    end
    context "archived_at isn't set" do
      it{is_expected.to be_truthy}
    end
  end

  describe '#archive' do
    let(:user){create :user, archived_at: archived_at, created_at: 1.day.before(now), updated_at: 1.day.before(now)}
    let(:archived_at){nil}
    let(:now){"2019-04-04 12:34".to_datetime}
    subject{user.archive}
    context "archived_at is set" do
      let(:archived_at){Time.zone.now}
      it{expect{subject}.not_to change(user, :archived_at)}
      it{expect{subject}.not_to change(user, :updated_at)}
    end
    context "archived_at isn't set" do
      around do |e|
        travel_to(now){e.run}
        end
      it{is_expected.not_to be_nil}
      it{expect{subject}.to change(user, :archived_at).from(nil).to(now)}
      it{expect{subject}.not_to change(user, :updated_at)}
    end
  end

  describe "#archive!" do
    let(:user){create :user, archived_at: archived_at, created_at: 1.day.before(now) ,updated_at: 1.day.before(now)}
    let(:archived_at){nil}
    let(:now){"2019-04-04 12:34".to_datetime}
    subject{user.archive!}
    context "archived_at is set" do
      let(:archived_at){Time.zone.now}
      it{expect{subject}.not_to change(user, :archived_at)}
      it{expect{subject}.not_to change(user, :updated_at)}
    end
    context "archived_at isn't set" do
      around do |e|
        travel_to(now){e.run}
      end
      it{expect{subject}.to change(user, :archived_at).from(nil).to(now)}
      it{expect{subject}.to change(user, :updated_at)}
    end
  end


  describe ".multi_archive!" do
    let!(:available_user1){create :user}
    let!(:available_user2){create :user}
    let!(:unavailable_user1){create :user, :unavailable}
    let(:user_ids){[]}
    subject{described_class.multi_archive! user_ids}
    context "there are multiple id" do
      context "there are only available users" do
      end
      context "there ain't only available users" do
      end
    end
    context "there is one id" do
      context "user is available" do
        let(:user_ids){[available_user1.id]}
        it do
          expect{subject}.to change(User.available, :count).from(2).to(1)
          # ここだけ見本として書いてほしいですm(_ _)m
        end
      end
      context "user isn't available" do
      end
    end
  end
end
