

require 'redis'

i = 0
while i < 1000
  i += 1
  r = Redis.new(:host => 'localhost', :port => '6379')
  r.publish("0001","hello !!!#{i}")
end