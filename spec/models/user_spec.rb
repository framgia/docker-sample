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
  describe "#unavailable!" do
    let(:user){create :user, archived_at: archived_at, created_at: 1.day.before(now) ,updated_at: 1.day.before(now)}
    let(:archived_at){nil}
    let(:now){"2019-04-04 12:34".to_datetime}
    subject{user.unavailable!}
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
end
