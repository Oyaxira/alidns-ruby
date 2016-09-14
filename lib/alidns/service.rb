require 'json'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/object/to_query'
require 'rest-client'
require 'logging'


module Alidns
  class Service
    def initialize
      $logger = Logging.logger['alidns']
      $logger.level = Alidns.config.log_level
      $logger.add_appenders Logging.appenders.stdout, Logging.appenders.file(Alidns.config.log_file)
      @app_key = Alidns.config.app_key
      @app_secret = Alidns.config.app_secret
      @host = Alidns.config.host
    end

    def describe_domains
      params = public_params
      params["Action"] = "DescribeDomains"
      params = params_to_str(params)
      params = params + "&" + Alidns::Sign.sign("GET", @app_key, @app_secret, params)
      url = "#{Alidns.config.host}/?#{params}"
      response = RestClient.get(url)
      response.body
    end

    def describe_doname_record(domainname)
      params = public_params
      params["Action"] = "DescribeDomainRecords"
      params["DomainName"] = "#{domainname}"
      params = params_to_str(params)
      params = params + "&" + Alidns::Sign.sign("GET", @app_key, @app_secret, params)
      url = "#{Alidns.config.host}/?#{params}"
      response = RestClient.get(url)
      response.body
    end

    def update_domain_record(record_id, rr , type, value, ttl=600 , priority = 1, line="default")
      params = public_params
      params["Action"] = "UpdateDomainRecord"
      params["RecordId"] = record_id
      params["RR"] = rr
      params["Type"] = type
      params["Value"] = value
      params["TTL"] = ttl
      params["Priority"] = priority
      params["Line"] = line
      params = params_to_str(params)
      params = params + "&" + Alidns::Sign.sign("GET", @app_key, @app_secret, params)
      url = "#{Alidns.config.host}/?#{params}"
      response = RestClient.get(url)
      response.body
    end

    def public_params
      params = {}
      params["Format"] = Alidns.config.response_format
      params["Version"] = "2015-01-09"
      params["SignatureMethod"] = "HMAC-SHA1"
      params["Timestamp"] = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
      params["SignatureVersion"] = "1.0"
      params["SignatureNonce"]= rand(999999999999999999).to_s
      params["AccessKeyId"] = Alidns.config.app_key
      params
    end

    def params_to_str(params)
      params = params.to_a.map{|k| "#{k.first}=#{k.last}"}.join('&')
    end
  end
end
