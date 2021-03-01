# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    attr_reader :validations

    @validations = []

    def validate(name, method, *args)
      @validations ||= []
      @validations << { variable: name, check: method, options: args }
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    validations = self.class.validations
    validations.each do |validation|
      value = instance_variable_get("@#{validation[:variable]}")
      send(validation[:check], validation[:variable], value, validation[:options])
    end
  rescue NoMethodError => e
    puts e.message
  end

  def presence(name, variable, _args = nil)
    raise "Пустое значение атрибута #{name}" if variable.nil? || variable.to_s.empty?
  end

  def format(name, variable, format)
    raise "Не верный формат атрибута #{name}" if variable !~ format[0]
  end

  def type(name, variable, type)
    variable_class = variable.class
    raise "Не верный тип атрибута #{name} = #{variable.class}" if variable_class != type[0]
  end
end
