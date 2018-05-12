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

class Column
  attr_accessor :name, :table, :type, :allow_null, :autoincrement, :default_value 
  def initialize(column_name, table, type)
      if table.class.name != "Table"
        puts "Erreur : la variable table n'est pas un objet de type Table"
      end
      @name = column_name 
      @table = table 
      @type = type 
  end
end


  # 1st part - Analyze the input text in order to find tables and columns 
  #    Description of tables and columns will be put in arrays 'tables' (objects Table) and 'columns' (objects Column)

text = read_files("#{File.dirname(__FILE__)}/db.xml")  #.gsub(/\r\n?/, " ")

# puts text

tables = Array.new
columns = Array.new

tables_content = Array.new   # array of texts between <table ...> and </table>
tables_content = text.scan(/<table(.*?)<\/table>/m)

puts "nombre de tables " + tables_content.count.to_s
# puts tables_tag_texts

tables_content.each do |table_content|
    table_name = table_content.flatten[0].scan(/name="(\w+)"/).flatten[0]
    tables << Table.new(table_name)
    puts " "
    puts "nouvelle table :" + table_name

    rows_content = Array.new   # array of texts between <row ...> and </row>
    rows_content = text.scan(/<row(.*?)<\/row>/m)
    rows_content.each do |row_content|
      row_name = row_content.flatten[0].scan(/name="(\w+)"/).flatten[0]
      row_type = row_content.flatten[0].scan(/<datatype>(\w+)<\/datatype>/).flatten[0]
      columns << Column.new(row_name, table_name, row_type)
      puts "    Champ : " + row_name + "    de type : " + row_type
    end

#    puts table_content
end
