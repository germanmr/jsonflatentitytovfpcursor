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
* Convert entityes with nested arrays
* Divide and conquer: refactor so that individual pieces of the code can be unit tested
* Join with qdfoxjson?
* Remove new projects files
* Make equals method for classes vs VFP cursors, indicate what properties we compare ( Because of all extra vfp properties! )
* 
* Refactor to include this converter in a project (initialize, converter public object, integrate with rest client, etc)
* Translate everything to english
* Use qdfoxjson cursor conversor for vfp
* More character scaping ( E.G.: "\" )


