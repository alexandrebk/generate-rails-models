class Field
  attr_accessor :name, :table, :type, :allow_null, :autoincrement, :default_value

  def initialize(field_name, table, type)
    if table.class.name != 'Table'
      puts "Erreur: la variable table n'est pas un objet de type Table"
    end
    @name = field_name
    @table = table
    @type = type
  end
end
