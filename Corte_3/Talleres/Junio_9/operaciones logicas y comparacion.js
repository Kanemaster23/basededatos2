// use mongo_ayuda
use mongo_ayuda;

db.help.insertMany([
  {
    name: "eq",
    type: "comparacion",
    description: "Evalúa si dos valores son exactamente iguales.",
    example: "campo1 igual a 5",
    syntax: "{ campo1: { $eq: 5 } }",
    queries: [
      "db.help.findOne({ name: 'eq' })",
      "db.help.find({ type: 'comparacion', name: 'eq' })"
    ]
  },
  {
    name: "ne",
    type: "comparacion",
    description: "Evalúa si dos valores son diferentes.",
    example: "campo1 distinto de 5",
    syntax: "{ campo1: { $ne: 5 } }",
    queries: [
      "db.help.find({ name: 'ne' })"
    ]
  },
  {
    name: "gt",
    type: "comparacion",
    description: "Determina si un valor es mayor a otro.",
    example: "campo1 mayor que 10",
    syntax: "{ campo1: { $gt: 10 } }",
    queries: [
      "db.help.findOne({ name: 'gt' })"
    ]
  },
  {
    name: "and",
    type: "logico",
    description: "Ambas condiciones deben ser verdaderas.",
    example: "campo1 > 5 y campo2 < 20",
    syntax: "{ $and: [ { campo1: { $gt: 5 } }, { campo2: { $lt: 20 } } ] }",
    queries: [
      "db.help.find({ type: 'logico' })",
      "db.help.find({ name: 'and' })"
    ]
  },
  {
    name: "expr_gt",
    type: "expr",
    description: "Compara dos campos con $expr y $gt.",
    example: "campo1 mayor que campo2",
    syntax: '{ $expr: { $gt: ["$campo1", "$campo2"] } }',
    queries: [
      "db.help.findOne({ name: 'expr_gt' })"
    ]
  },
  {
    name: "where_simple",
    type: "where",
    description: "Ejecuta una expresión JavaScript en los documentos.",
    example: "campo1 + campo2 > 100",
    syntax: '{ $where: "this.campo1 + this.campo2 > 100" }',
    queries: [
      "db.help.find({ type: 'where' })"
    ]
  },
  {
    name: "and_expr_where",
    type: "mixto",
    description: "Utiliza $and con $expr y $where.",
    example: "campo1 <= campo2 y campo3 != null",
    syntax:
      '{ $and: [ { $expr: { $lte: ["$campo1", "$campo2"] } }, { $where: "this.campo3 != null" } ] }',
    queries: [
      "db.help.find({ name: 'and_expr_where' })"
    ]
  }
  // Puedes seguir este mismo patrón para los demás operadores
]);

// Consultas generales
db.help.find({ type: "comparacion" }).pretty();
db.help.find({ type: "logico" }).pretty();
db.help.find({ type: "expr" }).pretty();
db.help.find({ type: "where" }).pretty();
db.help.find({ type: "mixto" }).pretty();

// Búsqueda individual por nombre de operador
const operadores = [
  "eq", "ne", "gt", "gte", "lt", "lte", "in", "nin",
  "and", "or", "not_simple", "nor",
  "expr_eq", "expr_gt", "not_expr",
  "where_simple", "not_where", "nor_where",
  "expr_where", "and_where", "and_expr_where"
];

operadores.forEach(op => {
  print(`Consultando operador: ${op}`);
  printjson(db.help.find({ name: op }).toArray());
});

// Consulta combinada por tipos conocidos
db.help.find({ type: { $in: ["comparacion", "logico", "expr", "where", "mixto"] } }).pretty();