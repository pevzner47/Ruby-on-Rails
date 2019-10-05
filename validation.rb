module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    def options_arr
      @options_arr ||= []
    end

    def options_arr=(value)
      @options_arr = value
    end

    def validate(name, type, option = nil)
      options_arr << [name, type, option]
    end
  end

  module InstanceMethods

    protected

    def validate!
      self.class.options_arr.each do |args|
        var = instance_variable_get("@#{args[0]}".to_sym)
        type = args[1]
        option = args[2]
        case type
        when :presence
          return raise "Значение не может быть пустым или nil" if var.nil? or var == ''
        when :format
          return raise "Неверный формат" if var.to_s !~ option
        when :type
          return raise "Неверный тип аргумента" if !var.is_a? option
        end
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end
  end
end