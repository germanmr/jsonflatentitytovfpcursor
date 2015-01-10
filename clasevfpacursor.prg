
CLOSE ALL
CLEAR ALL
CLEAR

*SET DEFAULT TO D:\vfp\Proyectos\qdfoxjson1.8
SET DEFAULT TO D:\vfp\Proyectos\jsonflatentitytovfpcursor

SET PROCEDURE TO D:\vfp\Proyectos\qdfoxjson1.8\qdfoxJSON ADDITIVE
JSONStart()

*Referencias:
* (1)
* Maximum number of characters in field names in a free table. 10
* Maximum number of characters in field names for a table contained in a database. 128 
LOCAL oCreado
*oCreado=jsonObject('{"respuestaComunicacion":{"idTransaccion":565,"respuestaBase":{"tiposRespuestaValidacion":"OK","mensaje":""}}}')

LOCAL lCadenaJson
lCadenaJson = '{"codigoAfiliado":"65987654", "diagnostico":"","prestacionSolicitadas":[{"codigoPrestacion":"420101","cantidad":1},{"codigoPrestacion":"420101","cantidad":1}]}'

lCadenaJson = '{"employees":[{"firstName":"John", "lastName":"Doe"}, {"firstName":"Anna",	"lastName":"Smith"},{"firstName":"Peter", "lastName":"Jones"}]}'

oCreado=jsonObject(lCadenaJson)

*!*	respuestaComunicacionidTransaccion
*!*	565

*!*	respuestaBasetiposRespuestaValidacion
*!*	OK
*!*	respuestaBasemensaje


LOCAL oPersona, aTelefonos[3], aDirecciones[3], lNombreCursor, oConversor, lSentencia

aTelefonos[1]=CREATEOBJECT("Telefono","TELE 1","1")
aTelefonos[2]=CREATEOBJECT("Telefono","TELE 2","2")
aTelefonos[3]=CREATEOBJECT("Telefono","TELE 3","3")

aDirecciones[1]=CREATEOBJECT("Direccion","CALLE 1","A")
aDirecciones[2]=CREATEOBJECT("Direccion","CALLE 2","B")
aDirecciones[3]=CREATEOBJECT("Direccion","CALLE 3","C")

oPersona=CREATEOBJECT("Persona","GERMAN","MUÑOZ",@aTelefonos,@aDirecciones)

oConversor = CREATEOBJECT("Conversor") 

LOCAL oRespuesta
oRespuesta = oCreado.buff
*.respuestacomunicacion

lNombreCursor=oConversor.claseACursor(oRespuesta)

SELECT &lNombreCursor.
BROWSE

 * loopeo en cada atributo
 * si es simple, creo una columna por cada campo
 * ADD COLUMN nombre propiedad de clase
 * si es una clase voy a ver que tiene adentro

* Una clase puede tener
* 1) Propiedades simples: nombre, esto es una columna y un valor
* 2) Clases:
* 3) Arrays de 1) y 2)

