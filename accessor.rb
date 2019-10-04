module Accessor
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history_arr_name = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name); instance_variable_get(history_arr_name)}
      define_method("#{name}_history".to_sym) { instance_variable_get(history_arr_name) }
      define_method("#{name}=".to_sym) do |value| 
        instance_variable_set(var_name, value)
        instance_variable_set(history_arr_name, []) if !instance_variable_get(history_arr_name)
        instance_variable_set(history_arr_name, instance_variable_get(history_arr_name) + [value])
      end
      define_method("#{name}_history".to_sym) { instance_variable_get(history_arr_name) }
    end
  end

  def strong_attr_accessor(*names, class_name)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name)}
      define_method("#{name}=".to_sym) do |value| 
        raise 'Несовпадение классов' if value.class != class_name
        instance_variable_set(var_name, value)
      end
    end
  end
end

class Test
  extend Accessor

  strong_attr_accessor :my_attr, :a, :b, Integer
end