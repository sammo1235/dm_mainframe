module UserAttributes
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    def has_attributes(*attrs)
      attrs.each do |attr_name|
        self.send(:define_method, "set_#{attr_name}") do |arg|
          instance_variable_set("@#{attr_name}", arg)
        end
      end
    end
  end
end

class User
  include UserAttributes

  has_attributes :name, :age, :sex, :likes, :encrypted_password
  attr_reader :name, :age, :sex, :likes

  class NoAttributesGiven < StandardError; end
  def self.build_user(name, &block)
    raise NoAttributesGiven unless block_given?

    self.new(name, &block)
  end

  def initialize(name, &block)
    @name = name
    self.instance_eval(&block)
    freeze
    $USERS << self
  end

  private
    attr_reader :encrypted_password

    def decrypt_hex(text)
      text.scan(/../).map {|x| x.hex.chr }.join
    end
end
