require 'sinatra/base'
require 'haml'
require 'omniauth'

require 'yaml'

class GetTokenApp < Sinatra::Base
  PROVIDER_DIR = 'providers'

  enable :sessions
  set :haml, {:format => :html5, :layout => :layout}

  get '/' do
    load_providers() unless loaded?
    haml :index
  end


  private

  def loaded?
    not (@providers.nil? || @providers.empty?)
  end

  def load_providers
    @providers = []
    Dir.glob(File.join(PROVIDER_DIR, '*.yml')) do |file|
      name = File.basename(file, '.yml').to_sym
      strategy = require_strategy(name)
      @providers << { id: name,
                      display_name: OmniAuth::Utils.camelize(name),
                      path: "#{OmniAuth.config.path_prefix}/#{name}",
                      args: read_strategy_arg(strategy, file)
                    }
    end

    use_strategy_middleware
  end

  def use_strategy_middleware
    providers = @providers
    self.class.use OmniAuth::Builder do
      providers.each do |p|
        provider p[:id], *p[:args]
      end
    end
  end

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

  def require_strategy(name)
    begin
      require "omniauth-#{name}"
      OmniAuth::Strategies.const_get(OmniAuth::Utils.camelize(name))
    rescue LoadError => e
      fail e, "Could not find matching strategy for #{name}. You may need to install an additional gem (such as omniauth-#{name})."
    end
  end

  run! if app_file == $0

end
