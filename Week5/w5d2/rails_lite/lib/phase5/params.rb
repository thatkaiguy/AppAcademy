require 'uri'
require 'byebug'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = {}

      query_params = {}
      unless req.query_string.nil?
        query_params = parse_www_encoded_form(req.query_string)
      end

      body_params = {}
      unless req.body.nil?
        body_params = parse_www_encoded_form(req.body)
      end

      merged_params = {}
      [route_params, query_params, body_params].each do |param_hash|
        merged_params.merge!(param_hash)
      end

      merged_params.each do |k,v|
        self[k] = v
      end
    end

    def [](key)
      @params[key.to_sym]
    end

    def []=(key, val)
      @params[key.to_sym] = val
    end

    # this will be useful if we want to `puts params` in the server log
    def to_s
      @params.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      params = {}
      #['user', 'address', 'street']
      #{ user: {} }
      #{ user: { address: {} } }
      #{ user: { address: { street: 'blah st' } }
      URI::decode_www_form(www_encoded_form).each do |entry|
        keys = parse_key(entry.first)
        curr_hash = nil
        if keys.count > 1
          #nested keys
          keys.take(keys.count - 1).each do |key|
            if curr_hash
              curr_hash[key] ||= {}
              curr_hash = curr_hash[key]
            else
              params[key] ||= {}
              curr_hash = params[key]
            end
          end
          curr_hash[keys.last] = entry.last
        elsif keys.count == 1
          #top level
          params[keys.last] = entry.last
        else
          raise "no params"
        end
      end
      params
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
