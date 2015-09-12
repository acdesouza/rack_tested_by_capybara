require 'rake/testtask'

desc "Runs all tests in test folder"
Rake::TestTask.new do |t|
  ENV['RACK_ENV'] = 'test'

  t.libs = [
    File.realpath('.'),
    File.realpath('test/'),
    File.realpath('lib/test/')
  ]

  t.test_files = Dir.glob('test/**/*_test.rb')
end
