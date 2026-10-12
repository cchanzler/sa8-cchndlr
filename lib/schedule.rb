# frozen_string_literal: true

require_relative "session"

class Schedule
  def initialize
    @sessions = []
  end

  def add(title:, capacity:, starts_at:)
    session = Session.new(title: title, capacity: capacity, starts_at: starts_at)
    @sessions << session
    session
  end

  def upcoming(at: Time.now)
    later = @sessions.select { |session| session.starts_at > at }
    later.sort_by { |session| session.starts_at }
  end

  def next_session(at: Time.now)
    upcoming(at: at).first
  end
end
