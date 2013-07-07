require 'sinatra'

#before '/*' do
#  set :haml, {:layout => :layout, :format => :html5}
#end

set :haml, {:format => :html5, :layout => :layout}

get '/' do
  haml :index
end
