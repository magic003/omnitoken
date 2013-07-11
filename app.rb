require 'sinatra/base'

$:.unshift(File.dirname(__FILE__) + '/lib') unless
  $:.include?(File.dirname(__FILE__) + '/lib') || $:.include?(File.expand_path(__FILE__ + '/lib'))

require 'get_token'

class GetTokenApp < Sinatra::Base
  set :haml, {:format => :html5, :layout => :layout}

  def initialize(app=nil)
    super(app)
    @providers = []
    Dir.glob(File.join('providers', '*.yml')) do |p|
      name = File.basename(p, '.yml')
      if GT::Registry.instance[name]
        @providers << GT::Registry.instance[name]
      end
    end
  end

  get '/' do
    haml :index
  end

  run! if app_file == $0

end
