# jsonflatentitytovfpcursor

FLATTENING JSON ENTITIES

JSON -> VFP CURSOR!

E.G:
Country with states

```
{
"code":1,"
"name":"Argentina",
"states": [
    {
    "code":1,
    "name":"Santa Fe"
    },
    {
    "code":2,"
    "name":"Jujuy"
    },
    {
    "code":3,"
    "name":"Cordoba"
    }
  ]
}
```
VFP Cursor Created:
```
code   name           statescode  statesname
  1     Argentina         1         Santa Fe
  1     Argentina         2         Jujuy
  1     Argentina         3         Cordoba
```

DONE:
* Conversion of entities without json arrays
* Conversion of entities with json arrays
* Create the correct data type on the cursor from the json
* Assign the correct value from the json entity into the cursor

TODO:
* Convertir entidades con json arrays anidados
* Refactorizar para separar casos de prueba de la definicion de las clases de conversion
* Unir con qdfoxjson?
* limpiar archivos del proyecto
* Hacer un equals para cursores y clases( indicar que propiedades comparamos? )
* Refactorizar para incluir este conversor en un proyecto( inicializar, objeto publico conversor, integrar con rest client, etc )
* Escribir todo en ingles( codigo, documentacion y demás)?
* Utilizar el conversor de cursores de qdfoxjson
* Escapar caracteres con la barra invertida "\"


