module RubyCAS
  module Server
    module Core
      module Tickets
        class ServiceTicket
          extend Storage

          attr_accessor :id, :ticket, :consumed, :client_hostname,
                        :username, :created_at, :updated_at, :proxy_granting_ticket,
                        :ticket_granting_ticket
          attr_reader :service

          def initialize(st = {})
            @id = SecureRandom.uuid
            @ticket = st[:ticket]
            @service = st[:service]
            @consumed = st[:consumed]
            @client_hostname = st[:client_hostname]
            @username = st[:username]
            @created_at = DateTime.now
            @updated_at = DateTime.now
            @proxy_granting_ticket = st[:proxy_granting_ticket]
            @ticket_granting_ticket = st[:ticket_granting_ticket]
            super()
          end

          def consumed?
            self.consumed
          end

          def consume!
            self.consumed = true
            self.save
          end

          def expired?(max_lifetime = 100)
            lifetime = Time.now.to_i - created_at.to_time.to_i
            lifetime > max_lifetime
          end

          def service=(url)
            @service = RubyCAS::Server::Core::Util.clean_service_url(url)
          end

        end
      end
    end
  end
end
