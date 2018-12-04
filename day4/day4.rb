require '../read_file'
require 'time'


class Event
    attr_accessor :time, :event, :guard_id

    def initialize(time, event, guard_id)
        @time = time
        @event = event
        @guard_id = guard_id
    end

    def to_s
        "#{time} - #{event}" + (guard_id ? " #{guard_id}" : "")
    end
end

class Guard
    attr_accessor :id, :sleep_total, :sleep_minutes

    def initialize(id)
        @id = id
        @sleep_total = 0
        @sleep_minutes = []
    end

    def to_s
        "#{id} - #{sleep_total}"
    end
end

def get_events(input)
    events = []
    input.each do |line|
        timestamp = line.match(/\[.*\]/)[0].slice(1...-1)

        event = if line.match(/wakes/)
                    :wake
                elsif line.match(/asleep/)
                    :sleep
                else
                    :shift
                end

        guard = line.match(/#\d+/)
        guard = guard[0].slice((1..-1)) if guard

        events << Event.new(Time.parse(timestamp), event, guard)
    end

    events.sort! { |a, b| a.time - b.time }
end

input = read_file

events = get_events(input)

guards = {}

current_guard = nil
sleep_time = nil

events.each do |event|
    if event.event == :shift
        g = event.guard_id
        guards[g] ||= Guard.new(g)
        current_guard = guards[g]
    elsif event.event == :sleep
        sleep_time = event.time
    elsif event.event == :wake
        mins_asleep = (event.time - sleep_time) / 60

        current_guard.sleep_total += mins_asleep

        current_guard.sleep_minutes += (sleep_time.min...event.time.min).to_a
    end
end

# puts guards.values.sort { |a, b| a.sleep_total <=> b.sleep_total }

sleepy_guard = guards.values.sort { |a, b| a.sleep_total <=> b.sleep_total }.last

aggregate_sleep_minutes = sleepy_guard.sleep_minutes.group_by { |x| x }

sleepiest_minute = aggregate_sleep_minutes.keys.sort { |a, b| aggregate_sleep_minutes[a].length <=> aggregate_sleep_minutes[b].length }.last

puts sleepy_guard
puts sleepiest_minute

puts sleepy_guard.id.to_i * sleepiest_minute

