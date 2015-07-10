require_relative '02_searchable'
require 'active_support/inflector'
require 'byebug'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    defaults = {
                 foreign_key: name.foreign_key.to_sym,
                 primary_key: :id,
                 class_name: name.classify
               }
    options = defaults.merge(options)

    self.foreign_key = options[:foreign_key]
    self.primary_key = options[:primary_key]
    self.class_name = options[:class_name]
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    defaults = {
                 foreign_key: self_class_name.foreign_key.to_sym,
                 primary_key: :id,
                 class_name: name.classify
               }
    options = defaults.merge(options)

    self.foreign_key = options[:foreign_key]
    self.primary_key = options[:primary_key]
    self.class_name = options[:class_name]
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name.to_s, options)
    assoc_options[name] = options

    define_method(name) do
      query_str = <<-SQL
        SELECT
          *
        FROM
          #{options.table_name}
        WHERE
          #{options.primary_key} = ?
      SQL

      results =  DBConnection.execute(query_str, self.send(options.foreign_key))
      options.model_class.parse_all(results).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name.to_s, self.to_s, options)

    define_method(name) do
      query_str = <<-SQL
        SELECT
          *
        FROM
          #{options.table_name}
        WHERE
          #{options.foreign_key} = ?
      SQL

      results =  DBConnection.execute(query_str, self.send(options.primary_key))
      options.model_class.parse_all(results)
    end

  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
