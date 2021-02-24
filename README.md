# ruby-bg-redis-sub
A simple script to demonstrate a robust logic to subscribe to a redis channel.

docker run -d --name redis-l -p 6379:6379 redis

ruby subs.rb
ruby pubs.rb
