require "base64"

module Yadisk
  Credential = Struct.new(:login, :password)

  class Client
    DEFAULT_HEADER = {
      'User-Agent' => 'Yadisk Client',
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    PROTOCOL = 'https://'
    API_VERSION = 'v1'
    BASE_URL = 'cloud-api.yandex.net'

    AUTH_HEADER_TEMPLATE = "Basic %{s}" # or Auth %{s}

    attr_reader :login, :token

    def initialize(login: nil, password: nil)
      @login = login
      @password = password
      if block_given?
        credential = Credential.new
	yield credential
        @login = credential.login
        @password = credential.password
      end
      raise 'Arguments login and password are required' if @login.nil? || @password.nil?
      make_token
    end
    def make_token
      @token = Base64.encode64("#{@login}:#{@password}")
    end

    def main_url
      "#{PROTOCOL}#{BASE_URL}/#{API_VERSION}"
    end
    def headers(**kwargs)
      DEFAULT_HEADER.dup
       .merge('Authorization' => AUTH_HEADER_TEMPLATE % token)
       .merge(kwargs)
    end
    
    # https://github.com/vasiatka/YaBackup/blob/master/settings/yandex.conf.php
    # TODO: methods with works file system: mv, cp, mkdir, rm, ls
    # download, upload, publish, unpublish
  end
end
