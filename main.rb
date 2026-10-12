# frozen_string_literal: true

# Class Sign-Up Demo
#
# A simplified model of sign-ups for a campus recreation center's fitness
# classes. The demo schedules three sessions, books people into one of them,
# and shows what happens when a booking breaks a rule.

require_relative "session"
require_relative "schedule"

HOUR = 60 * 60

schedule = Schedule.new
spin = schedule.add(title: "Spin", capacity: 2, starts_at: Time.now + 3 * HOUR)
schedule.add(title: "Yoga", capacity: 12, starts_at: Time.now + 26 * HOUR)
schedule.add(title: "Pilates", capacity: 8, starts_at: Time.now + 5 * HOUR)

puts "Coming up:"
schedule.upcoming.each { |session| puts "  #{session.starts_at.strftime('%a %H:%M')}  #{session.title}" }
puts "Next: #{schedule.next_session.title}"

spin.book("Maya")
spin.book("Andre")
puts
spin.print_roster
puts "Spots left: #{spin.spots_left}"

puts
begin
  spin.book("Priya")
rescue ArgumentError => e
  puts "Could not book Priya: #{e.message}"
end

spin.cancel("Andre")
spin.book("Priya")
puts "After Andre cancels:"
spin.print_roster

puts
begin
  spin.book("Sam", at: spin.starts_at - 30 * 60)
rescue ArgumentError => e
  puts "Could not book Sam half an hour before: #{e.message}"
end
