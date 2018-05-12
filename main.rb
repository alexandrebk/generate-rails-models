require 'awesome_print'
require 'pry'
      # binding.pry # to start debugging

def read_files(path)
  file = File.read(path)
  return file
end

def write_output(output, path)
  File.open(path, 'wb') do |file|
    file.write(output)
  end
end


class Table
  attr_accessor :name
  def initialize(table_name)
      @name = table_name 
  end
end

class Field
  attr_accessor :name, :table, :type, :allow_null, :autoincrement, :default_value 
  def initialize(field_name, table, type)
      if table.class.name != "Table"
        puts "Erreur : la variable table n'est pas un objet de type Table"
      end
      @name = field_name 
      @table = table 
      @type = type 
  end
end


  # 1st part - Analyze the input text in order to find tables and fields 
  #    Description of tables and fields will be put in arrays 'tables' (objects Table) and 'fields' (objects Field)

text = read_files("#{File.dirname(__FILE__)}/db.xml")  #.gsub(/\r\n?/, " ")

tables = Array.new
fields = Array.new

tables_content = Array.new   # array of texts between <table ...> and </table>
tables_content = text.scan(/<table(.*?)<\/table>/m)     # /m option : allow the search across several lines

tables_content.each do |table_content|
    table_name = table_content[0].scan(/name="(\w+)"/).flatten[0]
    tables << Table.new(table_name)

    fields_content = Array.new   # array of texts between <row ...> and </row> for this table
    fields_content = table_content[0].scan(/<row(.*?)<\/row>/m)
    fields_content.each do |field_content|
      field_name = field_content[0].scan(/name="(\w+)"/).flatten[0]
      field_type = field_content[0].scan(/<datatype>(\w+)<\/datatype>/).flatten[0]
      fields << Field.new(field_name, tables[-1], field_type)
    end
end

# Printout :
tables.each do |table|
    puts table.name
    fields.each do |field|
      puts "       " + field.name + " " + field.type if field.table == table 
    end
end

    # 2nd part : use the 'tables' and 'fields' array to build models in YAML language for Rails

