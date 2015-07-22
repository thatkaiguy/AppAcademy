require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      app_cookie = req.cookies.find { |c| c.name == "_rails_lite_app" }
      @cookie = app_cookie.nil? ? {} : JSON.parse(app_cookie.value)
    end

    def [](key)
      @cookie[key]
    end

    def []=(key, val)
      @cookie[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      cookie_json = @cookie.to_json
      res.cookies << WEBrick::Cookie.new('_rails_lite_app', cookie_json)
    end
  end
end
