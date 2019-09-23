module Manufacturer
  def set_manufacturer_name(name)
    self.manufacturer = name
  end

  def get_manufacturer_name
    self.manufacturer
  end

  protected

  attr_accessor :manufacturer
end

module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    def instances
      @instances ||= 0
    end 

    def intrans_added
      @instances += 1
    end
  end

  module InstanceMethods
    def register_instance
      self.class.instances 
      self.class.intrans_added
      self.class.instances     
    end
  end
end
