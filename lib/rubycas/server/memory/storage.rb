module RubyCAS
  module Server
    module Core
      module Tickets
        module Storage

          attr_accessor :storage;

          def find_by_ticket(ticket)
            @storage.each do |id,lt|
              return lt if lt.ticket == ticket
            end
            return nil
          end

          def self.extended(base)
            base.instance_variable_set(:@storage, {})
            base.send(:include, InstanceMethods)
          end

          module InstanceMethods
            def save
              self.class.storage[@id] = self
              return true
            end

            def save!
              self.class.storage[@id] = self
              return true
            end
          end
        end
      end
    end
  end
end
