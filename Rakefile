# frozen_string_literal: true

require 'rake/testtask'
require 'bundler/gem_tasks'

Rake::TestTask.new do |task|
  task.libs << 'lib'
  task.libs << 'spec'
  task.pattern = 'spec/**/*_spec.rb'
end

task default: [:test]
