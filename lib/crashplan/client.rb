require 'json'

module Crashplan
  APP_CODE = 'CPP'

  class Client
    attr_accessor :settings

    def initialize(options = {})
      @settings = Settings.new(options)
    end

    def auth(app_code = APP_CODE)
      response = post "authToken", { appCode: app_code }
      AuthResource.from_response(response)
    end

    def user(id = "my")
      response = get "user/#{id}"
      User.from_response(response)
    end

    def org(id = "my")
      response = get "org/#{id}"
      Org.from_response(response)
    end

    def ping
      response = get 'ping'
      Ping.new(response["data"])
    end

    def create_org(data = {})
      response = post "org", data
      Org.from_response(response)
    end

    def create_user(data = {})
      response = post "user", data
      User.from_response(response)
    end

    def connection
      @connection = Connection.new(
        host: settings.host,
        port: settings.port,
        scheme: settings.scheme,
        path_prefix: settings.api_root
      )
      if settings.username && settings.password
        @connection.username = settings.username
        @connection.password = settings.password
      end
      if settings.token
        @connection.token = settings.token
      end
      @connection
    end

    def get(path)
      make_request(:get, path)
    end

    def post(path, data = {})
      make_request(:post, path, data)
    end

    def make_request(method, *args)
      response = connection.make_request(method, *args)
      response_body(response)
    end

    private

    def response_body(response)
      response ? JSON.parse(response) : {}
    end
  end
end
