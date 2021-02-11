module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    attr_accessor :instances_count

    def instances
      instances_count
    end
  end

  private

  def register_instance
    self.class.instances_count ||= 0
    self.class.instances_count += 1
  end
end