
require "spec_helper"
require_relative "../lib/session"

RSpec.describe Session do
  let(:start_time) { Time.new(2026, 10, 20, 18, 0) }

  let(:session) do
    Session.new(
      title: "Spin",
      capacity: 2,
      starts_at: start_time
    )
  end

  let(:early) { start_time - 2 * 60 * 60 }

  describe "#initialize" do
    context "when capacity is valid" do
      it "allows a capacity of 1" do
        session = Session.new(
          title: "Spin",
          capacity: 1,
          starts_at: start_time
        )

        expect(session.capacity).to eq(1)
      end

      it "allows a capacity greater than 1" do
        session = Session.new(
          title: "Spin",
          capacity: 12,
          starts_at: start_time
        )

        expect(session.capacity).to eq(12)
      end
    end

    context "when capacity is less than 1" do
      it "rejects a capacity of 0" do
        expect {
          Session.new(title: "Spin", capacity: 0, starts_at: start_time)
        }.to raise_error(ArgumentError, "Capacity must be at least 1")
      end

      it "rejects a negative capacity" do
        expect {
          Session.new(title: "Spin", capacity: -1, starts_at: start_time)
        }.to raise_error(ArgumentError, "Capacity must be at least 1")
      end
    end
  end

  describe "#book" do
    context "when spots are available" do
      it "adds the name to the roster" do
        session.book("Ada", at: early)

        expect(session.roster).to eq(["Ada"])
      end

      it "decreases spots left by one" do
        expect {
          session.book("Ada", at: early)
        }.to change { session.spots_left }.by(-1)
      end
    end

    context "when the session is full" do
      it "rejects another booking" do
        session.book("Ada", at: early)
        session.book("Maya", at: early)

        expect {
          session.book("Sam", at: early)
        }.to raise_error(ArgumentError, "Session is full")
      end
    end
  end
end
