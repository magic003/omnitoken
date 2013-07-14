require 'sinatra/base'
require 'haml'
require 'omniauth'

require 'yaml'

# This is the Sinatra application for getting tokens.
class OmniTokenApp < Sinatra::Base
  # version number 
  VERSION = '0.0.1'

  # configuration folder for various OAuth providers
  PROVIDER_DIR = 'providers'

  enable :sessions
  set :haml, {:format => :html5, :layout => :layout}

  before '/*' do
    # load providers only once
    load_providers() unless loaded?
  end

  # home page
  get '/' do
    haml :index
  end

  # callback route for providers
  get "#{OmniAuth.config.path_prefix}/:provider/callback" do |p|
    auth = env['omniauth.auth']
    provider = get_provider(p)
    not_found if provider.nil?
    # get the arguments and provided values for the provider
    args = {}
    provider[:klass].args.each do |arg|
      args[arg] = provider[:args].shift
    end
    haml :results, :locals => { auth: env['omniauth.auth'], args: args}
  end

  # OAuth failure route
  get "#{OmniAuth.config.path_prefix}/failure" do
    [400, haml(:error, :locals => { message: params[:message] })]
  end

  not_found do
    [404, haml(:error, :locals => { message: "Page Not Found" })]
  end


  private

  # Checks whether providers have been loaded
  def loaded?
    not (@providers.nil? || @providers.empty?)
  end

  # Gets the loaded provider by name
  def get_provider(name)
    provider = nil
    @providers.each do |p|
      provider = p if p[:id].eql?(name.to_sym)
    end
    provider
  end

  # Loads providers from the configuration files
  def load_providers
    @providers = []
    Dir.glob(File.join(PROVIDER_DIR, '*.yml')) do |file|
      name = File.basename(file, '.yml').to_sym
      # require ruby files for the strategy
      strategy = require_strategy(name)
      @providers << { id: name,
                      display_name: OmniAuth::Utils.camelize(name),
                      path: "#{OmniAuth.config.path_prefix}/#{name}",
                      args: read_strategy_arg(strategy, file),
                      klass: strategy
                    }
    end

    # set the strategies as a middleware
    use_strategy_middleware
  end

  # Sets the OmniAuth builder as a middleware
  def use_strategy_middleware
    providers = @providers
    self.class.use OmniAuth::Builder do
      providers.each do |p|
        provider p[:id], *p[:args]
      end
    end
  end

  # Reads the arguments for a strategy from the configuration file.
  def read_strategy_arg(strategy, file) 
    args = []
    yaml = YAML::load(File.open(file))
    strategy.args.each do |arg|
      if yaml[arg.to_s].nil?
        fail "The #{arg} argument is not provided in #{file}."
      else
        args << yaml[arg.to_s]
      end
    end
    args
  end

  # Requires the ruby file for a strategy.
  def require_strategy(name)
    begin
      require "omniauth-#{name}"
      OmniAuth::Strategies.const_get(OmniAuth::Utils.camelize(name))
    rescue LoadError => e
      fail e, "Could not find matching strategy for #{name}. You may need to install an additional gem (such as omniauth-#{name})."
    end
  end

  # Run this application
  run! if app_file == $0

end
