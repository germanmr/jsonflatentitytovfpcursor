

* TODO
* Le puedo pasar un array con los nombres de algunos campos de json y con el tipo de dato????

SET DEFAULT TO d:\vfp\proyectos\jsonflatentitytovfpcursor

LOCAL pcJSON
LOCAL oConversor

oConversor=CREATEOBJECT("Conversor")

* Bien!!!!!!!
*!*	pcJSON='{"nombre":"German","apellido":"muñoz"}'
*!*	=oConversor.jsonToCursor(pcJSON)
*!*	BROWSE

*!*	pcJSON='{"nombre":"German","apellido":"muñoz","telefono":{"descripcion":"Casa","numero":123}}'
*!*	=oConversor.jsonToCursor(pcJSON)
*!*	BROWSE

*!*	pcJSON='{"nombre":"German","apellido":"muñoz","telefono":{"descripcion":"Casa","Detalle":{"caracteristica":"314","numero":"123456"}}}'
*!*	=oConversor.jsonToCursor(pcJSON)
*!*	BROWSE

*!*	pcjson= '{"profesiones":[{"ID":1},{"ID":2},{"ID":3}]}'
*!*	=oConversor.jsonToCursor(pcJSON)
*!*	BROWSE

*!*	* Si aplano la entidad me queda como una fila

*!*	pcjson= '{"profesiones":[{"ID":1,"nombre":"MEDICO"},{"ID":2,"nombre":"FONOAUDIOLOGO"},{"ID":3,"nombre":"KINESIOLOGO"}]}'
*!*	=oConversor.jsonToCursor(pcJSON)
*!*	BROWSE

*!*	pcjson = '{"employees":[{"firstName":"Primero", "lastName":"perez"},{"firstName":"segundo", "lastName":"Gonzalez"}]}'
*!*	=oConversor.jsonToCursor(pcJSON)
*!*	BROWSE

*!*	pcjson='{tiposRespuestaValidacion: "OK",mensaje: "Hay comunicacion"}'
*!*	=oConversor.jsonToCursor(pcJSON)
*!*	BROWSE

*!*	pcjson='{"respuestaComunicacion":{"idTransaccion":15984,"respuestaBase":{"tiposRespuestaValidacion":"OK","mensaje":""}},'+;
*!*			'"profesiones":[{"ID":1,"nombre":"MEDICO"},{"ID":2,"nombre":"FONOAUDIOLOGO"},{"ID":3,"nombre":"KINESIOLOGO"}]}'
*!*	=oConversor.jsonToCursor(pcJSON)
*!*	BROWSE

*!*	pcjson= '{"respuestaComunicacion":{"idTransaccion":316,"respuestaBase":{"tiposRespuestaValidacion":"OK","mensaje":""}},'+;
*!*			'"respuestaElegibilidadAfiliado":{"estadoGeneral":{"tiposRespuestaValidacion":"OK","mensaje":""},"detalleElegibilidadAfiliado":{'+;
*!*			'"afiliado":{"ID":"32165478","nombre":"PEREZ JUAN","convenio":{"ID":1,"nombre":"IAPOS"},"plan":{"ID":1,"nombre":"Dpto ROSARIO"}},'+;
*!*			'"modoIngresoAfiliado":"M","observaciones":""}}}'
*!*	=oConversor.jsonToCursor(pcJSON)
*!*	BROWSE

