# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def validate(name, check_method, *args); end

    private

    def validate!(name, check_method, *args)
      variable = instance_variable_get("@#{name}")
      send(check_method, name, variable, args[0])
    rescue NoMethodError => e
      puts e.message
    end

    def presence(name, variable, _args = nil)
      raise "Пустое значение атрибута #{name}" if variable.nil?
    end

    def format(name, variable, format)
      raise "Не верный формат атрибута #{name}" if variable !~ format
    end

    def type(name, variable, type)
      raise "Не верный тип атрибута #{name} = #{variable.class}" if variable.class != type
    end
  end
end
