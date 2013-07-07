module GT
  class Provider::Twitter < Provider
    def initialize
      super(:twitter, 'Twitter', '/auth/twitter')
    end
  end
end
