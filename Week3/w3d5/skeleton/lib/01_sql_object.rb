require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    if @column_names.nil?
      rows = DBConnection.execute2(<<-SQL)
        SELECT
          *
        FROM
          #{table_name}
        LIMIT 1
      SQL
      @column_names = rows.first.map { |c_name| c_name.to_sym }
    else
      @column_names
    end
  end

  def self.finalize!
    columns.each do |column|
        #getter
        define_method("#{column}") do
          self.attributes[column]
        end
        #setter
        define_method("#{column}=") do |value|
          self.attributes[column] = value
        end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    query_str = <<-SQL
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
    SQL

    results = DBConnection.execute(query_str)
    parse_all(results)
  end

  def self.parse_all(results)
    results.map { |row_hash| self.new(row_hash) }
  end

  def self.find(id)
    find_by_id_query = <<-SQL
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
      WHERE
        #{table_name}.id = ?
      LIMIT
        1
    SQL
    results = DBConnection.execute(find_by_id_query, id)
    results.count == 1 ? self.new(results.first) : nil
    # ...
  end

  def initialize(params = {})
    params.keys.each do |attr_name|
      attr_name = attr_name.to_sym
      unless self.class.columns.include?(attr_name)
        raise "unknown attribute '#{attr_name}'"
      end
    end

    params.each do |attr_name, value|
      self.send("#{attr_name}=".to_sym, value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    attributes.values
  end

  def insert
    col_names = self.class.columns.drop(1).map(&:to_s).join(", ")

    question_marks = (["?"] * (self.class.columns.count - 1)).join(", ")

    insert_query = <<-SQL
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    DBConnection.execute(insert_query, *attribute_values)
    self.id = DBConnection.last_insert_row_id
  end

  def update
    col_names = self.class.columns.drop(1)
    set_string = col_names.map { |col_name| "#{col_name} = ?"}.join(", ")

    update_query = <<-SQL
      UPDATE
        #{self.class.table_name}
      SET
        #{set_string}
      WHERE
        id = ?
    SQL

    DBConnection.execute(update_query, *attribute_values.drop(1), self.id)
  end

  def save
    id.nil? ? insert : update
  end
end
