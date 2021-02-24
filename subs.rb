require 'redis'
require 'concurrent-ruby'

$bound = Concurrent::AtomicBoolean.new
$r = nil

def check
  if not ($r && ($r.ping rescue false))
    $bound.value = false
    puts "connection to redis is not established.."
  end
end

def bind
  begin
    puts "establishing connection to redis.."
    $r = Redis.new(:host => 'localhost', :port => '6379')
    $r.psubscribe("0001") do |s|
      # block ini async, exception ga akan ketangkep di rescue dibawah
      s.pmessage do |pattern, channel, msg|
        puts "channel: #{channel}"
        puts "msg: #{msg}"
      end
    end
    $bound.value = true
  rescue
    $bound.value = false
  end
end

while true
  check
  if $bound.false?
    bind
  end
  sleep 1
end