*!*	lJSonRechazada='{"rechazadas": ['+;
*!*	'{"baseAmbulatorio":{"ID": 320376,"afiliado": {"ID": "00000001234567","nombre": "COSME FULANITO","convenio": {"ID": 2,'+;
*!*	'"nombre": "AMR Salud"},"plan": {"ID": 51,"nombre": "1000/01"}},"prestador": {"codigoProfesion": 1,"matricula": 99999,"libro": "     ",'+;
*!*	'"folio": "     "},"efector": {"ID": {"codigoProfesion": 1,"matricula": 9999,"libro": "     ","folio": "     "},"nombre": "PEPE"},'+;
*!*	'"prescriptor": {"ID": {"codigoProfesion": 1,"matricula": 19999,"libro": "     ","folio": "     "},"nombre": "ATILIO"},'+;
*!*	'"fechaPrestacion": "2014/09/25"},'+;
*!*	'"prestacionSolicitadaBase": {"nomencladorBase": {"codigoNomenclador": "669464","ID": "669464","Nombre": "TIROGLOBULINA - líquido de punción (TG LP)"'+;
*!*	'},"cantidad": 1},"delegacion": {"ID": 1,"nombre": "Dpto ROSARIO"},"modoIngresoAfiliado": "M","sid": "31739","evaluacionSolicitudCompleta": {'+;
*!*	'"evaluacionSolicitud": {"respuestaBase": {"tiposRespuestaValidacion": "NOAUTORIZA","mensaje": ""},'+;
*!*	'"observaciones": ""},"leyenda": "La prestación NO PUEDE SER AUTORIZADA por el sistema,por favor diríjase a la delegación más cercana para consultar"'+;
*!*	'}},'+;
*!*	'{"baseAmbulatorio":{"ID": 320376,"afiliado": {"ID": "123456","nombre": "ESTE NO ES COSME ","convenio": {"ID": 2,'+;
*!*	'"nombre": "AMR Salud"},"plan": {"ID": 51,"nombre": "1000/01"}},"prestador": {"codigoProfesion": 1,"matricula": 99999,"libro": "     ",'+;
*!*	'"folio": "     "},"efector": {"ID": {"codigoProfesion": 1,"matricula": 9999,"libro": "     ","folio": "     "},"nombre": "PEPE"},'+;
*!*	'"prescriptor": {"ID": {"codigoProfesion": 1,"matricula": 19999,"libro": "     ","folio": "     "},"nombre": "ATILIO"},'+;
*!*	'"fechaPrestacion": "2014/09/25"},'+;
*!*	'"prestacionSolicitadaBase": {"nomencladorBase": {"codigoNomenclador": "669464","ID": "669464","Nombre": "TIROGLOBULINA - líquido de punción (TG LP)"'+;
*!*	'},"cantidad": 1},"delegacion": {"ID": 1,"nombre": "Dpto ROSARIO"},"modoIngresoAfiliado": "M","sid": "31739","evaluacionSolicitudCompleta": {'+;
*!*	'"evaluacionSolicitud": {"respuestaBase": {"tiposRespuestaValidacion": "NOAUTORIZA","mensaje": ""},'+;
*!*	'"observaciones": ""},"leyenda": "La prestación NO PUEDE SER AUTORIZADA por el sistema,por favor diríjase a la delegación más cercana para consultar"'+;
*!*	'}}]'+;
*!*	'}'

*!*	=oConversor.jsonToCursor(lJSonRechazada)
*!*	BROWSE

*!*	lJsonAutorizada='{"baseAmbulatorio": {"ID": "00000422289","afiliado": {"ID": "0000000321321321","nombre": "COSME FULANITO",'+;
*!*		'"convenio": {"ID": 2,"nombre": "AMR Salud"},"plan": {"ID": 52,"nombre": "2000/01 - Exento"}},"prestador": {"codigoProfesion": 4,'+;
*!*		'"matricula": 64758,"libro": "     ","folio": "     "},"efector": {"ID": {"codigoProfesion": 1,"matricula": 4275,"libro": "     ",'+;
*!*		'"folio": "     "},"nombre": "DR CHAPATIN"},"prescriptor": {"ID": {"codigoProfesion": 1,"matricula": 4275,"libro": "     ","folio": "     "'+;
*!*		'},"nombre": "DR CHAPATIN"},"fechaPrestacion": "2014/08/21"}'+;
*!*		',"prestacionesRealizadas": [{"prestacionSolicitadaBase": {"nomencladorBase": {"codigoNomenclador": "420101","ID": "420101",'+;
*!*		'"Nombre": "CONSULTA EN CONSULTORIO."},"cantidad": 1},"importePrestacion": {"moneda": {"ID": 1,"nombre": "Pesos"},"coseguro": 0,'+;
*!*		'"coseguroIva": 0,"coseguroPorcentaje": 0,"honorarios": 0,"derechos": 0,"iva": 0,"coseguroTexto": "Sin Cargo"}}],"fechaAutorizacion": "2014/08/21"}'


*!*	* Puedo hacer un bucle hasta el proxima '},{ "baseAmbulatorio":' y luego un append

*!*	*!*	

*!*	DIMENSION aTiposDatos[2]
*!*	aTiposDatos[1]=CREATEOBJECT("TipoDato","afiliadoid","C(15)")
*!*	aTiposDatos[2]=CREATEOBJECT("TipoDato","coseguroPorcentaje","N(12,2)")

*!*	=oConversor.jsonToCursor(lJsonAutorizada, @aTiposDatos)
*!*	BROWSE

