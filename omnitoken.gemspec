# encoding: utf-8
require File.expand_path(File.dirname(__FILE__)) + '/omnitoken_app'

Gem::Specification.new do |s|
  s.name = "omnitoken"
  s.version = OmniTokenApp::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Minjie Zha"]
  s.email = ["minjiezha@gmail.com"]
  s.homepage = "https://github.com/magic003/omnitoken"
  s.summary = %q{OmniToken}
  s.description = %q{OmniToken is a handy tool for getting OAuth tokens from multiple providers.}
  s.license = 'MIT'

  s.add_runtime_dependency "sinatra"
  s.add_runtime_dependency "haml"
  s.add_runtime_dependency "omniauth"
  s.add_development_dependency "rack-test"

  s.files = Dir['Rakefile', 'bin/omnitoken', 'config.ru', 'omnitoken_app.rb',
                '{public,templates,views,test}/**/*', 'README*', 'Gemfile',
                'CHANGELOG*']
  s.executables = ['omnitoken']
  s.test_files = Dir['test/**/*']
end
