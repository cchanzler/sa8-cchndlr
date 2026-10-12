# frozen_string_literal: true

class Session
  CUTOFF = 60 * 60 # booking closes one hour (in seconds) before the start

  attr_reader :title, :capacity, :starts_at

  def initialize(title:, capacity:, starts_at:)
    raise ArgumentError, "Title cannot be empty" if title.strip.empty?
    raise ArgumentError, "Capacity must be at least 1" if capacity < 1

    @title = title
    @capacity = capacity
    @starts_at = starts_at
    @roster = []
  end

  # A copy, so changing it cannot change who is booked
  def roster
    @roster.dup
  end

  def spots_left
    capacity - @roster.size
  end

  def full?
    spots_left == 0
  end

  def book(name, at: Time.now)
    raise ArgumentError, "Booking has closed" if closed?(at)
    raise ArgumentError, "#{name} is already booked" if @roster.include?(name)
    raise ArgumentError, "Session is full" if full?

    @roster << name
    nil
  end

  def cancel(name)
    raise ArgumentError, "#{name} is not booked" unless @roster.include?(name)

    @roster.delete(name)
  end

  def print_roster
    puts "#{title} (#{@roster.size}/#{capacity})"
    @roster.sort.each { |name| puts "  #{name}" }
  end

  private

  def closed?(time)
    time > starts_at - CUTOFF
  end
end