*!*	lCantidadCampos = AFIELDS(aCampos,ALIAS())

*!*	FOR i=1 TO lCantidadCampos
*!*		*MESSAGEBOX(LOWER(aCampos[i,1]))
*!*	ENDFOR
*!*	MODIFY STRUCTURE


* Dos niveles de anidamiento
*!*	pcjson='{"respuestaAutorizarLista": {'+;
*!*				' respuestaBase: { '+;
*!*	        	' "tiposRespuestaValidacion": "OK", '+;
*!*	        	' "mensaje": ""
*!*				'},'+;
*!*	'"auditorias": [], '+;
*!*	'"rechazadas": [], '+;
*!*	'"autorizadaDTO": { "ID": "A02-L31-K62" } '+;
*!*	'}'


* Indico el nodo de donde cortar, un solo nivel

*!*	pcjson='{ "respuestaComunicacion": {"idTransaccion": 17147,"respuestaBase": {"tiposRespuestaValidacion": "OK","mensaje": ""'+;
*!*	'}},"autorizadas": [{"baseAmbulatorio": {"ID": "A02-R34-R85","afiliado": {"ID": "000000038132293",'+;
*!*	'"nombre": "GONZALEZ ROXANA L","convenio": {"ID": 1,"nombre": "IAPOS"},"plan": { "ID": 1,"nombre": "Dpto ROSARIO"'+;
*!*	'}},"prestador": {"codigoProfesion": 4,"matricula": 64758,"libro": " ","folio": " "},"efector": {"ID": {"codigoProfesion": 1,'+;
*!*	'"matricula": 1,"libro": " ","folio": " "},"nombre": "MEDICO OTRA CIRCUNSCRIPCION / GUARDIA"},"prescriptor": {'+;
*!*	'"ID": {"codigoProfesion": 1,"matricula": 1,"libro": " ","folio": " "},"nombre": "MEDICO OTRA CIRCUNSCRIPCION / GUARDIA"},'+;
*!*	'"fechaPrestacion": "2014/07/01"},"prestacionesRealizadas": [{"prestacionSolicitadaBase": {"nomencladorBase": {"codigoNomenclador": "420601",'+;
*!*	'"ID": "420601","Nombre": "CONSULTA GUARDIA MEDICA"},"cantidad": 1},"importePrestacion": {"moneda": {"ID": 5,"nombre": "Ordenes Consultas"},'+;
*!*	'"coseguro": 1.00,"coseguroIva": 0.00,"coseguroPorcentaje": 0.00,"honorarios": 0.00,"derechos": 0.00,"iva": 0.00,"coseguroTexto": "1 Orden Consulta"'+;
*!*	'}}],"fechaAutorizacion": "2014/07/01"},{"baseAmbulatorio": {"ID": "A02-R34-S19","afiliado": {"ID": "000000028148440","nombre": "PEDRIEL WALTER SEBAS",'+;
*!*	'"convenio": {"ID": 1,"nombre": "IAPOS"},"plan": {"ID": 1,"nombre": "Dpto ROSARIO"}},"prestador": {"codigoProfesion": 4,"matricula": 64758,'+;
*!*	'"libro": " ","folio": " "},"efector": {"ID": {"codigoProfesion": 1,"matricula": 1,"libro": " ","folio": " "},"nombre": "MEDICO OTRA CIRCUNSCRIPCION / GUARDIA"},'+;
*!*	'"prescriptor": {"ID": {"codigoProfesion": 1,"matricula": 1,"libro": " ","folio": " "},"nombre": "MEDICO OTRA CIRCUNSCRIPCION / GUARDIA"},'+;
*!*	'"fechaPrestacion": "2014/07/01"},"prestacionesRealizadas": [{"prestacionSolicitadaBase": {"nomencladorBase": {"codigoNomenclador": "420601",'+;
*!*	'"ID": "420601","Nombre": "CONSULTA GUARDIA MEDICA"},"cantidad": 1},"importePrestacion": {"moneda": {"ID": 5,"nombre": "Ordenes Consultas"},'+;
*!*	'"coseguro": 1.00,"coseguroIva": 0.00,"coseguroPorcentaje": 0.00,"honorarios": 0.00,"derechos": 0.00,"iva": 0.00,"coseguroTexto": "1 Orden Consulta"'+;
*!*	'}}],"fechaAutorizacion": "2014/07/01"}]}'

*!*	lNombreNodo = "autorizadas"

