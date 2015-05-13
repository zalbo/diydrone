
require 'clockwork'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  # handler receives the time when job is prepared to run in the 2nd argument
  # handler do |job, time|
  #   puts "Running #{job}, at #{time}"
  # end

  every(1.day, 'suck tv', :at => '00:00'){
    `rake suck_tv:suck`
  }

end
