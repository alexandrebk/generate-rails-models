require_relative 'models/field'
require_relative 'models/table'
require_relative 'db/equivalence'
# require 'awesome_print'
# require 'pry'
# binding.pry # to start debugging

def read_files(path)
  File.read(path)
end

def write_output(output, path)
  File.open(path, 'wb') do |file|
    file.write(output)
  end
end

# 1st part
# Analyze the input text in order to find tables and fields
# Description of tables and fields will be put in arrays 'tables' (objects Table) and 'fields' (objects Field)

database_drawing = read_files("#{File.dirname(__FILE__)}/db/db.xml")  #.gsub(/\r\n?/, " ")

tables           = Array.new
fields           = Array.new

tables_content   = Array.new                                          # array of texts between <table ...> and </table>
tables_content   = database_drawing.scan(/<table(.*?)<\/table>/m)     # /m option : allow the search across several lines

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


# Print Tables:
tables.each do |table|
    puts table.name
    fields.each do |field|
      puts "       " + field.name + " " + field.type if field.table == table
    end
end

# 2nd part
# Use the 'tables' and 'fields' array to build models in language for Rails
# command_line will contain the Rails command

shell_rails = "rails new notre-nouveau-projet \ncd notre-nouveau-projet \ngit init \ngit add . \ngit commit -m 'my first commit' \nhub create \n"

tables.each do |table|
  # Table name should be transformed to have upper first letter and no "s" at the end
  table_name = table.name[-1] == "s" ? table.name[0, table.name.length-1].capitalize : table.name.capitalize
  command_line = "rails generate model " + table_name
  fields.each do |field|
    if field.table == table && field.name.include?("_id")
      command_line = command_line + " " + field.name.delete_suffix("_id") + ":references"
    elsif field.table == table && field.name != "id"
      command_line = command_line + " " + field.name + ":" + EQUIVALENCE_TYPE[field.type.to_sym]
    end
  end
  command_line += " \n"
  puts " "
  puts command_line
  shell_rails += command_line
end

shell_rails += "rails db:create \nrails db:migrate"

write_output(shell_rails, "#{File.dirname(__FILE__)}/rails.sh")

# Autres commandes Rails :
# $ rails generate migration AddPartNumberToProducts part_number:string
# ou : $ rails generate migration AddDetailsToProducts part_number:string price:decimal
# $ rails generate migration RemovePartNumberFromProducts part_number:string