*!*	DIMENSION aTiposDatos[1]
*!*	aTiposDatos[1]=CREATEOBJECT("TipoDato","afiliadoid","C(15)")

*!*	=oConversor.jsonAColeccion(pcjson, lNombreNodo,@aTiposDatos)

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
	DIMENSION acampos[1]
	
	PROCEDURE inicializaratributos()
			THIS.estoyenarray=.F.
			THIS.columnacreada=.F.
			THIS.esunobjeto=.F.
			THIS.nombrecursor="cDatos"
			THIS.nombreprefijo=""
			THIS.agregoregistro=.F.
			* Seteos basicos e importantes!!!!!
			SET SAFETY OFF
			SET EXACT ON
	ENDPROC
	
	* De una cadena json me da una coleccion de objetos para luego ser parseados por nodo
	* Este metodo es para mas un solo anidamiento de objetos
	* Devuelvo un cursor del nodo especificado
	* Tiene que estar en primer nivel y no contener arrays anidados
	PROCEDURE jsonAColeccion(pcjson, pNombreNodo,aTiposDatos)
		
		THIS.inicializaratributos()

		pcJSON = SUBSTR(pcJSON,2,LEN(pcJSON) - 2) 

		LOCAL oNodos, i, cBloque, lAtributoBuscado, lNombrenodo
		oNodos = THIS._Split(pcJSON)
		
		oNodo = .NULL.
		
		FOR i = 1 TO oNodos.Count
			cBloque = oNodos.Item[i]
			lAtributoBuscado = '"' + LOWER(pNombreNodo) + '"'
			lNombrenodo = LEFT(LOWER(cBloque),LEN(LOWER(pNombreNodo)) + 2 )
			IF lAtributoBuscado = lNombreNodo THEN
				oNodo = cBloque
				EXIT
			ENDIF
		ENDFOR
		
		IF !ISNULL(oNodo) THEN
			CREATE CURSOR cNodo(valor memo)
			INSERT INTO cNodo(valor)VALUES(oNodo)
			BROWSE

			THIS.jsonToCursor("{" + oNodo + "}", @aTiposDatos)
		ELSE
			* No existe el nodo en las condiciones indicadas
			RETURN .NULL.
		ENDIF
		
	ENDPROC	
	
	PROCEDURE jsonToCursor(pcJSON, aTiposDatos)
		
		THIS.inicializaratributos()
		
		IF VARTYPE(aTiposDatos) <>"U"
			LOCAL lCantidad
			lCantidad = ALEN(aTiposDatos)
			DIMENSION THIS.aCampos(lCantidad)
			
			LOCAL lCampo, i
			i=1
			FOR EACH lCampo IN aTiposDatos
				THIS.aCampos[i]=aTiposDatos[i]
				i = i + 1
			ENDFOR
		ENDIF	
		
		
		*Preparo la zona de datos
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

				LOCAL lNombreCursor
				lNombreCursor= THIS.nombrecursor
				SELECT &lNombreCursor.

				* Si hay un registro no toco nada, si no hay registros tengo que agregar
				IF THIS.agregoregistro AND RECCOUNT(THIS.nombrecursor) > 0 THEN
					APPEND BLANK
					THIS.agregoregistro=.F.
				ELSE
					IF RECCOUNT(THIS.nombrecursor) = 0 THEN
						APPEND BLANK
						THIS.agregoregistro=.F.
					ENDIF
				ENDIF
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
						uValue = THIS._decodeString( LEFT(SUBSTR(cValue,2),LEN(cValue) - 2) )
						lTipoDato="C(100)"
	               
					CASE LEFT(cValue,1) = [@]   && Date/DateTime
						cValue = SUBSTR(cValue,2)
						IF LEN(cValue) = 8
							uValue = CTOD(TRANSFORM(cValue,"@R ^9999-99-99"))
						ELSE
							uValue = CTOT(TRANSFORM(cValue,"@R ^9999-99-99 99:99:99"))
						ENDIF
						lTipoDato="date"
	          
					CASE INLIST(cValue,"true","false")  && Boolean value
						uValue = (cValue == "true")
						lTipoDato="logical"

					CASE UPPER(cValue) == "NULL" OR UPPER(cValue) == ".NULL." && Null value  &&  cesar
						uValue = NULL
	                
					CASE LEFT(cValue,1) = [{]   && Object
						* Agrego a menos que este adentro de otro objeto??
						THIS.agregoregistro=.T.
						THIS.esunobjeto=.T.
						* le puedo agregar al pregfijo los ultimos dos niveles de anidamiento de objetos???
						THIS.nombreprefijo= cProp
						uValue = THIS.Parse(cValue)
						THIS.nombreprefijo=""
						THIS.agregoregistro=.F.
						LOOP

					CASE LEFT(cValue,1) = "["   && Array
						THIS.estoyenarray=.T.
						THIS.columnacreada=.F.
						THIS.nombreprefijo= cProp
						LOCAL lNombreCursor
						lNombreCursor= THIS.nombrecursor
						SELECT &lNombreCursor.
						GO TOP
						* Si hay un registro no toco nada
						uValue = THIS.parse(cValue)
						THIS.columnacreada=.F.
						THIS.nombreprefijo=""
						* No tengo que hacer mas nada luego abajo de salir del array
						LOOP

					OTHERWISE                   && Numeric value
						uValue = VAL(STRTRAN(cValue, ".", SET("POINT")))  && JuanPa, Abril 13 2012
						* TODO - decode numeber
						lTipoDato = "N(10)"

				ENDCASE

				LOCAL lSentencia, lNombreCursor, lTipoDatoForzado, lNombreColumna, lSufijo
				lNombrecolumna = THIS.obtenerNombreUnicoColumna( cProp )
				
				lTipoDatoForzado= THIS.obtenerTipoDato(lNombrecolumna)

				IF !ISBLANK( lTipoDatoForzado ) THEN
					lTipoDato = lTipoDatoForzado
				ENDIF
				
				* Reemplazo en base al nombre que deberia tener!!!!
				lNombreCursor = THIS.nombrecursor
				SELECT &lNombreCursor.

				* si estoy recorriendo un array
				IF THIS.estoyenarray THEN
				
					lSufijo = ""
					
					IF !THIS.columnacreada THEN
						lSentencia="ALTER TABLE cDatos ADD COLUMN " + lNombreColumna + " " + lTipoDato
						&lSentencia
					ENDIF

				ELSE && Cuando no estoy en un array
					
					lSufijo =" ALL"
				
					lSentencia="ALTER TABLE cDatos ADD COLUMN " + lNombreColumna + " " + lTipoDato
					&lSentencia

					IF THIS.agregoregistro AND RECCOUNT(THIS.nombrecursor)=0 THEN
						APPEND BLANK
						THIS.agregoregistro=.F.
					ENDIF
					
				ENDIF
				
				lSentencia="REPLACE " + lNombreColumna + " WITH " + cValue
				&lSentencia				


			ENDFOR
	      
		ENDFOR
		
		*RETURN oResult

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
			LOCAL lNombreColumna, lNombreCursor, lCantidadCampos, lRepeticiones, lIndice, lCampoEncontrado
			
			lNombreColumna = ALLTRIM(THIS.nombreprefijo) + ALLTRIM(pNombreColumna)
			
			lNombreCursor = THIS.nombrecursor
			SELECT &lNombreCursor.

			lCantidadCampos=AFIELDS(aCampos,THIS.nombrecursor)
			lRepeticiones = 0

			FOR lIndice=1 TO lCantidadCampos
				* Tengo que buscar el nombre del campo con las repeticiones que tenga
				* Si ya se repitio supongo asumo que fue creado con el numero de repeticion en el nombre
				LOCAL lCampoABuscar
				lCampoABuscar =  LOWER(ALLTRIM(lNombreColumna) + IIF(lRepeticiones>0, ALLTRIM(STR(lRepeticiones)),""))

				IF lCampoABuscar = LOWER(aCampos[lIndice,1])  THEN
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
	
	PROCEDURE obtenerTipoDato(pNombreCampo)
		
		LOCAL campo
		
		FOR EACH campo IN THIS.aCampos
		
			IF LOWER(ALLTRIM(campo.nombreColumna)) = LOWER(ALLTRIM(pNombreCampo)) THEN
				RETURN campo.tipodato
			ENDIF
		
		ENDFOR
		
		* Si no encontramos nada lo creamos con el valor por defecto
		RETURN ""
	
	ENDPROC


ENDDEFINE


DEFINE CLASS TipoDato AS CUSTOM
	
	* Es el nombre dela columna del cursor
	nombreColumna=""
	* Es una cadena representando el tipo de dato, ej: N(12,2)
	tipoDato=""
	
	PROCEDURE INIT(pNombreColumna, pTipoDato)
		THIS.nombreColumna=pNombreColumna
		THIS.tipoDato=pTipoDato
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







