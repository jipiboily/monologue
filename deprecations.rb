def deprecate msg
  puts "\e[#{31}m#{msg}\e[0m"
end

if RUBY_VERSION.include?("1.8.")
  deprecate "#############################################"
  deprecate "#         NOTE FOR RUBY 1.8.X USERS         #"
  deprecate "#############################################"
  deprecate "Please note that Monologue 0.2 is the last version to support Ruby 1.8."
end