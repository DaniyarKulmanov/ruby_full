# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*variables)
    variables.each do |variable|
      raise TypeError, 'variable name must be symbol' unless variable.is_a?(Symbol)

      create_getter(variable)
      create_setter_history(variable)
      create_getter("#{variable}_history")
    end
  end

  def strong_attr_accessor(variable, type)
    create_getter(variable)
    create_strong_setter(variable, type)
  end

  private

  def create_getter(variable)
    define_method(variable) do
      instance_variable_get("@#{variable}")
    end
  end

  def create_setter_history(variable)
    define_method("#{variable}=") do |value|
      instance_variable_set("@#{variable}", value)
      instance_variable_set("@#{variable}_history", []) if instance_variable_get("@#{variable}_history").nil?
      instance_variable_get("@#{variable}_history").push(value)
    end
  end

  def create_strong_setter(variable, type)
    define_method("#{variable}=") do |value|
      raise TypeError if value.class != (type)

      instance_variable_set("@#{variable}", value)
    end
  end
end
