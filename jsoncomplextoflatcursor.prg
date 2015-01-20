

* TODO
* Le puedo pasar un array con los nombres de algunos campos de json y con el tipo de dato????

SET DEFAULT TO d:\vfp\proyectos\jsonflatentitytovfpcursor

LOCAL pcJSON
LOCAL oConversor

oConversor=CREATEOBJECT("Conversor")

* Bien!!!!!!!
pcJSON='{"nombre":"German","apellido":"mu�oz"}'
=oConversor.jsonToCursor(pcJSON)
BROWSE

pcJSON='{"nombre":"German","apellido":"mu�oz","telefono":{"descripcion":"Casa","numero":123}}'
=oConversor.jsonToCursor(pcJSON)
BROWSE

pcJSON='{"nombre":"German","apellido":"mu�oz","telefono":{"descripcion":"Casa","Detalle":{"caracteristica":"314","numero":"123456"}}}'
=oConversor.jsonToCursor(pcJSON)
BROWSE

pcjson= '{"profesiones":[{"ID":1},{"ID":2},{"ID":3}]}'
=oConversor.jsonToCursor(pcJSON)
BROWSE

* Si aplano la entidad me queda como una fila

pcjson= '{"profesiones":[{"ID":1,"nombre":"MEDICO"},{"ID":2,"nombre":"FONOAUDIOLOGO"},{"ID":3,"nombre":"KINESIOLOGO"}]}'
=oConversor.jsonToCursor(pcJSON)
BROWSE

pcjson = '{"employees":[{"firstName":"Primero", "lastName":"perez"},{"firstName":"segundo", "lastName":"Gonzalez"}]}'
=oConversor.jsonToCursor(pcJSON)
BROWSE

pcjson='{tiposRespuestaValidacion: "OK",mensaje: "Hay comunicacion"}'
=oConversor.jsonToCursor(pcJSON)
BROWSE

pcjson='{"respuestaComunicacion":{"idTransaccion":15984,"respuestaBase":{"tiposRespuestaValidacion":"OK","mensaje":""}},'+;
		'"profesiones":[{"ID":1,"nombre":"MEDICO"},{"ID":2,"nombre":"FONOAUDIOLOGO"},{"ID":3,"nombre":"KINESIOLOGO"}]}'
=oConversor.jsonToCursor(pcJSON)
BROWSE

pcjson= '{"respuestaComunicacion":{"idTransaccion":316,"respuestaBase":{"tiposRespuestaValidacion":"OK","mensaje":""}},'+;
		'"respuestaElegibilidadAfiliado":{"estadoGeneral":{"tiposRespuestaValidacion":"OK","mensaje":""},"detalleElegibilidadAfiliado":{'+;
		'"afiliado":{"ID":"32165478","nombre":"PEREZ JUAN","convenio":{"ID":1,"nombre":"IAPOS"},"plan":{"ID":1,"nombre":"Dpto ROSARIO"}},'+;
		'"modoIngresoAfiliado":"M","observaciones":""}}}'
=oConversor.jsonToCursor(pcJSON)
BROWSE

pcjson= '{"efector":{"codigoProfesion":1,"matricula":9999,"libro":"     ","folio":"     "},'+;
		'"prescriptor":{"codigoProfesion":1,"matricula":9999,"libro":"     ","folio":"     "},'+;
		'"fechaPrestacion":"18/03/2014",'+;
		'"codigoAfiliado":"65987654",'+;
		'"codigoConvenio":1,'+;
		'"codigoDelegacion":1,'+;
		'"codigoMedioDePago":0,'+;
		'"diagnostico":"",'+;
		'"prestacionSolicitadas":[{"codigoPrestacion":"420101","cantidad":1,"urgencia":false,"motivoSolicitud":"AGUDO","observaciones":"","bono":"321"}]} '

=oConversor.jsonToCursor(pcJSON)
BROWSE

