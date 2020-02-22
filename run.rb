require './config/application'

def run
  print 'robot >> '
  Requests::Process.call(gets)
  run
rescue ExitError
rescue UnknownActionError
  run
rescue StandardError => e
  puts e.message
  run
end

run
