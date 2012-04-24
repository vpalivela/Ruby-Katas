require './kata.rb'

def run

  growl_path = 'C:\program files (x86)\Growl for Windows\growlnotify.exe'

  text = `rspec spec`

  text.gsub!('"', "'")

  text = text + "\n\n---"

  puts text
end

watch ('.*.rb$') { run }
