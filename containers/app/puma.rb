workers 1
threads_count = 5
threads threads_count, threads_count

prune_bundler

worker_timeout 300
rackup DefaultRackup
port 3000
environment ENV["RAILS_ENV"]
