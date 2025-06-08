[
  {
    "id": "equal_check",
    "info": "Evalúa si dos valores son idénticos.",
    "example": "Verifica si campo1 tiene el valor 5.",
    "form": "{ campo1: { $eq: 5 } }",
    "category": "comparativo"
  },
  {
    "id": "not_equal",
    "info": "Determina si un valor difiere de otro.",
    "example": "Comprueba que campo1 no sea igual a 5.",
    "form": "{ campo1: { $ne: 5 } }",
    "category": "comparativo"
  },
  {
    "id": "greater_than",
    "info": "Analiza si un número es superior a otro.",
    "example": "campo1 debe ser mayor que 10.",
    "form": "{ campo1: { $gt: 10 } }",
    "category": "comparativo"
  },
  {
    "id": "greater_or_equal",
    "info": "Verifica si un valor es al menos igual a otro.",
    "example": "campo1 es como mínimo 10.",
    "form": "{ campo1: { $gte: 10 } }",
    "category": "comparativo"
  },
  {
    "id": "less_than",
    "info": "Evalúa si un número es menor a otro.",
    "example": "campo1 está por debajo de 10.",
    "form": "{ campo1: { $lt: 10 } }",
    "category": "comparativo"
  },
  {
    "id": "less_or_equal",
    "info": "Determina si un valor es inferior o igual a otro.",
    "example": "campo1 es igual o menor que 10.",
    "form": "{ campo1: { $lte: 10 } }",
    "category": "comparativo"
  },
  {
    "id": "within_values",
    "info": "Checa si un valor está en una lista determinada.",
    "example": "campo1 corresponde a uno de los elementos [1, 2, 3].",
    "form": "{ campo1: { $in: [1, 2, 3] } }",
    "category": "comparativo"
  },
  {
    "id": "outside_values",
    "info": "Confirma si un campo no pertenece a ciertos valores.",
    "example": "campo1 no coincide con ninguno de [1, 2, 3].",
    "form": "{ campo1: { $nin: [1, 2, 3] } }",
    "category": "comparativo"
  },
  {
    "id": "all_true",
    "info": "Se requiere que todas las condiciones sean ciertas.",
    "example": "campo1 > 5 y campo2 < 20.",
    "form": "{ $and: [ { campo1: { $gt: 5 } }, { campo2: { $lt: 20 } } ] }",
    "category": "logico"
  },
  {
    "id": "any_true",
    "info": "Basta con que se cumpla una condición.",
    "example": "campo1 > 5 o campo2 < 20.",
    "form": "{ $or: [ { campo1: { $gt: 5 } }, { campo2: { $lt: 20 } } ] }",
    "category": "logico"
  },
  {
    "id": "simple_negation",
    "info": "Niega una condición básica.",
    "example": "campo1 no debe superar 10.",
    "form": "{ campo1: { $not: { $gt: 10 } } }",
    "category": "logico"
  },
  {
    "id": "none_match",
    "info": "Ninguna condición puede cumplirse.",
    "example": "campo1 ≠ 5 y campo2 no < 3.",
    "form": "{ $nor: [ { campo1: { $eq: 5 } }, { campo2: { $lt: 3 } } ] }",
    "category": "logico"
  },
  {
    "id": "expr_equals",
    "info": "Compara el contenido de dos campos mediante $expr.",
    "example": "campo1 y campo2 tienen el mismo valor.",
    "form": "{ $expr: { $eq: [\"$campo1\", \"$campo2\"] } }",
    "category": "expresion"
  },
  {
    "id": "expr_greater",
    "info": "Establece si un campo es mayor a otro con $expr.",
    "example": "campo1 > campo2.",
    "form": "{ $expr: { $gt: [\"$campo1\", \"$campo2\"] } }",
    "category": "expresion"
  },
  {
    "id": "expr_not",
    "info": "Niega una comparación entre campos usando $expr.",
    "example": "campo2 no debe ser más que campo3.",
    "form": "{ campo1: { $not: { $expr: { $gt: [\"$campo2\", \"$campo3\"] } } } }",
    "category": "expresion"
  },
  {
    "id": "js_condition",
    "info": "Usa lógica JS para evaluar una expresión.",
    "example": "campo1 + campo2 debe superar 100.",
    "form": "{ $where: \"this.campo1 + this.campo2 > 100\" }",
    "category": "javascript"
  },
  {
    "id": "negate_js",
    "info": "Niega una expresión en JS.",
    "example": "campo1 no puede ser < 10.",
    "form": "{ campo1: { $not: { $where: \"this.campo1 < 10\" } } }",
    "category": "javascript"
  },
  {
    "id": "nor_js_logic",
    "info": "Ninguna condición, incluyendo una JS, debe cumplirse.",
    "example": "campo1 ≠ valor1 y campo2 no debe estar 'inactivo'.",
    "form": "{ $nor: [ { campo1: valor1 }, { $where: \"this.campo2 == 'inactivo'\" } ] }",
    "category": "javascript"
  },
  {
    "id": "combine_expr_js",
    "info": "Une expresiones de tipo $expr y JavaScript.",
    "example": "campo1 ≥ campo2 y campo3 > 10.",
    "form": "{ $and: [ { $expr: { $gte: [\"$campo1\", \"$campo2\"] } }, { $where: \"this.campo3 > 10\" } ] }",
    "category": "mixto"
  },
  {
    "id": "and_with_js",
    "info": "Mezcla lógica booleana con evaluación JS.",
    "example": "campo1 debe ser valor1 y campo2 < 100.",
    "form": "{ $and: [ { campo1: valor1 }, { $where: \"this.campo2 < 100\" } ] }",
    "category": "mixto"
  },
  {
    "id": "all_mixed",
    "info": "Utiliza $expr junto con JavaScript para múltiples condiciones.",
    "example": "campo1 ≤ campo2 y campo3 debe estar definido.",
    "form": "{ $and: [ { $expr: { $lte: [\"$campo1\", \"$campo2\"] } }, { $where: \"this.campo3 != null\" } ] }",
    "category": "mixto"
  }
]