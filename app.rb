require 'sinatra'

set :haml, {:format => :html5, :layout => :layout}


get '/' do
  @providers = []
  Dir.glob(File.join('providers', '*.yml')) do |p|
    name = File.basename(p, '.yml')
    if name.eql?('twitter')
      twitter = {}
      twitter[:name] = name
      twitter[:path] = '/auth/twitter'

      @providers << twitter
      @providers << twitter
    end
  end
  haml :index
end
