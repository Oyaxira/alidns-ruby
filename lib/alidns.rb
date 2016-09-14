require "alidns/version"
require "alidns/service"
require "alidns/configuration"
require "alidns/sign"

module Alidns
  module_function

  def root
   File.dirname __dir__
  end

  def lib
   File.join root, 'lib'
  end
end
