require 'sinatra'

$:.unshift(File.dirname(__FILE__) + '/lib') unless
  $:.include?(File.dirname(__FILE__) + '/lib') || $:.include?(File.expand_path(__FILE__ + '/lib'))

require 'get_token'

set :haml, {:format => :html5, :layout => :layout}


get '/' do
  @providers = []
  Dir.glob(File.join('providers', '*.yml')) do |p|
    name = File.basename(p, '.yml')
    if GT::Registry.instance[name]
      @providers << GT::Registry.instance[name]
    end
  end
  haml :index
end
