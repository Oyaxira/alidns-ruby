require 'test/unit'
require 'alidns'
require 'dotenv'

class AlidnsTest < Test::Unit::TestCase
  setup do
    Dotenv.load
    Alidns.configure do |config|
      config.app_key = ENV['APP_KEY'] || 'your app key'
      config.response_format = 'json'
      config.app_secret = ENV['APP_SECRET'] || 'your app secret key'
      config.host = 'https://alidns.aliyuncs.com'
      config.log_file = 'alidns.log'
      config.log_level = :warn
    end
    @alidns = Alidns::Service.new
  end
  def test_initialize
    assert_equal ENV['APP_KEY'] || 'your app key', Alidns.config.app_key
    assert_equal ENV['APP_SECRET'] || 'your app secret key', Alidns.config.app_secret
  end

  def test_domain_record
    assert_not_nil @alidns.describe_doname_record("oyaxira.com")["DomainRecords"]
  end

end