DEFINE CLASS Conversor AS CUSTOM
	
	estoyenarray=.F.
	existecolumna=.F.
	nombrecursor=""
	#DEFINE VFP_NOENCODABLE_PROPS	"-comment-name-tag-controls-controlcount-objects-parent-class-baseclass-classlibrary-parentclass-helpcontextid-whatsthishelpid-top-left-width-height-picture-_customproplist-"

	PROCEDURE INIT()
		SET SAFETY OFF
	ENDPROC 

	PROCEDURE claseACursor
		LPARAMETERS oObjeto
		
		LOCAL lSentencia, lCursorObtenido

		* Esto o hago por (1)
		CLOSE DATABASES
		DELETE DATABASE Pruebas
		CREATE DATABASE Pruebas
		THIS.nombrecursor="c" + ALLTRIM("Datos")
		
		lSentencia = "CREATE TABLE " + THIS.nombrecursor + "(campo1 C(1))"
		&lSentencia
		
		lCursorObtenido=THIS.decode(oObjeto )
		
		lSentencia= "ALTER TABLE " + THIS.nombrecursor + " DROP COLUMN campo1 "
		&lSentencia
		
		RETURN THIS.nombrecursor
		 
	 ENDPROC

	PROCEDURE decode
	LPARAMETERS oObjeto
		*******************************************************************************
		LOCAL ARRAY aMiembros(1)
		LOCAL lIndice, lMiembro, lnCantidadMiembros, lSentencia, lTipoDato, lEsUnArray, lNombreColumna, lPropiedadSimple
		
		lnCantidadMiembros = AMEMBERS(aMiembros,oObjeto,1)   && Get member list
		
		FOR lIndice = 1 TO lnCantidadMiembros && Recorro todos los miembros
		
			IF aMiembros[lIndice,2] = "Property" THEN && Solo proceso los miembros que son propiedades de la clase, NO LOS EVENTOS
				
				lMiembro = aMiembros[lIndice,1]

				* Solo proceso las propiedades que NO son las de VFP por defecto
				IF "-" + LOWER(lMiembro) + "-" $ VFP_NOENCODABLE_PROPS
					LOOP
				ENDIF
				
				lSentencia ="lTipoDato = VARTYPE(oObjeto." + lMiembro + ")"
				&lSentencia

				IF lTipoDato="O" THEN
					lPropiedadSimple = .F.
					
					LOCAL lVerifica, lClase
					lVerifica = oObjeto.&lMiembro.
					lClase = lVerifica.parentclass
					
					* Puede ser un array, porque VARTYPE no distingue entre objeto y array
					*lSentencia = ' lEsUnArray = ( TYPE( ALEN(' + lVerifica + ') ) = "N" ) '
					*&lSentencia
					*lEsUnArray = ()
					* Los objetos y los array los tengo que volver recorrer
					*IF TYPE(lVerifica,1) = "C" THEN
					IF LOWER(lClase) = "collection" THEN
						LOCAL ARRAY aCopiado[1]
			
						*ACOPY(oObjeto.&lMiembro.,aCopiado)
						*=THIS.decodeArray(@aCopiado )
						=THIS.decodeArray(oObjeto.&lMiembro.)
					
					ELSE
						=THIS.decode(oObjeto.&lMiembro. )
					ENDIF
					
					LOOP

				ELSE
					lPropiedadSimple = .T.
				ENDIF
				
				lSentencia= "SELECT " + THIS.nombreCursor
				&lSentencia

				* El nombre de la columna no se puede repetir, busco un nombre unico
				lNombreColumna = oObjeto.class + LOWER(lMiembro)
				IF !THIS.estoyenarray THEN	
					* Aca llega siempre una propiedad simple
					lNombreColumna=THIS.obtenerNombreUnicoColumna(lNombreColumna )
					lSentencia= "ALTER TABLE " + THIS.nombrecursor + " ADD COLUMN " +  lNombreColumna + " " + VARTYPE(lMiembro) + "(30)"
					&lSentencia

				ELSE
					IF !THIS.existecolumna THEN
						lNombreColumna=THIS.obtenerNombreUnicoColumna(lNombreColumna)
						lSentencia= "ALTER TABLE " + THIS.nombrecursor + " ADD COLUMN " +  lNombreColumna + " " + VARTYPE(lMiembro) + "(30)"
						&lSentencia
						GO TOP
					ENDIF

				ENDIF
				
				IF RECCOUNT()=0 THEN
					APPEND BLANK
				ENDIF
				
				LOCAL lAlcance
				lAlcance=""
				IF !THIS.estoyenarray AND lPropiedadSimple THEN
					lAlcance= " ALL"
				ENDIF
				
				lSentencia= "REPLACE " + LOWER(lNombreColumna) + " WITH oObjeto." + LOWER(lMiembro) + lAlcance
				&lSentencia
				
			ENDIF

		ENDFOR
		
	ENDPROC	


	PROCEDURE decodeArray
		LPARAMETERS aPropiedades
		LOCAL propiedad, lIndice

		LOCAL lNombreCursor
		lNombreCursor=THIS.nombrecursor
		SELECT &lNombreCursor.
		
		THIS.existecolumna=.F.
		THIS.estoyenarray=.T.
		lIndice=1
		FOR EACH propiedad IN aPropiedades

			=THIS.decode(propiedad )
			
			*IF lIndice < ALEN(aPropiedades)
			IF lIndice < aPropiedades.count
				APPEND BLANK
			ENDIF
			lIndice = lIndice + 1
			
			* En la primera vuelta creo todos las columnas
			IF THIS.existecolumna=.F. THEN
				THIS.existecolumna=.T.
			ENDIF
			
		ENDFOR
		THIS.estoyenarray=.F.
		THIS.existecolumna=.F.

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

DEFINE CLASS Persona AS CUSTOM
	nombre=""
	apellido=""
	DIMENSION atelefonos(1)
	DIMENSION zDirecciones(1)	

	PROCEDURE INIT(pNombre, pApellido, pTelefonos, pDirecciones)
		THIS.nombre=pNombre
		THIS.apellido=pApellido
		
		lElementos=ALEN(pTelefonos)
		DIMENSION THIS.atelefonos(lElementos)
		FOR indice=1 TO lElementos
			THIS.atelefonos[indice]=pTelefonos[indice]
		ENDFOR
		
		lElementos=ALEN(pDirecciones)
		DIMENSION THIS.zDirecciones(lElementos)
		FOR indice=1 TO lElementos
			THIS.zDirecciones[indice]=pDirecciones[indice]
		ENDFOR		
		
	ENDPROC

ENDDEFINE

DEFINE CLASS Telefono AS CUSTOM
	
	nombre=""
	numero=""

	PROCEDURE INIT(pNombre, pNumero)
		THIS.nombre=pNombre
		THIS.numero=pNumero
	ENDPROC

ENDDEFINE

DEFINE CLASS Direccion AS CUSTOM
	
	calle=""
	numero=""

	PROCEDURE INIT(pCalle, pNumero)
		THIS.calle=pCalle
		THIS.numero=pNumero
	ENDPROC

ENDDEFINE
