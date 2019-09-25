module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    def instances
      @instances ||= 0
    end 

    def instances=(value)
      @instances = value
    end

    def intrans_add
      self.instances += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.intrans_add
    end
  end
end
