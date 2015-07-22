require 'webrick'
require 'json'

class Flash

  # controller is spawned
  # controller method runs
    # set flash now
      # flash has value on current render
    # set flash
      # flash does not have value on current render
      # flash has value on next render

  def initialize(req)
    flash_cookie = req.cookies.find { |c| c.name == "_rails_lite_app_flash" }
    @flash = flash_cookie.nil? ? {} : JSON.parse(flash_cookie.value)
  end

  def []=(key, val)
    # controller will set using this
    @flash[key] = val
  end

  def [](key)
    @flash["now"][key] if @flash["now"]
  end

  def now
    @flash["now"] ||= {}
  end

  def store_flash(res)
    @flash.delete("now")
    flash_json = { "now" => @flash }.to_json
    res.cookies << WEBrick::Cookie.new('_rails_lite_app_flash', flash_json)
  end
end
