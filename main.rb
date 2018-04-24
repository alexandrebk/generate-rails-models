require 'awesome_print'
test
def read_files(path)
  file = File.read(path)
  return file
end

def write_output(output, path)
  File.open(path, 'wb') do |file|
    file.write(output)
  end
end

text = read_files("#{File.dirname(__FILE__)}/db.xml")

model_of_model = "rails generate model "


# array = text.gsub("\\",'').split("<table")

array = text.split("<table")

array.shift

output = []

ap array

array.each do |table|
  names = table.scan(/name="(\w+)"/)
  types = table.scan(/<datatype>(\w+)<\/datatype>/)
  p names.flatten!
  p types.flatten!
  output << names
end

ap output

# transofmer le texte

write_output(model_of_model, "#{File.dirname(__FILE__)}/command.sh")


# sortie de la première fonction
# [ hash, hash ]
# hash : {
#   name_table: ,
#   fields: [
#     {
#     namefield: column1
#     type: integer
#     },
#     {
#     namefield: column2
#     type: text
#     },
#     {
#     namefield: column3
#     type:
#     },
#   ]
# }

