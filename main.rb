require_relative 'models/field'
require_relative 'models/table'
require 'awesome_print'
require 'pry'
# binding.pry # to start debugging

def read_files(path)
  File.read(path)
end

def write_output(output, path)
  File.open(path, 'wb') do |file|
    file.write(output)
  end
end

# Initialization - types of data
# the hashcode array equivalent_type contains the equivalence between SQL types and Rails types

equivalent_type = {
  "INTEGER":"integer",
  "TINYINT":"integer",
  "SMALLINT":"integer",
  "MEDIUMINT":"integer",
  "INT":"integer",
  "BIGINT":"integer",
  "DECIMAL":"decimal",
  "FLOAT":"float",
  "DOUBLE":"float",
  "CHAR":"string",
  "VARCHAR":"text",
  "MEDIUMTEXT":"text",
  "BINARY":"binary",
  "VARBINARY":"binary",
  "BLOB":"text",
  "DATE":"date",
  "TIME":"time",
  "DATETIME":"datetime",
  "YEAR":"date",
  "TIMESTAMP":"timestamp",
  "ENUM":"string",
  "SET":"integer",
  "bit":"string"
}


# 1st part - Analyze the input text in order to find tables and fields
# Description of tables and fields will be put in arrays 'tables' (objects Table) and 'fields' (objects Field)

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

# 2nd part : use the 'tables' and 'fields' array to build models in language for Rails
#   command_line will contain the Rails command

final_string = "rails new notre-nouveau-projet \ncd notre-nouveau-projet \ngit init \ngit add . \ngit commit \nhub create \n"

tables.each do |table|
  # Table name should be transformed to have upper first letter and no "s" at the end
    if table.name[table.name.length-1] == "s"
      modified_table_name = table.name[0, table.name.length-1].capitalize
    else
      modified_table_name = table.name.capitalize
    end
    command_line = "rails generate model " + modified_table_name
    fields.each do |field|
      command_line = command_line + " " + field.name + ":" + equivalent_type[field.type.to_sym] if field.table == table
    end
    command_line += " \n"
    puts " "
    puts command_line
    final_string += command_line
end

final_string += "rails db:create \nrails db:migrate"

puts "---------"
puts final_string

puts "Write output"

write_output(final_string, "#{File.dirname(__FILE__)}/rails.sh")

# Autres commandes Rails :
# $ rails generate migration AddPartNumberToProducts part_number:string
# ou : $ rails generate migration AddDetailsToProducts part_number:string price:decimal
# $ rails generate migration RemovePartNumberFromProducts part_number:string
