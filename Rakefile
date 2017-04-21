# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

task :console do |_t|
  require 'dotenv/load'
  Dir['./lib/**/*.rb'].each { |file| require file }
  require 'pry'
  binding.pry
end

task default: :test