*!*	pcjson='{"respuestaComunicacion": {"idTransaccion": 16144,"respuestaBase": {"tiposRespuestaValidacion": "OK","mensaje": ""}},'+;
*!*		'"autorizadas": [{"baseAmbulatorio": {"ID": "A02-K37-I47","afiliado": {"ID": "000000014474134","nombre": "PEREYRA ANDRES","convenio": {'+;
*!*		'"ID": 1,"nombre": "IAPOS"},"plan": {"ID": 1,"nombre": "Dpto ROSARIO"}},"prestador": {"codigoProfesion": 4,"matricula": 64758,"libro": "     ",'+;
*!*		'"folio": "     "},"efector": {"ID": {"codigoProfesion": 1,"matricula": 1,"libro": "     ","folio": "     "},"nombre": "MEDICO OTRA CIRCUNSCRIPCION / GUARDIA"'+;
*!*		'},"prescriptor": {"ID": {"codigoProfesion": 1,"matricula": 1,"libro": "     ","folio": "     "},"nombre": "MEDICO OTRA CIRCUNSCRIPCION / GUARDIA"'+;
*!*		'},"fechaPrestacion": "2014/02/01"},"prestacionesRealizadas": [{"prestacionSolicitadaBase": {"nomencladorBase": {"codigoNomenclador": "420601","ID": "420601",'+;
*!*		'"Nombre": "CONSULTA GUARDIA MEDICA"},"cantidad": 1},"importePrestacion": {"moneda": {"ID": 5,"nombre": "Ordenes Consultas"},"coseguro": 1.00,"coseguroIva": 0.00,'+;
*!*		'"coseguroPorcentaje": 0.00,"honorarios": 0.00,"derechos": 0.00,"iva": 0.00,"coseguroTexto": "1 Orden Consulta"}}],"fechaAutorizacion": "2014/02/01"},'+;
*!*		'{"baseAmbulatorio": {"ID": "A02-K37-I48","afiliado": {"ID": "000000013033000","nombre": "ZABCIC CARLOS A","convenio": {"ID": 1,"nombre": "IAPOS"},"plan": {'+;
*!*		'"ID": 1,"nombre": "Dpto ROSARIO"}},"prestador": {"codigoProfesion": 4,"matricula": 64758,"libro": "     ","folio": "     "},"efector": {"ID": {"codigoProfesion": 1,'+;
*!*		'"matricula": 1,"libro": "     ","folio": "     "},"nombre": "MEDICO OTRA CIRCUNSCRIPCION / GUARDIA"},"prescriptor": {"ID": {"codigoProfesion": 1,"matricula": 1,'+;
*!*		'"libro": "     ","folio": "     "},"nombre": "MEDICO OTRA CIRCUNSCRIPCION / GUARDIA"},"fechaPrestacion": "2014/02/01"},'+;
*!*		'"prestacionesRealizadas": [{"prestacionSolicitadaBase": {"nomencladorBase": {"codigoNomenclador": "420601","ID": "420601","Nombre": "CONSULTA GUARDIA MEDICA"'+;
*!*		'},"cantidad": 1},"importePrestacion": {"moneda": {"ID": 5,"nombre": "Ordenes Consultas"},'+;
*!*	    '"coseguro": 1.00,"coseguroIva": 0.00,"coseguroPorcentaje": 0.00,"honorarios": 0.00,"derechos": 0.00,"iva": 0.00,"coseguroTexto": "1 Orden Consulta"}}],'+;
*!*	    '"fechaAutorizacion": "2014/02/01"}]}'

* Dos niveles de anidamiento
*!*	pcjson='{"cantidad": 1,'+;
*!*			'"paises": ['+;
*!*			'{"codigopais": 1,"provincias": [{"codigoprovincia": "A" },{"codigoprovincia": "B" }]},'+;
*!*			'{"codigopais": 2,"provincias": [{"codigoprovincia": "C" },{"codigoprovincia": "D"}]} '+;
*!*					']'+;
*!*			'}'
*!*			
*!*	lPosicion = ATC('[{',pcjson,1)
*!*	lPosicion = ATC('}]',pcjson,1)
*!*	SET STEP ON

