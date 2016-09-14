require 'securerandom'
require 'base64'
require 'digest/sha1'
require 'uri'

module Alidns
  module Sign
    # 生成sign数据
    def self.sign(method, app_key, app_secret, params)
      #排序
      req_params = params.split('&').map{|k| k.split '='}.sort_by!{ |k| k.first}.map{|k| "#{k.first}=#{k.last}"}.join('&')
      req_params = URI.encode(req_params).gsub('+','%20').gsub('=','%3D').gsub('~','%7E').gsub('*','%2A').gsub('/', '%2F').gsub(':','%253A').gsub('&','%26')
      stringToSign = "#{method}&%2F&#{req_params}"
      signature = Base64.encode64 OpenSSL::HMAC.digest('sha1', "#{app_secret}&", stringToSign)
      signature = "Signature=#{signature}"
    end
  end
end
