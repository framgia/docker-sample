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

  describe '#unavailable' do
    let(:user){create :user, archived_at: archived_at}
    let(:archived_at){nil}
    subject{user.unavailable}
    context "archived_at is set" do
      let(:archived_at){Time.zone.now}
      it{is_expected.not_to }
    end
    context "archived_at isn't set" do
      it{is_expected.not_to be_nil}
    end
  end
end
