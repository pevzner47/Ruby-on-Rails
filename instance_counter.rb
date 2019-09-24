module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    def instances
      @instances ||= 0
    end 

    def intrans_add
      @instances = self.instances + 1 #ничего лучше не придумал
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.intrans_add
    end
  end
end
