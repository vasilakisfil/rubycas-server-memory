require 'securerandom'

module RubyCAS
  module Server
    module Memory
      module Database
        extend self
        def setup(config_file)
          # InMemory adapter do not require any settings
          return true
        end
      end
    end
  end
end

require "rubycas/server/memory/storage"
require "rubycas/server/memory/login_ticket"
require "rubycas/server/memory/ticket_granting_ticket"
require "rubycas/server/memory/service_ticket"
require "rubycas/server/memory/proxy_ticket"
require "rubycas/server/memory/proxy_granting_ticket"
require "rubycas/server/memory/version"
