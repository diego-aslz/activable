require 'rails'
require "activable/version"
require 'active_record'

module Activable
  mattr_accessor :has_responsible
  @@has_responsible = true
  mattr_accessor :responsible
  @@responsible = "User"

  def self.setup
    yield self
  end

  module Methods
    extend ActiveSupport::Concern

    def activate(otions={})
      verify_responsible(options)
      unless active
        self.active = true
        self.activated_at = Time.now
        self.activated_by_id = curruser.id
        self.deactivated_at = nil
            self.deactivated_by_id = nil
            return true
        end
        false
    end

    def deactivate(otions={})
      verify_responsible(options)
      if active
        self.active = false
        self.activated_at = nil
        self.activated_by_id = nil
        self.deactivated_at = Time.now
            self.deactivated_by_id = options[:responsible].id
            return true
        end
        false
    end

    def activate!(otions={})
      verify_responsible(options)
      activate(options)
      save
    end

    def deactivate!(otions={})
      verify_responsible(options)
      deactivate(options)
      save
    end

    included do
      config = Activable
      if config.has_responsible
        belongs_to :activated_by, :class_name => config.responsible
        belongs_to :deactivated_by, :class_name => config.responsible
      end
    end

    private

    def verify_responsible(options)
      config = Activable
      if config.has_responsible
        resp = options[:responsible]
        if !resp
          raise "You must provide a responsible to activate a " + self.class.name
        elsif resp.class.name != config.responsible
          raise "Object of type #{resp.class.name} is not a " + config.responsible
        end
      end
    end
  end
end