*!*	    
*!*	=oConversor.jsonToCursor(pcJSON)
*!*	BROWSE

* Tengo que crear un cursor/tabla para cada caso de prueba!!
*lResultado=equalscursor(lCursorObtenido,lCursorEsperado)

DEFINE CLASS Conversor AS CUSTOM

	#DEFINE CRLF					CHR(13) + CHR(10)
	
	estoyenarray=.F.
	columnacreada=.F.
	esunobjeto=.F.
	nombrecursor="cDatos"
	nombreprefijo=""
	agregoregistro=.F.
	nivelanidamiento=0
	cantidadobjetos=0
	
	
	PROCEDURE inicializaratributos()
			THIS.estoyenarray=.F.
			THIS.columnacreada=.F.
			THIS.esunobjeto=.F.
			THIS.nombrecursor="cDatos"
			THIS.nombreprefijo=""
			THIS.agregoregistro=.F.
			THIS.nivelanidamiento=0
			THIS.cantidadobjetos=0
	ENDPROC
	
	PROCEDURE jsonToCursor(pcJSON)
		
		THIS.inicializaratributos()
		*Preparo la zona de datos
		SET SAFETY OFF
		CLOSE DATABASES
		CREATE DATABASE pruebas
		IF USED(THIS.nombrecursor) THEN
			LOCAL lNombreCursor
			SELECT &lNombreCursor.
			USE
		ENDIF
		
		LOCAL lSentencia
		lSentencia = "CREATE TABLE " + THIS.nombreCursor + " (campo1 C(1))"
		&lSentencia
		
		THIS.Parse(pcJSON)
		
		* Limpio la zona de datos, si no hay otros campos mato el alias!!
		*CLOSE DATABASES??
		lSentencia = "ALTER TABLE " + THIS.nombrecursor  + " DROP COLUMN campo1"
		&lSentencia
		
	ENDPROC
	
	* Parse
	* Takes a JSON and creates a flat cursor with data
	PROCEDURE Parse(pcJSON)
	     *
		LOCAL oObjects, i, oResult, lIsArray, lIsVFP, cVFPClass
		STORE .F. TO lIsArray

		* Si es un array lo manda a json array
		DO CASE
			CASE LEFT(pcJSON,1) = "["
	            lISArray = .T.
	            THIS.estoyenarray=.T.
	            
			CASE LEFT(pcJSON,1) = [{]
				THIS.agregoregistro = .T.

		ENDCASE
	     
		pcJSON = SUBSTR(pcJSON,2,LEN(pcJSON) - 2) 
	     
		LOCAL oPairs, j, cPair, cProp, cValue, uValue, oObj, cObj, nBlockCount, nSep
		oObjects = THIS._Split(pcJSON)
	     
		FOR i = 1 TO oObjects.Count

			* Para cada objeto
			cObj = oObjects.Item[i]

			IF EMPTY(cObj) THEN
				LOOP
			ENDIF

			IF lIsArray AND THIS.IsObject(cObj)
				* Aca Tiene un objeto del array
				IF THIS.estoyenarray AND !THIS.columnacreada THEN
					THIS.columnacreada=.F.
				ENDIF
				THIS.cantidadobjetos = THIS.cantidadobjetos + 1

				LOCAL lNombreCursor
				lNombreCursor= THIS.nombrecursor
				SELECT &lNombreCursor.

				* Si hay un registro no toco nada, si no hay registros tengo que agregar
				* THIS.agregoregistro
*!*					IF RECCOUNT(THIS.nombrecursor) > 0 AND THIS.nivelanidamiento > 1 THEN
*!*						*APPEND BLANK
*!*						THIS.agregoregistro=.T.
*!*					ELSE
*!*						IF RECCOUNT(THIS.nombrecursor) = 0 THEN
*!*							*APPEND BLANK
*!*							THIS.agregoregistro=.F.
*!*						ENDIF
*!*					ENDIF
				* ESto es para cada objeto, 
				THIS.Parse(cObj)
				THIS.agregoregistro=.T.
				* La primera vez que pasa por aqui ya creo todas las columnas
				THIS.columnacreada=.T.
				* Continuamos con el resto de los objectos
				LOOP
			ENDIF

			* Tomo los pares simples de valores
			oPairs = THIS._Split(cObj)
			
			FOR j = 1 TO oPairs.Count
				
				* Para cada par de valor, me fijo si ya puedo obtener el valor o tengo que volver a parsear si es un objeto mas complejo
				cPair = ALLTRIM(oPairs.Item[j])
				IF lIsArray
					cValue = cPair
				ELSE
					nSep = AT(":",cPair)
					cProp = CHRTRAN(LEFT(cPair, nSep - 1),["'],[])
					cValue = ALLTRIM(SUBSTR(cPair, nSep + 1))
				ENDIF
	       
				* VES Ene 24, 2014
				* Si la propiedad empieza con $, se elimina pues es algo
				* particular de JavaScript que no es compatible con VFP
				IF !lIsArray AND LEFT(cPRop,1) = "$"
					cProp = SUBSTR(cProp,2)
				ENDIF
				
				LOCAL lTipoDato
				lTipoDato=""
	       
				DO CASE
					CASE LEFT(cValue,1) $ ['"]    && String value
						uValue = "'" + THIS._decodeString( LEFT(SUBSTR(cValue,2),LEN(cValue) - 2) ) + "'"
						lTipoDato="C(100)"
	               
					CASE LEFT(cValue,1) = [@]   && Date/DateTime
						cValue = SUBSTR(cValue,2)
						IF LEN(cValue) = 8
							uValue = CTOD(TRANSFORM(cValue,"@R ^9999-99-99"))
							lTipoDato="date"
						ELSE
							uValue = CTOT(TRANSFORM(cValue,"@R ^9999-99-99 99:99:99"))
							lTipoDato="datetime"
						ENDIF

					CASE INLIST(cValue,"true","false")  && Boolean value
						uValue = IIF(cValue == "true" , ".T.", ".F.")
						lTipoDato="logical"

					CASE UPPER(cValue) == "NULL" OR UPPER(cValue) == ".NULL." && Null value  &&  cesar
						uValue = ""
						lTipoDato="c(100)"
						
					CASE LEFT(cValue,1) = [{]   && Object
						* Agrego a menos que este adentro de otro objeto??
						THIS.agregoregistro=.T.
						THIS.esunobjeto=.T.
						THIS.nombreprefijo=cProp
						*THIS.cantidadobjetos = 0
						uValue = THIS.Parse(cValue)
						THIS.nombreprefijo=""
						THIS.agregoregistro=.F.
						LOOP

					CASE LEFT(cValue,1) = "["   && Array
						THIS.estoyenarray=.T.
						THIS.columnacreada=.F.
						
						*IF !ISBLANK(cProp) THEN
							*THIS.nombreprefijo=cProp
						*ENDIF
						
						THIS.nivelanidamiento= THIS.nivelanidamiento + 1
						
						LOCAL lNombreCursor
						lNombreCursor= THIS.nombrecursor
						SELECT &lNombreCursor.
						* Tengo que contar los niveles de anidamiento, para hacer los "JOINS"???
						* 0 registros, me quedo ahi, tengo 1 me voy arriba
						* Tengo dos
						*IF RECCOUNT(THIS.nombrecursor) <> 1 THEN
							GO TOP
						*ENDIF
						* Si hay un registro no toco nada
						uValue = THIS.parse(cValue)
						THIS.nivelanidamiento = THIS.nivelanidamiento - 1
						THIS.columnacreada=.F.
						THIS.nombreprefijo=""
						* No tengo que hacer mas nada luego abajo de salir del array
						LOOP

					OTHERWISE                   && Numeric value
						*uValue = VAL(STRTRAN(cValue, ".", SET("POINT")))  && JuanPa, Abril 13 2012
						* Fijarme como decodifico los decimales
						uValue = cValue
						lTipoDato = "N(12)"

				ENDCASE

				IF THIS.estoyenarray THEN
					
					* Esto es para cada atributo de que tenga valor "simple" de una cadena json
					LOCAL lSentencia,lNombreCursor
					lNombrecolumna = THIS.obtenerNombreUnicoColumna( cProp )

					lNombreCursor = THIS.nombrecursor
					SELECT &lNombreCursor.
					IF !THIS.columnacreada THEN
						lSentencia="ALTER TABLE cDatos ADD COLUMN " + lNombreColumna + " " + lTipoDato
						&lSentencia
					ENDIF

					
					IF RECCOUNT(THIS.nombrecursor) > 0 AND THIS.nivelanidamiento <> THIS.nivelanterior THEN
						APPEND BLANK
						THIS.agregoregistro=.T.
					ELSE
						IF RECCOUNT(THIS.nombrecursor) = 0 THEN
							APPEND BLANK
							THIS.agregoregistro=.F.
						ENDIF
					ENDIF

					* Reemplazo en base al nombre que deberia tener!!!!
					lSentencia="REPLACE " + lNombreColumna + " WITH " + uValue
					&lSentencia

				ELSE && Cuando no estoy en un array
					LOCAL lSentencia
					SELECT cDatos
					lNombreColumna=THIS.obtenerNombreUnicoColumna(cProp)
					lSentencia="ALTER TABLE cDatos ADD COLUMN " + lNombreColumna + " " + lTipoDato
					&lSentencia
					
					IF THIS.agregoregistro AND RECCOUNT(THIS.nombrecursor)=0 THEN
						APPEND BLANK
						THIS.agregoregistro=.F.
					ENDIF
					
					LOCAL lSentencia
					lSentencia="REPLACE " + lNombreColumna + " WITH " + uValue + " ALL "
					&lSentencia

				ENDIF

			ENDFOR
	      
		ENDFOR

	ENDPROC

	PROCEDURE _Split(pcJSON)
		 *
		LOCAL nBlockCount,cObj,lOpenQuote,cChar
		nBlockCount = 0  
		cObj = pcJSON
		lOpenQuote = .F.
		
		LOCAL stringDelimitator
		stringDelimitator = ["]
		
		FOR j = 1 TO LEN(cObj)
			cChar = SUBSTR(cObj, j, 1)
			DO CASE
				CASE cChar $ "[{"
		           nBlockCount = nBlockCount + 1
		   
				CASE cChar $ "]}"
		           nBlockCount = nBLockCount - 1

				CASE cChar $ stringDelimitator
					IF lOpenQuote
						nBlockCount = nBLockCount - 1
					ELSE
						nBlockCount = nBlockCount + 1 
					ENDIF
					lOpenQuote = !lOpenQuote

		    	CASE cChar = "," AND nBlockCount = 0
					cObj = STUFF(cObj,j,1,CHR(254))
			ENDCASE
		ENDFOR   
		 
		LOCAL ARRAY aObjects[1]
		LOCAL nCount, i, oResult
		oResult = CREATEOBJECT("Collection")
		nCount = ALINES(aObjects, STRT(cObj,CHR(254),CRLF))
		FOR i = 1 TO nCount
			oResult.add(aObjects[i])
		ENDFOR
		 
		RETURN oResult
		 *
	 ENDPROC
	 
	 
	PROCEDURE _decodeString(pcString)
		pcString = STRT(pcString, [%CR%], CHR(13))
		pcString = STRT(pcString, [%LF%], CHR(10))
		pcString = STRT(pcString, [%TAB%], CHR(9))
		pcString = STRT(pcString, [%SINGLEQUOTE%], ['])
		pcString = STRT(pcString, [%DOUBLEQUOTE%], ["])
		RETURN pcString
	ENDPROC


	 * isObject
	 * Check if the passed JSON string corresponds to an object
	PROCEDURE isObject(pcString)
		RETURN VARTYPE(pcString)="C" AND LEFT(pcString,1)="{" AND RIGHT(pcString,1)="}"
	ENDPROC

	PROCEDURE obtenerNombreUnicoColumna
			LPARAMETERS pNombreColumna
			
			LOCAL ARRAY aCampos[1]
			LOCAL lNombreCursor, lNombreColumna, lCantidadCampos, lRepeticiones, indice
			
			IF VARTYPE (THIS.nombreprefijo)="L" THEN
				THIS.nombreprefijo = ""
			ENDIF
			lNombreColumna = ALLTRIM(THIS.nombreprefijo) + ALLTRIM(pNombreColumna)
			
			IF LOWER(lNombreColumna) = 'id'
				*SET STEP ON
			ENDIF			
			
			lNombreCursor = THIS.nombrecursor
			SELECT &lNombreCursor.

			lCantidadCampos=AFIELDS(aCampos,THIS.nombrecursor)
			lRepeticiones = 0
			FOR indice=1 TO lCantidadCampos
				* Tengo que buscar el nombre del campo con las repeticiones que tenga
				* Si ya se repitio supongo asumo que fue creado con el numero de repeticion en el nombre
				LOCAL lCampoABuscar
				lCampoABuscar =  lNombreColumna + IIF(lRepeticiones>0, ALLTRIM(STR(lRepeticiones)),"")
				
				IF LOWER( lCampoABuscar ) = LOWER(aCampos[indice,1]) THEN
					lRepeticiones = lRepeticiones + 1
				ENDIF
			ENDFOR
			* Si estoy en un array no le sumo 1
			IF lRepeticiones > 0 THEN
				IF THIS.columnacreada THEN
					lRepeticiones = lRepeticiones - 1
				ENDIF
				RETURN lNombreColumna + IIF(lRepeticiones= 0,"",ALLTRIM(STR(lRepeticiones)))
			ELSE
				RETURN lNombreColumna
			ENDIF

	ENDPROC


ENDDEFINE

* JSONArray
* Takes an array an convert it to a JSONArray
PROCEDURE JSONArray(paArray)
	IF PCOUNT() = 1
		RETURN CREATEOBJECT("JSONArray",@paArray)
	ELSE
		RETURN CREATEOBJECT("JSONArray")
	ENDIF
ENDPROC

DEFINE CLASS JSONArray AS Collection
 *	
	Lines = 0
	Columns = 0
 
PROCEDURE Init(paArray)
	DO CASE 
     CASE PCOUNT() = 0
          THIS.Lines = 0
          THIS.Columns = 1
     
     CASE TYPE("ALEN(paArray)")="N"  && TYPE("paArray",1) = "A"
          LOCAL uItem
          THIS.Lines = ALEN(paArray,1)
          THIS.Columns = ALEN(paArray,2)
		  FOR EACH uItem IN paArray
		   THIS.Add(uItem)
		  ENDFOR
		  
	 CASE THIS._isArray(paArray)
	      LOCAL oItems, uItem
	      oItems = JSON.decodeArray(paArray)
	      THIS.Lines = oItems.Count
	      THIS.Columns = 1
	      FOR EACH uItem IN oItems
	       THIS.Add(uItem)
	      ENDFOR
	      
	 CASE THIS._isCollection(paArray)
	      LOCAL uItem
	      THIS.Lines = paArray.Count
	      THIS.Columns = 1
	      FOR EACH uItem IN paArray
	       THIS.Add(uItem)
	      ENDFOR
  ENDCASE
 ENDPROC
 
	PROCEDURE ToJSON()
		LOCAL ARRAY aContent[1]
		THIS.ToArray(@aContent)
		RETURN JSON.encodeArray(@aContent)
	ENDPROC
 
	PROCEDURE ToArray(paArray)
			LOCAL nRows,nCols
			nRows = IIF(THIS.Lines > 0, THIS.Lines, THIS.Count)
			nCols = IIF(THIS.Columns > 0, THIS.Columns, 1)
			DIMENSION paArray[nRows,nCols]
			LOCAL uItem, i
			FOR i = 1 TO THIS.COunt
				paArray[i] = THIS.Item[i]
			ENDFOR
			
			RETURN THIS.Count
	ENDPROC

	HIDDEN PROCEDURE _isArray(puValue)
		RETURN (VARTYPE(puValue)="C" AND LEFT(puValue,1) = "[" AND RIGHT(puValue,1)="]")
	ENDPROC
	 
	HIDDEN PROCEDURE _isCollection(puValue)
		RETURN (VARTYPE(puValue) = "O" AND PEMSTATUS(puValue,"BaseClass",5) AND LOWER(puValue.baseClass == "collection"))
	ENDPROC
 
 *
ENDDEFINE


DEFINE CLASS JSONEmpty AS Custom
	_customPropList = ""

	PROCEDURE addProperty(pcProp, puValue)
		DODEFAULT(pcProp, puValue)
		THIS._customPropList = THIS._customPropList + "[" + LOWER(pcProp) + "]"
	ENDPROC

	PROCEDURE _isProp(pcProp)
		RETURN (AT("[" + LOWER(pcProp) + "]", THIS._customPropList) <> 0)
	ENDPROC

	PROCEDURE _setPropValue(pcProp, puValue)
		IF THIS._isProp(pcProp)
			STORE puValue TO ("THIS." + pcProp)
		ENDIF
	ENDPROC
ENDDEFINE



PROCEDURE equalscursor(pCursorObtenido,pCursorEsperado)
	
	IF !USED(pCursorObtenido) THEN
		? "El alias: " + pCursorObtenido + " no esta en uso"
		RETURN .F.
	ENDIF

	IF !USED(lCursorObtenido) THEN
		? "El alias: " + pCursorObtenido + " no esta en uso"
		RETURN .F.
	ENDIF
	
	* Estructura
	LOCAL ARRAY aCamposObtenido[1,1]
	LOCAL ARRAY aCamposEsperado[1,1]
	LOCAL campo, lCantidadObtenido, lCantidadEsperado
	
	lCantidadObtenido = AFIELDS(aCamposObtenido,pCursorObtenido)
	lCantidadEsperado = AFIELDS(aCamposEsperado,pCursorEsperado)
	
	IF lCantidadEsperado <> lCantidadObtenido THEN
		? "Los cursores no tiene la misma cantidad de campos, Esperado: " + ALLTRIM(STR(lCantidadEsperado)) + ", obtenido: " + ALLTRIM(STR(lCantidadObtenido))
		RETURN .F.
	ENDIF
	
	FOR i = TO lCantidadObtenido
		IF LOWER(aCamposObtenido[i,1])<> LOWER(aCamposEsperado[i,1]) THEN
			? "El campo numero: "+ALLTRIM(STR(i))+" esta mal, valor esperado: " +ALLTRIM(aCamposObtenido[i,1]) + " valor obtenido: " + aCamposEsperado[i,1]
			RETURN .F.
		ENDIF
	ENDFOR
	
	* Valores
	LOCAL lCantidadObtenido
	SELECT &pCursorObtenido.
	COUNT TO lCantidadObtenido

	LOCAL lCantidadEsperado
	SELECT &pCursorEsperado.
	COUNT TO lCantidadEsperado
	
	IF lCantidadObtenido<>lCantidadEsperado THEN
		? "Cantidad de registro disinta, esperada: " + ALLTRIM(STR(lCantidadEsperado)) + " obtenido: "+ ALLTRIM(STR(lCantidadObtenido))
		RETURN .F.
	ENDIF
	
	SELECT &pCursorEsperado.
	* Para cada fila
	SCAN
	
		FOR i=1 TO lCantidadEsperado
			lEsperado = pCursorObtenido.&aCamposObtenido[i,1].
			lObtenido = pCursorEsperado.&aCamposEsperado[i,1].
			IF lEsperado<>lObtenido THEN
				? "El valor del campo esta mal"
				? "Esperado:"
				?lEsperado
				? "Obtenido"
				? lObtenido
				RETURN .F.
			ENDIF
		ENDFOR
		
	ENDFOR
	
	RETURN .T.

ENDPROC







