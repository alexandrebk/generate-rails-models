# Types of data
# the hashcode array equivalent_type contains the equivalence between SQL types and Rails types

EQUIVALENCE_TYPE = {
  "INTEGER":"integer",
  "TINYINT":"integer",
  "SMALLINT":"integer",
  "MEDIUMINT":"integer",
  "INT":"integer",
  "BIGINT":"integer",
  "DECIMAL":"float",
  "FLOAT":"float",
  "DOUBLE":"float",
  "CHAR":"string",
  "VARCHAR":"text",
  "MEDIUMTEXT":"text",
  "BINARY":"boolean",
  "VARBINARY":"boolean",
  "BLOB":"text",
  "DATE":"datetime",
  "TIME":"datetime",
  "DATETIME":"datetime",
  "YEAR":"datetime",
  "TIMESTAMP":"timestamp",
  "ENUM":"string",
  "SET":"integer",
  "bit":"string"
}
