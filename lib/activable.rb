require 'rails'
require "activable/version"
require 'active_support/dependencies'

module Activable
  mattr_accessor :configuration
  @@configuration = {has_responsible: true, responsible: "User"}

  def self.set(options={})
    @@configuration.merge! options
  end

  def self.setup
    yield self
  end

  module Methods
    extend ActiveSupport::Concern

    def init_active
      self.activated_at = Time.now
    end

    def active?
      return true unless self.activated_at && self.deactivated_at
      self.activated_at >= self.deactivated_at
    end

    def activate(options={})
      verify_responsible(options)
      self.activated_at = Time.now
      self.activated_by = options[:responsible] if self.activable_config[:has_responsible]
    end

    def deactivate(options={})
      verify_responsible(options)
      self.deactivated_at = Time.now
      self.deactivated_by = options[:responsible] if self.activable_config[:has_responsible]
    end

    def activate!(options={})
      activate(options)
      save
    end

    def deactivate!(options={})
      deactivate(options)
      save
    end

    included do
      after_initialize :init_active
      validates_presence_of :activated_at
      scope :active, where('deactivated_at is null or activated_at is null or' +
          ' activated_at >= deactivated_at')
      scope :inactive, where('deactivated_at is not null and activated_at is not' +
          ' null and activated_at < deactivated_at')
      if self.activable_config[:has_responsible]
        belongs_to :activated_by, :class_name => self.activable_config[:responsible]
        belongs_to :deactivated_by, :class_name => self.activable_config[:responsible]
        validates_presence_of :activated_by_id, if: :active?
        validates_presence_of :deactivated_by_id, unless: :active?
      end
    end

    protected

    def verify_responsible(options)
      if self.activable_config[:has_responsible]
        resp = options && options[:responsible]
        if !resp
          raise "You must provide a responsible to activate a " + self.class.name
        elsif resp.class.name != self.activable_config[:responsible]
          raise "Object of type #{resp.class.name} is not a " + self.activable_config[:responsible]
        end
      end
    end
  end

  module Models
    def is_activable(options = {})
      cattr_accessor :activable_config
      self.activable_config = Activable.configuration.merge options
      include Activable::Methods
    end
  end
end
