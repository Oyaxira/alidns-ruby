require 'test/unit'
require 'alidns'
require 'dotenv'
require 'json'
require 'pry'

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
    record = @alidns.describe_doname_record("oyaxira.com")
    record = JSON.parse(record)["DomainRecords"]["Record"]
    assert_equal false, record.empty?
  end

  def test_describe_domains
   assert_not_nil @alidns.describe_domains

  end

end
