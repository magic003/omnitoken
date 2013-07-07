module GT
  Provider = Struct.new(:id, :display_name, :path)

  # auto load providers
  Provider.autoload :Twitter, 'get_token/provider/twitter'
end
