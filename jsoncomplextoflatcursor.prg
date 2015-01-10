

* Primero obtengo la cantidad de registros
*  Ejemplo:


SET DEFAULT TO d:\vfp\proyectos\jsonflatentitytovfpcursor

LOCAL pcJSON

* Bien!!!!!!!
*pcJSON='{"nombre":"German","apellido":"muñoz","telefono":{"descri":"Casa","numero":123}}'
*pcJSON='{"nombre":"German","apellido":"muñoz","telefono":{"descripcion":"Casa","Detalle":{"caracteristica":"314","numero":"123456"}}}'
*pcjson = '{"employees":[{"firstName":"Primero", "lastName":"perez"},{"firstName":"segundo", "lastName":"Gonzalez"}]}'
*pcjson= '{"profesiones":[{"ID":1,"nombre":"MEDICO"},{"ID":2,"nombre":"FONOAUDIOLOGO"},{"ID":3,"nombre":"KINESIOLOGO"}]}'
*pcjson= '{"profesiones":[{"ID":1},{"ID":2},{"ID":3}]}'

*pcjson='{"respuestaComunicacion":{"idTransaccion":15984,"respuestaBase":{"tiposRespuestaValidacion":"OK","mensaje":""}},'+;
*		'"profesiones":[{"ID":1,"nombre":"MEDICO"},{"ID":2,"nombre":"FONOAUDIOLOGO"},{"ID":3,"nombre":"KINESIOLOGO"}]}'

LOCAL oConversor

oConversor=CREATEOBJECT("Conversor")
=oConversor.claseACursor(pcJSON)

BROWSE

DEFINE CLASS Conversor AS CUSTOM

	#DEFINE CRLF					CHR(13) + CHR(10)
	
	estoyenarray=.F.
	columnacreada=.F.
	esunobjeto=.F.
	nombrecursor="cDatos"
	
	
	PROCEDURE claseACursor(pcJSON)
		SET SAFETY OFF
		CLOSE DATABASES
		*DELETE DATABASE pruebas
		CREATE DATABASE pruebas
		IF USED("cDatos") THEN
			SELECT cDatos
			USE
		ENDIF
		
		CREATE TABLE cDatos(campo1 C(1))
		
		THIS.Parse(pcJSON)
		
		ALTER TABLE cDatos DROP COLUMN campo1
		
	ENDPROC
	
	* Parse
	* Takes a JSON and creates a flat cursor with data
	PROCEDURE Parse(pcJSON)
	     *
		LOCAL oObjects, i, oResult, lIsArray, lIsVFP, cVFPClass
		STORE .F. TO lIsArray

		DO CASE
			* Si es un array lo manda a json array
			CASE LEFT(pcJSON,1) = "["
	            lISArray = .T.
	            THIS.estoyenarray=.T.
	            oResult = JSONArray()
	            
	        OTHERWISE 
	             #IF VERSION(5) >= 800
					oResult = CREATEOBJECT("Empty")         
	             #ELSE
					oResult = CREATEOBJECT("JSONEmpty")
	             #ENDIF
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
				oResult.Add(THIS.Parse(cObj))
				* La primera vez que pasa por aqui ya creo todas las columnas
				*THIS.esunobjeto=.T.
				THIS.columnacreada=.T.
				* Continuamos con el resto de los objectos
				LOOP
			ENDIF

			* Tomo los pares simples de valores
			oPairs = THIS._Split(cObj)

			#IF VERSION(5) >= 800
				oObj = CREATEOBJECT("Empty")
			#ELSE
				oObj = CREATEOBJECT("JSONEmpty")
			#ENDIF
			
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
	          
					CASE INLIST(cValue,"true","false")  && Boolean value
						uValue = (cValue == "true")
	             
					CASE UPPER(cValue) == "NULL" OR UPPER(cValue) == ".NULL." && Null value  &&  cesar
						uValue = NULL
	                
					CASE LEFT(cValue,1) = [{]   && Object
						uValue = THIS.Parse(cValue)
						THIS.esunobjeto=.T.
	               
					CASE LEFT(cValue,1) = "["   && Array
						THIS.estoyenarray=.T.
						THIS.columnacreada=.F.
						uValue = THIS.Parse(cValue)
						THIS.columnacreada=.F.
						* No tengo que hacer mas nada luego abajo de salir del array
						LOOP
						
						
					OTHERWISE                   && Numeric value
						uValue = VAL(STRTRAN(cValue, ".", SET("POINT")))  && JuanPa, Abril 13 2012
						lTipoDato = "N(4)"

				ENDCASE

				DO CASE
					
					*CASE THIS.estoyenarray
					CASE lIsArray
						*THIS.estoyenarray=.F.
						*oResult.Add(uValue)
					
					* Si es un objeto sigo las demas propiedades, porque ya lo parsee y cree las columnas
					CASE THIS.esunobjeto=.T.
						THIS.esunobjeto=.F.
						*THIS.columnacreada=.F.
						
					OTHERWISE
						*ADDPROPERTY(oResult,cProp,uValue)
						* Si es una propiedad simple
						* Puedo crear una columna
						IF !THIS.estoyenarray THEN
							LOCAL lSentencia
							SELECT cDatos
							lNombreColumna=THIS.obtenerNombreUnicoColumna(cProp)
							lSentencia="ALTER TABLE cDatos ADD COLUMN " + lNombreColumna + " " + lTipoDato
							&lSentencia
							
							LOCAL lSentencia
							lSentencia="REPLACE " + lNombreColumna + " WITH " + cValue + " ALL "
							&lSentencia
						ELSE
							IF !THIS.columnacreada THEN
								LOCAL lSentencia
								SELECT cDatos
								lNombrecolumna=THIS.obtenerNombreUnicoColumna(cProp)
								lSentencia="ALTER TABLE cDatos ADD COLUMN " + lNombreColumna + " " + lTipoDato
								&lSentencia
							ENDIF

							*APPEND BLANK

							*lSentencia="REPLACE " + lNombreColumna + " WITH " + cValue
							*&lSentencia
							
						ENDIF
						
						
				ENDCASE

			ENDFOR
	      
		ENDFOR
		
*!*			LOCAL ARRAY aCampos(1)
*!*			SELECT cDatos
*!*			AFIELDS(aCampos(1))
		*lSentencia= "ALTER TABLE " + THIS.nombrecursor + " DROP COLUMN campo1 "
		*&lSentencia
		
		RETURN oResult
	     *
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
			
			LOCAL aCampos[1], lNombreCursor
			
			lNombreCursor = THIS.nombrecursor
			SELECT &lNombreCursor.

			lCantidadCampos=AFIELDS(aCampos,THIS.nombrecursor)
			lRepeticiones = 0
			FOR indice=1 TO lCantidadCampos
				IF  LOWER(ALLTRIM(pNombreColumna)) = LOWER(ALLTRIM(aCampos[indice,1])) THEN
					lRepeticiones = lRepeticiones + 1
				ENDIF	
			ENDFOR
			IF lRepeticiones > 0 THEN
				lRepeticiones = lRepeticiones + 1
				RETURN ALLTRIM(pNombreColumna) + ALLTRIM(STR(lRepeticiones))
			ELSE
				RETURN ALLTRIM(pNombreColumna)
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