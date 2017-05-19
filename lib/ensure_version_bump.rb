require 'forwardable'
require 'json'
require 'net/http'

class EnsureVersionBump
  attr_reader :local, :remote

  def initialize(gem_name)
    @local = Local.new(gem_name)
    @remote = Remote.new(gem_name)
  end

  def success?
    local.version > remote.version
  end

  private

  def compare
    local_version > remote_version
  end

  def local_version
    Gem.loaded_specs[name].version
  end

  class Base
    attr_reader :gem_name

    def initialize(gem_name)
      @gem_name = gem_name
    end
  end # class Base
  private_constant :Base

  class Local < Base
    def version
      Gem.loaded_specs[gem_name].version
    end
  end # class Local

  class Remote < Base
    extend Forwardable
    def_delegators :url, :host, :port

    def version
      @version ||= begin
        response_version = JSON.parse(api_response.body).fetch('version')
        Gem::Version.new(response_version == 'unknown' ? 0 : response_version)
      end
    end

    private

    def api_response
      Net::HTTP.start(host, port, use_ssl: true) do |http|
        http.request(Net::HTTP::Get.new(api_endpoint))
      end
    end

    def url
      @url ||= URI.parse(api_endpoint)
    end

    def api_endpoint
      "https://rubygems.org/api/v1/versions/#{gem_name}/latest.json"
    end
  end # class Remote
end # class EnsureVersionBump
