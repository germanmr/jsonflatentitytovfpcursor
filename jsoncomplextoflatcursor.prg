

* TODO
* Le puedo pasar un array con los nombres de algunos campos de json y con el tipo de dato????

*SET DEFAULT TO d:\vfp\proyectos\jsonflatentitytovfpcursor

SET PROCEDURE TO z:\progs\colecciones\coleccionvfpmenorque8 ADDITIVE

CLEAR

LOCAL pcJSON
LOCAL oConversor

oConversor=CREATEOBJECT("Conversor")

*!*	********************************************* Caso 1 - Object con valores simples
*!*	#DEFINE CASO1 1
*!*	pcJSON='{"nombre":"German","apellido":"muñoz"}'

*!*	=oConversor.jsonACursor(pcjson )

*!*	CREATE CURSOR cObtenido(nombre C(100),apellido C(100))
*!*	INSERT INTO cObtenido(nombre,apellido) VALUES(PADR("German",100," "),PADR("muñoz",100," "))

*!*	IF !equalsCursor("cDatosDevueltos","cObtenido") THEN
*!*		MESSAGEBOX("Fallo el caso de prueba 1", 48,"Atencion")
*!*		RETURN .F.
*!*	ENDIF

*!*	? " Caso 1 con exito "

*!*	******************************************** Caso de prueba 2 - Un object que contiene un atributo object
*!*	#DEFINE CASO2 2
*!*	pcJSON='{"nombre":"German","apellido":"muñoz","telefono":{"descripcion":"Casa","numero":123}}'

*!*	=oConversor.jsonACursor(pcJSON)

*!*	CREATE CURSOR cObtenido(nombre C(100) , apellido Character(100), telefonodescripcion Character(100), telefononumero Numeric(10))
*!*	INSERT INTO cObtenido(nombre, apellido, telefonodescripcion, telefononumero);
*!*		VALUES(PADR("German",100," "), PADR("muñoz",100," "), PADR("Casa",100," "),123)

*!*	IF !equalsCursor("cDatosDevueltos","cObtenido") THEN
*!*		MESSAGEBOX("Fallo el caso de prueba 2", 48,"Atencion")
*!*		RETURN .F.
*!*	ENDIF
*!*	? " Caso 2 con exito "


*!*	********************************************* Caso de prueba 3 - Un object que contiene un object, que contiene un object
*!*	#DEFINE CASO3 3

*!*	pcJSON='{"nombre":"German","apellido":"muñoz","telefono":{"descripcion":"Casa","Detalle":{"caracteristica":"314","numero":"123456"}}}'
*!*	=oConversor.jsonACursor(pcJSON)


*!*	CREATE CURSOR cObtenido(nombre C(100) , apellido C(100), telefonodescripcion C(100), detallecaracteristica C(100),  detallenumero C(100))
*!*	INSERT INTO cObtenido(nombre, apellido, telefonodescripcion, detallecaracteristica, detallenumero );
*!*		VALUES(PADR("German",100," "), PADR("muñoz",100," "), PADR("Casa",100," "), PADR("314",100," "), PADR("123456",100," "))

*!*	IF !equalsCursor("cDatosDevueltos","cObtenido") THEN
*!*		MESSAGEBOX("Fallo el caso de prueba 3", 48,"Atencion")
*!*		RETURN .F.
*!*	ENDIF

*!*	? " Caso 3 con exito "

*!*	******************************************** Caso 4 - Object grande - con anidaciones de objects
*!*	#DEFINE CASO4 4

*!*	pcjson= '{"respuestaComunicacion":{"idTransaccion":316,"respuestaBase":{"tiposRespuestaValidacion":"OK","mensaje":""}},'+;
*!*			'"respuestaElegibilidadAfiliado":{"estadoGeneral":{"tiposRespuestaValidacion":"OK","mensaje":""},"detalleElegibilidadAfiliado":{'+;
*!*			'"afiliado":{"ID":"32165478","nombre":"PEREZ JUAN","convenio":{"ID":1,"nombre":"IAPOS"},"plan":{"ID":1,"nombre":"Dpto ROSARIO"}},'+;
*!*			'"modoIngresoAfiliado":"M","observaciones":""}}}'

*!*	=oConversor.jsonACursor(pcJSON)

*!*	CREATE CURSOR cObtenido(;
*!*	respuestacomunicacionidtransaccion N(10),respuestabasetiposrespuestavalidacion C(100), respuestabasemensaje C(100),;
*!*	estadogeneraltiposrespuestavalidacion C(100),estadogeneralmensaje C(100),afiliadoid C(100),afiliadonombre C(100),convenioid N(10),convenionombre C(100),planid N(10),;
*!*	plannombre C(100),modoingresoafiliado C(100),observaciones C(100));

*!*	INSERT INTO cObtenido(respuestacomunicacionidtransaccion,respuestabasetiposrespuestavalidacion, respuestabasemensaje,;
*!*	estadogeneraltiposrespuestavalidacion,estadogeneralmensaje,afiliadoid, afiliadonombre,convenioid,convenionombre,planid,;
*!*	plannombre, modoingresoafiliado, observaciones);
*!*	VALUES( 316, PADR("OK", 100, " "), PADR(" ",100," "),PADR("OK",100," "), PADR(" ",100," "), PADR("32165478",100," "),PADR("PEREZ JUAN",100," "),;
*!*	1,PADR("IAPOS",100," "),1, PADR("Dpto ROSARIO",100," "), PADR("M",100," ") ,PADR(" ",100," "))

*!*	IF !equalsCursor("cDatosDevueltos","cObtenido") THEN
*!*		MESSAGEBOX("Fallo el caso de prueba 4", 48,"Atencion")
*!*		RETURN .F.
*!*	ENDIF

*!*	? " Caso 4 con exito "


*!*	******************************************** Caso 5 - Un array de object con atributos simples
*!*	#DEFINE CASO5 5

*!*	pcjson= '{"profesiones":[{"ID":1},{"ID":2},{"ID":3}]}'
*!*	=oConversor.jsonACursor(pcJSON)

*!*	CREATE CURSOR cObtenido(profesionesid N(10))
*!*	INSERT INTO cObtenido(profesionesid) VALUES(1)
*!*	INSERT INTO cObtenido(profesionesid) VALUES(2)
*!*	INSERT INTO cObtenido(profesionesid) VALUES(3)

*!*	IF !equalsCursor("cDatosDevueltos","cObtenido") THEN
*!*		MESSAGEBOX("Fallo el caso de prueba 5", 48,"Atencion")
*!*		RETURN .F.
*!*	ENDIF

*!*	? " Caso 5 con exito "

*!*	******************************************** Caso 6 - Un array elementos objects
*!*	#DEFINE CASO6 6

*!*	pcjson= '{"profesiones":[{"ID":1,"nombre":"MEDICO"},{"ID":2,"nombre":"FONOAUDIOLOGO"},{"ID":3,"nombre":"KINESIOLOGO"}]}'
*!*	=oConversor.jsonACursor(pcJSON)

*!*	CREATE CURSOR cObtenido(profesionesid N(10), profesionesnombre C(100))
*!*	INSERT INTO cObtenido(profesionesid, profesionesnombre) VALUES(1,PADR("MEDICO",100," "))
*!*	INSERT INTO cObtenido(profesionesid, profesionesnombre) VALUES(2,PADR("FONOAUDIOLOGO",100," "))
*!*	INSERT INTO cObtenido(profesionesid, profesionesnombre) VALUES(3,PADR("KINESIOLOGO",100," "))

*!*	IF !equalsCursor("cDatosDevueltos","cObtenido") THEN
*!*		MESSAGEBOX("Fallo el caso de prueba 6", 48,"Atencion")
*!*		RETURN .F.
*!*	ENDIF

*!*	? " Caso 6 con exito "

*!*	******************************************** Caso 7 - Object con un Array de object
*!*	#DEFINE CASO7 7


*!*	pcjson='{"respuestaComunicacion":{"idTransaccion":15984,"respuestaBase":{"tiposRespuestaValidacion":"OK","mensaje":""}},'+;
*!*			'"profesiones":[{"ID":1,"nombre":"MEDICO"},{"ID":2,"nombre":"FONOAUDIOLOGO"},{"ID":3,"nombre":"KINESIOLOGO"}]}'

*!*	=oConversor.jsonACursor(pcJSON)

*!*	CREATE CURSOR cObtenido(;
*!*	respuestacomunicacionidtransaccion N(10),respuestabasetiposrespuestavalidacion C(100), respuestabasemensaje C(100),;
*!*	profesionesid N(10),profesionesnombre C(100) );

*!*	INSERT INTO cObtenido(respuestaComunicacionidTransaccion, respuestaBasetiposRespuestaValidacion, respuestaBasemensaje,profesionesid, profesionesnombre);
*!*		VALUES( 15984, PADR("OK",100," "), PADR(" ",100," "), 1, PADR("MEDICO",100," ") )
*!*	INSERT INTO cObtenido(respuestaComunicacionidTransaccion, respuestaBasetiposRespuestaValidacion, respuestaBasemensaje,profesionesid, profesionesnombre);
*!*		VALUES( 0, PADR(" ",100," "), PADR(" ",100," "), 2, PADR("FONOAUDIOLOGO",100," ") )
*!*	INSERT INTO cObtenido(respuestaComunicacionidTransaccion, respuestaBasetiposRespuestaValidacion, respuestaBasemensaje,profesionesid, profesionesnombre);
*!*		VALUES( 0, PADR(" ",100," "), PADR(" ",100," "), 3, PADR("KINESIOLOGO",100," ") )

*!*	IF !equalsCursor("cDatosDevueltos","cObtenido") THEN
*!*		MESSAGEBOX("Fallo el caso de prueba 7", 48,"Atencion")
*!*		RETURN .F.
*!*	ENDIF


*!*	? " Caso 7 con exito "

*!*	******************************************** Caso 8 - Array con entidades objects anidadas
*!*	#DEFINE CASO8 8

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

*!*	=oConversor.jsonACursor(lJSonRechazada)
*!*	BROWSE

*!*	? " Caso 8 con exito "

*!*	******************************************** Caso 9 - Object con array de objectos anidados, con casteo de atributos
*!*	#DEFINE CASO9 9

*!*	lJsonAutorizada='{"baseAmbulatorio": {"ID": "00000422289","afiliado": {"ID": "0000000321321321","nombre": "COSME FULANITO",'+;
*!*		'"convenio": {"ID": 2,"nombre": "AMR Salud"},"plan": {"ID": 52,"nombre": "2000/01 - Exento"}},"prestador": {"codigoProfesion": 4,'+;
*!*		'"matricula": 64758,"libro": "     ","folio": "     "},"efector": {"ID": {"codigoProfesion": 1,"matricula": 4275,"libro": "     ",'+;
*!*		'"folio": "     "},"nombre": "DR CHAPATIN"},"prescriptor": {"ID": {"codigoProfesion": 1,"matricula": 4275,"libro": "     ","folio": "     "'+;
*!*		'},"nombre": "DR CHAPATIN"},"fechaPrestacion": "2014/08/21"}'+;
*!*		',"prestacionesRealizadas": [{"prestacionSolicitadaBase": {"nomencladorBase": {"codigoNomenclador": "420101","ID": "420101",'+;
*!*		'"Nombre": "CONSULTA EN CONSULTORIO."},"cantidad": 1},"importePrestacion": {"moneda": {"ID": 1,"nombre": "Pesos"},"coseguro": 0,'+;
*!*		'"coseguroIva": 0,"coseguroPorcentaje": 0,"honorarios": 0,"derechos": 0,"iva": 0,"coseguroTexto": "Sin Cargo"}}],"fechaAutorizacion": "2014/08/21"}'


*!*	DIMENSION aTiposDatos[2]
*!*	aTiposDatos[1]=CREATEOBJECT("TipoDato","afiliadoid","C(15)")
*!*	aTiposDatos[2]=CREATEOBJECT("TipoDato","coseguroPorcentaje","N(12,2)")

*!*	=oConversor.jsonACursor(lJsonAutorizada, .F., @aTiposDatos)

*!*	BROWSE

*!*	? " Caso 9 con exito "

*!*	******************************************** Caso 10 - Entidad con varios niveles de anidamiento pero solo tomo un nodo, con casteo de atributos
*!*		* Indico el nodo de donde cortar, un solo nivel
*!*	#DEFINE CASO10 10

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

*!*	=oConversor.jsonACursor(pcjson, lNombreNodo, @aTiposDatos)

*!*	? " Caso 10 con exito "

*!*	BROWSE

*!*	******************************************** Caso 11, solo tomo valores de atributos de una entidad grande
*!*	#DEFINE CASO11 11

*!*	* Con dos niveles de anidamiento, obtengo cursor de un nodo!!
*!*	pcjson=	'{"respuestaGeneral":{"estado":"OK","mensaje":""},"detalle":{"respuestaDetalle":{"estado":"ERROR","mensaje":""},'+;
*!*			'"auditorias":[],"rechazadas":[],"autorizada":{"codigoAutorizacion":"123456"}}}'

*!*	DIMENSION aTiposDatos[1]
*!*	aTiposDatos[1]=CREATEOBJECT("TipoDato","afiliadoid","C(15)")

*!*	lNombreNodo = "respuestaGeneral"
*!*	=oConversor.jsonACursor(pcjson, lNombreNodo, @aTiposDatos )
*!*	BROWSE

*!*	lNombreNodo = "respuestaDetalle"
*!*	=oConversor.jsonACursor(pcjson, lNombreNodo, @aTiposDatos )
*!*	BROWSE

*!*	lNombreNodo = "autorizada"
*!*	=oConversor.jsonACursor(pcjson, lNombreNodo, @aTiposDatos )
*!*	BROWSE

*!*	? " Caso 11 con exito "

*!*	*********************************** Caso 12 - Solo tomo el valor de un atributo, que es un array de valores simples
*!*	#DEFINE CASO12 12

*!*	pcJson= '{'+;
*!*	'"efector":{"codigoProfesion":1,"matricula":987,"libro":"     ","folio":"     "},'+;
*!*	'"prescriptor":{"codigoProfesion":1,"matricula":987,"libro":"     ","folio":"     "},'+;
*!*	'"fechaPrestacion":"18/03/2014",'+;
*!*	'"codigoAfiliado":"3215487",'+;
*!*	'"codigoConvenio":1,'+;
*!*	'"codigoDelegacion":1,'+;
*!*	'"codigoMedioDePago":0,'+;
*!*	'"diagnostico":"",'+;
*!*	'"prestacionSolicitadas":'+;
*!*	'[{"codigoPrestacion":"999999","cantidad":1,"urgencia":false,"motivoSolicitud":"AGUDO","observaciones":"","bono":"321"}]}'

*!*	lNombreNodo = "prestacionSolicitadas"
*!*	DIMENSION aTiposDatos[1]
*!*	aTiposDatos[1]=CREATEOBJECT("TipoDato","codigoAfiliado","C(15)")

*!*	=oConversor.jsonACursor(pcjson, lNombreNodo, @aTiposDatos )
*!*	BROWSE

*!*	? " Caso 12 con exito "

*!*	******************************************** Caso 13, solo tomo el valor de un atributo, que un array de objects

*!*	#DEFINE CASO13 13

*!*	pcJson= '{"respuestaComunicacion": {"idTransaccion": 17525,"respuestaBase": {"tiposRespuestaValidacion": "OK","mensaje": ""}},"auditorias": [{'+;
*!*	'"baseAmbulatorio": {"ID": 1128832,"afiliado": {"ID": "000000018107469","nombre": "PIZZIO NESTOR DANIEL","convenio": {"ID": 2,"nombre": "AMR Salud"'+;
*!*	'},"plan": {"ID": 139,"nombre": "PLAN NOVO"}},"prestador": {"codigoProfesion": 4,"matricula": 64758,"libro": "     ","folio": "     "},'+;
*!*	'"efector": {"ID": {"codigoProfesion": 1,"matricula": 18765,"libro": "     ","folio": "     "},"nombre": "ABRAHAM MARCELO ELIAS"},"prescriptor": {'+;
*!*	'"ID": {"codigoProfesion": 1,"matricula": 13442,"libro": "     ","folio": "     "},"nombre": "MATELLICANI GUSTAVO ANDRES"},"fechaPrestacion": "2014/10/15"'+;
*!*	'},"prestacionRealizada": {"prestacionSolicitadaBase": {"nomencladorBase": {"codigoNomenclador": "170101","ID": "170101","Nombre": "ELECTROCARDIOGRAMA EN CONSULTORIO"'+;
*!*	'},"cantidad": 1},"importePrestacion": {"moneda": {"ID": 1,"nombre": "Pesos"},"coseguro": 0.00,"coseguroIva": 0.00,"coseguroPorcentaje": 0.00,"honorarios": 0.00,'+;
*!*	'"derechos": 0.00,"iva": 0.00,"coseguroTexto": "Sin Cargo "}},"estadoAuditoria": "RECHAZADO","comentarioAuditor": "AUTORIZADO E 29/09/2014\rESTEFANIA -ATENCION TELEFONICA",'+;
*!*	'"fechaAutorizacion": "2014/10/15"},{"baseAmbulatorio": {"ID": 1163230,"afiliado": {"ID": "000000043491224","nombre": "GUERRA FLORENCIA LILIANA","convenio": {'+;
*!*	'"ID": 2,"nombre": "AMR Salud"},"plan": {"ID": 51,"nombre": "1000/01"}},"prestador": {"codigoProfesion": 4,"matricula": 64758,"libro": "     ","folio": "     "},'+;
*!*	'"efector": {"ID": {"codigoProfesion": 1,"matricula": 17223,"libro": "     ","folio": "     "},"nombre": "ALBORNOZ SILVANA ANGELINA"},"prescriptor": {"ID": {"codigoProfesion": 1,'+;
*!*	'"matricula": 17223,"libro": "     ","folio": "     "},"nombre": "ALBORNOZ SILVANA ANGELINA"},"fechaPrestacion": "2014/11/13"},"prestacionRealizada": {"prestacionSolicitadaBase": {'+;
*!*	'"nomencladorBase": {"codigoNomenclador": "300119","ID": "300119","Nombre": "OFTALMOSCOPIA INDIRECTA BINOCULAR CON ESQUEMA DE FONDO DE OJO."},"cantidad": 1},"importePrestacion": {'+;
*!*	'"moneda": {"ID": 1,"nombre": "Pesos"},"coseguro": 0.00,"coseguroIva": 0.00,"coseguroPorcentaje": 0.00,"honorarios": 0.00,"derechos": 0.00,"iva": 0.00,"coseguroTexto": "Sin Cargo "'+;
*!*	'}},"estadoAuditoria": "APROBADO","comentarioAuditor": "\rESTEFANIA -ATENCION TELEFONICA","fechaAutorizacion": "2014/11/13"}]}'

*!*	lNombreNodo = "auditorias"
*!*	DIMENSION aTiposDatos[1]
*!*	aTiposDatos[1]=CREATEOBJECT("TipoDato","Baseambulatorioid","N(12)")

*!*	=oConversor.jsonACursor(pcjson, lNombreNodo, @aTiposDatos )
*!*	BROWSE

*!*	? " Caso 13 con exito "

*!*	*****************************************  Caso 14 -

*!*	#DEFINE CASO14

*!*	pcJson = '{"transaccionPrevia":{"respuestaBase":{"tiposRespuestaValidacion":"OK","mensaje":""},"estadoExtra":{"tiposRespuestaValidacion":"OK","mensaje":""}},"transaccionFinalizar":{'+;
*!*		'"transaccionAutoriza":{"respuestaBase":{"tiposRespuestaValidacion":"APROBADA","mensaje":""},"codigoAutorizacion":"A02-Y38-X30"},'+;
*!*		'"autorizada":{"baseAmbulatorio":{"ID":"A02-Y38-X30","afiliado":{"ID":"1234           ","nombre":"CARLA GOMEZ",'+;
*!*		'"convenio":{"ID":26,"nombre":"EN DESARROLLO - PRU"},"plan":{"ID":2,"nombre":"PLAN 2"}},"prestador":{"codigoProfesion":1,"matricula":4275,"libro":"     ","folio":"     "},'+;
*!*		'"efector":{"ID":{"codigoProfesion":1,"matricula":4275,"libro":"     ","folio":"     "},"nombre":"MUNIOZ ERNESTO EMILIO"},'+;
*!*		'"prescriptor":{"ID":{"codigoProfesion":1,"matricula":4275,"libro":"     ","folio":"     "},"nombre":"MUNIOZ ERNESTO EMILIO"},'+;
*!*		'"fechaPrestacion":"2015/01/26"},"prestacionesRealizadas":[{"prestacionSolicitadaBase":{"nomencladorBase":{"codigoNomenclador":"420101","ID":"420101","Nombre":"CONSULTA EN CONSULTORIO."},'+;
*!*		'"cantidad":1},"importePrestacion":{"moneda":{"ID":0,"nombre":"Ninguna"},"coseguro":0.00,"coseguroIva":0.00,"coseguroPorcentaje":0.00,"honorarios":0.00,"derechos":0.00,"iva":0.00,'+;
*!*		'"coseguroTexto":"Sin Cargo"}}],"fechaAutorizacion":1422241200000,"prestadorOriginal":{"codigoProfesion":1,"matricula":4275,"libro":"     ","folio":"     "}},'+;
*!*		'"auditorias":[],"respuestaBase":{"tiposRespuestaValidacion":"OK","mensaje":""}},"estadoGeneral":{"tiposRespuestaValidacion":"OK","mensaje":""}}'

*!*	LOCAL ARRAY aTiposDatosAutorizada[12]

*!*	lNombreAtributo = "autorizada"

*!*	aTiposDatosAutorizada[1]=CREATEOBJECT("TipoDato","nomencladorbaseid","C(6)")
*!*	aTiposDatosAutorizada[2]=CREATEOBJECT("TipoDato","cantidad","N(4)")
*!*	aTiposDatosAutorizada[3]=CREATEOBJECT("TipoDato","cosegurotexto","C(30)")
*!*	aTiposDatosAutorizada[4]=CREATEOBJECT("TipoDato","coseguro","N(12,2)")
*!*	aTiposDatosAutorizada[5]=CREATEOBJECT("TipoDato","prestadorcodigoprofesion","N(2)")
*!*	aTiposDatosAutorizada[6]=CREATEOBJECT("TipoDato","prestadormatricula","N(8)")
*!*	aTiposDatosAutorizada[7]=CREATEOBJECT("TipoDato","prestadorlibro","C(5)")
*!*	aTiposDatosAutorizada[8]=CREATEOBJECT("TipoDato","prestadorfolio","C(5)")
*!*	aTiposDatosAutorizada[9]=CREATEOBJECT("TipoDato","codigoAutorizacion","C(11)")
*!*	aTiposDatosAutorizada[10]=CREATEOBJECT("TipoDato","plannombre","C(60)")
*!*	aTiposDatosAutorizada[11]=CREATEOBJECT("TipoDato","fechaAutorizacion","N(15)")
*!*	aTiposDatosAutorizada[12]=CREATEOBJECT("TipoDato","baseambulatorioid","C(11)")		

*!*	=oConversor.jsonACursor( pcjson, lNombreAtributo, @aTiposDatosAutorizada )

*!*	BROWSE

*!*	? " Caso 14 con exito "

*******************************************************  Caso 15 - Arra y con dos entidades object, tomo el valor de una tributo
#DEFINE CASO15 15

pcJson='{"transaccionPrevia":{"respuestaBase":{"tiposRespuestaValidacion":"OK","mensaje":""},"estadoExtra":{"tiposRespuestaValidacion":"OK","mensaje":""}},'+;
'"transaccionFinalizar":{"transaccionAutoriza":{"respuestaBase":{"tiposRespuestaValidacion":"AUDMED","mensaje":""},"codigoAutorizacion":"A02-Y38-Y20"},'+;
'"autorizada":null,"auditorias":['+;
'{"baseAmbulatorio":{"ID":1173785,"afiliado":{"ID":"1234           ","nombre":"CARLA GOMEZ                             ",'+;
'"convenio":{"ID":26,"nombre":"EN DESARROLLO - PRU                "},"plan":{"ID":2,"nombre":"PLAN 2                             "}},'+;
'"prestador":{"codigoProfesion":1,"matricula":4275,"libro":"     ","folio":"     "},"efector":{"ID":{"codigoProfesion":1,"matricula":4275,"libro":"     ","folio":"     "},'+;
'"nombre":"MUNIOZ ERNESTO EMILIO"},"prescriptor":{"ID":{"codigoProfesion":1,"matricula":4275,"libro":"     ","folio":"     "},"nombre":"MUNIOZ ERNESTO EMILIO"},'+;
'"fechaPrestacion":"2015/01/27"},"prestacionRealizada":{"prestacionSolicitadaBase":{"nomencladorBase":{"codigoNomenclador":"150101","ID":"150101",'+;
'"Nombre":"BIOPSIA POR INCISION O POR PUNCION. (GANGLIO, LESION DE PIEL, TROZO DE OVARIO, CILINDRO DE HIGADO,  "},"cantidad":1},'+;
'"importePrestacion":{"moneda":{"ID":0,"nombre":"Ninguna"},"coseguro":0.00,"coseguroIva":0.00,"coseguroPorcentaje":0.00,"honorarios":0.00,"derechos":0.00,'+;
'"iva":0.00,"coseguroTexto":"Sin Cargo                     "}},"estadoAuditoria":"PENDIENTE","comentarioAuditor":"","fechaAutorizacion":1422371040734},'+;
'{"baseAmbulatorio":{"ID":1173786,"afiliado":{"ID":"1234           ","nombre":"CARLA GOMEZ                             ",'+;
'"convenio":{"ID":26,"nombre":"EN DESARROLLO - PRU                "},"plan":{"ID":2,"nombre":"PLAN 2                             "}},'+;
'"prestador":{"codigoProfesion":1,"matricula":4275,"libro":"     ","folio":"     "},"efector":{"ID":{"codigoProfesion":1,"matricula":4275,"libro":"     ","folio":"     "},'+;
'"nombre":"MUNIOZ ERNESTO EMILIO"},"prescriptor":{"ID":{"codigoProfesion":1,"matricula":4275,"libro":"     ","folio":"     "},"nombre":"MUNIOZ ERNESTO EMILIO"},'+;
'"fechaPrestacion":"2015/01/27"},"prestacionRealizada":{"prestacionSolicitadaBase":{"nomencladorBase":{"codigoNomenclador":"150601","ID":"150601",'+;
'"Nombre":"BIOPSIA POR INCISION O POR PUNCION. (GANGLIO, LESION DE PIEL, TROZO DE OVARIO, CILINDRO DE HIGADO,  "},"cantidad":1},'+;
'"importePrestacion":{"moneda":{"ID":0,"nombre":"Ninguna"},"coseguro":0.00,"coseguroIva":0.00,"coseguroPorcentaje":0.00,"honorarios":0.00,"derechos":0.00,'+;
'"iva":0.00,"coseguroTexto":"Sin Cargo                     "}},"estadoAuditoria":"PENDIENTE","comentarioAuditor":"","fechaAutorizacion":1422371040734}'+;
'],'+;
'"respuestaBase":{"tiposRespuestaValidacion":"OK","mensaje":""}},"estadoGeneral":{"tiposRespuestaValidacion":"OK","mensaje":""}}'

LOCAL ARRAY aTiposDatos[6]

lNombreAtributo = "auditorias"

aTiposDatos[1]=CREATEOBJECT("TipoDato","nomencladorbaseid","C(6)")
aTiposDatos[2]=CREATEOBJECT("TipoDato","cantidad","N(4)")
aTiposDatos[3]=CREATEOBJECT("TipoDato","cosegurotexto","C(30)")
aTiposDatos[4]=CREATEOBJECT("TipoDato","coseguro","N(12,2)")
aTiposDatos[5]=CREATEOBJECT("TipoDato","fechaAutorizacion","N(15)")
aTiposDatos[6]=CREATEOBJECT("TipoDato","baseambulatorioid","N(12)")

=oConversor.jsonACursor( pcjson, lNombreAtributo, @aTiposDatos )

BROWSE


************************************************************************************************************
************************************************************************************************************
************************************************************************************************************
************************************************************************************************************

DEFINE CLASS Conversor AS CUSTOM

	#DEFINE CRLF					CHR(13) + CHR(10)
	
	stringDelimitator = [']
	
	estoyenarray=.F.
	columnacreada=.F.
	esunobjeto=.F.
	nombrecursor=""
	nombreprefijo=""
	agregoregistro=.F.
	nodoBuscado = ""
	nodoEncontrado = .NULL.
	verbose=.F.
	DIMENSION acampos[1]
	
	PROCEDURE inicializaratributos()
			THIS.estoyenarray=.F.
			THIS.columnacreada=.F.
			THIS.esunobjeto=.F.
			THIS.nombrecursor="cDatos"
			THIS.nombreprefijo=""
			THIS.agregoregistro=.F.
			THIS.nodoBuscado = ""
			THIS.nodoEncontrado = .NULL.
			* Seteos basicos e importantes!!!!!
			SET SAFETY OFF
			SET EXACT ON
	ENDPROC
	
	* De una cadena json me da una coleccion de objetos para luego ser parseados por nodo
	* Este metodo es para mas un solo anidamiento de objetos
	* Devuelvo un cursor del nodo especificado
	* Tiene que estar en primer nivel y no contener arrays anidados
	PROCEDURE jsonACursor(pcjson, pNombreNodo, aTiposDatos, pVerbose)

		THIS.verbose = pVerbose
		
		THIS.inicializaratributos()
		
		* Limpio el json(precondiciones)
		* Saco los caracteres que no se aguanta el framework
		pcjson=STRTRAN(pcjson,"'","")
		
		IF VARTYPE(pNombreNodo)="L" THEN
			THIS.jsonToCursor( pcjson )
		ELSE
			
			THIS.nodoBuscado = pNombreNodo
			SET MESS TO "BUSCANDO VALOR DEL ATRIBUTO..."
			THIS.obtenerNodo(pcJSON)
			SET MESS TO
			
			IF !ISNULL(THIS.nodoEncontrado) THEN
				IF THIS.verbose THEN
					CREATE CURSOR cNodo(valor memo)
					INSERT INTO cNodo(valor)VALUES(THIS.nodoEncontrado)
					BROWSE
				ENDIF
				
				THIS.jsonToCursor("{" + THIS.nodoEncontrado + "}", @aTiposDatos)

			ELSE
				* No existe el nodo en las condiciones indicadas
				RETURN .NULL.
			ENDIF

		ENDIF	
		
	ENDPROC

	PROCEDURE obtenerNodo(pcJSON)
		
		LOCAL oObjects, i, oResult, lIsArray
		STORE .F. TO lIsArray

		IF LEFT(pcJSON,1) = "[" THEN
			lISArray = .T.
		ENDIF

		pcJSON = SUBSTR(pcJSON,2,LEN(pcJSON) - 2) 
		 
		LOCAL oPairs, j, cPair, cProp, cValue, uValue, oObj, cObj, nSep

		oObjects = THIS._Split(pcJSON)
		 
		FOR i = 1 TO oObjects.Count
			*
			cObj = oObjects.Item[i]
			
			LOCAL lSalgo
			lSalgo = THIS.verificarNodoBuscado(cObj)
			
			IF lSalgo THEN
				RETURN
			ENDIF
			
			IF EMPTY(cObj)
				LOOP
			ENDIF
		  
			IF lIsArray AND THIS.IsObject(cObj)
				THIS.obtenerNodo(cObj)
				LOOP
			ENDIF

			oPairs = THIS._Split(cObj)
			
			FOR j = 1 TO oPairs.Count
			
				cPair = ALLTRIM(oPairs.Item[j])
				
				LOCAL lSalgo
				lSalgo = THIS.verificarNodoBuscado(cPair)
				
				IF lSalgo THEN
					RETURN
				ENDIF
				
				IF lIsArray
					cValue = cPair
				ELSE
					* Si no es un array puede ser que haya encontrado el nodo
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
				
				IF LEFT(cValue,1) = [{] OR LEFT(cValue,1) = "[" THEN
					THIS.obtenerNodo(cValue)
				ENDIF

			ENDFOR

		ENDFOR
		
	ENDPROC

	PROCEDURE verificarNodoBuscado(cBloque )
		LOCAL lAtributoBuscado, lNombreNodo
		LOCAL oNodo
		oNodo = .NULL.

		lAtributoBuscado = '"' + LOWER(THIS.nodoBuscado) + '"'
		lNombrenodo = LEFT(LOWER(cBloque),LEN(LOWER(THIS.nodoBuscado)) + 2 )
		
		IF lAtributoBuscado = lNombreNodo THEN
			THIS.nodoEncontrado = cBloque
		ENDIF
		
		RETURN oNodo
	
	ENDPROC	
	
	PROCEDURE jsonToCursor(pcJSON, aTiposDatos)
		
		SET MESS TO "PREPARANDO AMBIENTE DE DATOS..."

		THIS.inicializaratributos()
		
		IF pcJSON = '[]' OR pcJSON = " " THEN
			RETURN ""
		ENDIF
		
		
		* Paso a una propiedad de la clase, el array indicado
		IF !VARTYPE(aTiposDatos) ="L" THEN
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
		
		********** Preparo la zona de datos
		******** .setUp()
		LOCAL lNombreBaseDatos
		lNombreBaseDatos= "pruebas"
		IF FILE(lNombreBaseDatos + ".dbc" ) THEN && Existe?
			IF !DBUSED(lNombreBaseDatos) THEN && La estan usando?
				OPEN DATABASE (lNombreBaseDatos)
			ENDIF
		ELSE
			CREATE DATABASE (lNombreBaseDatos)
		ENDIF
		
		* Me situo en la base de datos
		SET DATABASE TO (lNombreBaseDatos)

		IF FILE(THIS.nombreCursor + ".dbf") THEN && 
			IF USED(THIS.nombrecursor) THEN && Cierro el alias asi luego lo borro
				LOCAL lNombreCursor
				lNombreCursor=ALLTRIM(THIS.nombrecursor)
				SELECT &lNombreCursor.
				USE
			ENDIF
			DROP TABLE (THIS.nombrecursor)
		ENDIF
		
		LOCAL lSentencia
		lSentencia = "CREATE TABLE " + THIS.nombreCursor + " (campo1 C(1))"
		&lSentencia
		****************************************************************************************
		
		SET MESS TO "ARMANDO EL CURSOR..."
		* Aca pasamos de json a nuestro alias de datos
		THIS.Parse(pcJSON)

		****************************************************************************************
		SET MESS TO "LIMPIANDO AREA DE DATOS..."
		* .cleanUp()
		* Limpio la zona de datos, si no hay otros campos mato el alias!!
		LOCAL ARRAY aCampos[1]
		IF AFIELDS(aCampos,THIS.nombrecursor) > 1 THEN
			lSentencia = "ALTER TABLE " + THIS.nombrecursor  + " DROP COLUMN campo1"
			&lSentencia
		ENDIF	

		* Devuelvo esto asi cierro la base da datos!!
		SELECT * FROM cDatos INTO CURSOR cDatosDevueltos
		
		SET DATABASE TO (lNombreBaseDatos)
		CLOSE DATABASE

		SET MESSAGE TO
		****************************************************************************************

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
						uValue = "'" + uValue + "'"
						
						* Si pasa los 254 es memo!!!
						IF LEN(cValue)<252 THEN
							lTipoDato="C(100)"
						ELSE
							lTipoDato="MEMO"
						ENDIF
	               
					CASE LEFT(cValue,1) = [@]   && Date/DateTime
						* THIS.formatofecha???
						cValue = SUBSTR(cValue,2)
						IF LEN(cValue) = 8
							uValue = CTOD(TRANSFORM(cValue,"@R ^9999-99-99"))
						ELSE
							uValue = CTOT(TRANSFORM(cValue,"@R ^9999-99-99 99:99:99"))
						ENDIF
						lTipoDato="date"
	          
					CASE INLIST(cValue,"true","false")  && Boolean value
						IF cValue == "true" THEN
							uValue = " .T. "
						ELSE
							uValue = " .F. "
						ENDIF

						lTipoDato="logical"

					CASE UPPER(cValue) == "NULL" OR UPPER(cValue) == ".NULL." && Null value  &&  cesar
						*uValue = ".NULL."
						uValue = '.NULL.'
						lTipoDato="C(100) NULL"
	                
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
						*uValue = VAL(STRTRAN(cValue, ".", SET("POINT")))  && JuanPa, Abril 13 2012
						uValue = cValue
						* TODO - decode numero
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
						lSentencia="ALTER TABLE " + THIS.nombrecursor + " ADD COLUMN " + lNombreColumna + " " + lTipoDato
						&lSentencia
					ENDIF

				ELSE && Cuando no estoy en un array
					
					lSufijo =" ALL"
				
					lSentencia="ALTER TABLE " + THIS.nombrecursor + " ADD COLUMN " + lNombreColumna + " " + lTipoDato
					&lSentencia

					IF THIS.agregoregistro AND RECCOUNT(THIS.nombrecursor)=0 THEN
						APPEND BLANK
						THIS.agregoregistro=.F.
					ENDIF
					
				ENDIF
				
				LOCAL lValorReemplazo
				lValorReemplazo=uValue
				
				* Si la cadena es menor que 256 no hay problemas
				IF LEN(ALLTRIM(uValue))<256 THEN
					lSentencia="REPLACE " + lNombreColumna + " WITH " + lValorReemplazo
					&lSentencia				
				ELSE
					LOCAL lInicioCadena, lFinCadena,lTamanioSegmento, lSegmento, i, lIteraciones
					lTamanioSegmento=200
					lInicioCadena=1
					lFinCadena=lTamanioSegmento
					* Si la cadena es mayor a 256,
					* tenemos que iterar porque se rompe la macrosubstitucion con cadenas largas!!!
					* Limpiamos las comillas
					lValorReemplazo=LEFT(SUBSTR(lValorReemplazo,2),LEN(lValorReemplazo) - 2)	
					*Tomo la cantidad segmentos
					lIteraciones=CEILING(LEN(lValorReemplazo)/lTamanioSegmento)
					FOR i=1 TO lIteraciones
						* Tomamos los primeros 200 caracteres
						lSegmento="'" + SUBST(lValorReemplazo,lInicioCadena,lFinCadena) + "'"
						lSentencia="REPLACE " + lNombreColumna + " WITH " + lNombreColumna + " + " + lSegmento
						&lSentencia
						*La siguiente iteracion
						lInicioCadena=lTamanioSegmento * i
						lFinCadena=lInicioCadena + lTamanioSegmento
					ENDFOR

				ENDIF

			ENDFOR
	      
		ENDFOR
		
	ENDPROC

	PROCEDURE _Split(pcJSON)
		
	LOCAL nBlockCount,cObj,lOpenQuote,cChar

		nBlockCount = 0
		cObj = pcJSON
		lOpenQuote = .F.
		lInicioValorAtributo=.F.
		lTipoValor=""

		FOR j = 1 TO LEN(cObj)

		    cChar = SUBSTR(cObj, j, 1)

		    DO CASE

		        * Hasta aqui llego el valor del atributo String
		        CASE lTipoValor="STRING" AND cChar $ '"'
		            lTipoValor=""

		        * De esta manera sabemos que el tipo del atributo es un NUMBER
		        CASE lInicioValorAtributo AND INLIST(cChar,'-','+','1','2','3','4','5','6','7','8','9','0','e','E')
		            lTipoValor='NUMBER'
		            lInicioValorAtributo=.F.

		        * De esta manera sabemos que es el comienzo del atributo STRING
		        CASE lInicioValorAtributo AND cChar $ '"'
		            lTipoValor="STRING"
		            lInicioValorAtributo=.F.

		        CASE cChar $ "[{"
		            nBlockCount = nBlockCount + 1

		        CASE cChar $ "]}"
		            nBlockCount = nBLockCount - 1

		        CASE cChar $ THIS.stringDelimitator
		            IF lOpenQuote
		                nBlockCount = nBLockCount - 1
		            ELSE
		                nBlockCount = nBlockCount + 1 
		            ENDIF
		            lOpenQuote = !lOpenQuote

		        * Esto nos indica que es un inicio de valor de atributo
		        * y no estoy adentro de un atributo
		        CASE !lInicioValorAtributo AND cChar $ ":" AND lTipoValor<>"STRING"
		            lInicioValorAtributo=.T.

		        * Tomamos la coma como fin de bloque cuando no esta entre caracteres escapados y no estamos adentro del valor de un atributo STRING
		        CASE cChar = "," AND nBlockCount = 0 AND lTipoValor<>"STRING"
		            cObj = STUFF(cObj,j,1,CHR(254))
		            lTipoValor=""
			ENDCASE

		ENDFOR

		* Divido la cadena marcada con CHR(254), 
		* con la misma creo un array de bloques y devuelvo una coleccion de Cadenas
		LOCAL ARRAY aObjects[1]
		LOCAL nCount, i, oResult
		
		oResult = CREATEOBJECT("Collection")
		nCount = ALINES(aObjects, STRT(cObj,CHR(254),CRLF))
		FOR i = 1 TO nCount
			oResult.add(aObjects[i])
		ENDFOR

		RETURN oResult

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
		
		IF VARTYPE(THIS.aCampos) = "L" THEN
			RETURN ""
		ENDIF
		
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

	IF !USED(pCursorObtenido) THEN
		? "El alias: " + pCursorObtenido + " no esta en uso"
		RETURN .F.
	ENDIF
	
	* Estructura
	LOCAL ARRAY aCamposObtenido[1,1]
	LOCAL ARRAY aCamposEsperado[1,1]
	LOCAL campo, lCantidadCamposObtenido, lCantidadCamposEsperado
	
	lCantidadCamposObtenido = AFIELDS(aCamposObtenido,pCursorObtenido)
	lCantidadCamposEsperado = AFIELDS(aCamposEsperado,pCursorEsperado)
	
	IF lCantidadCamposEsperado <> lCantidadCamposObtenido THEN
		? "Los cursores no tiene la misma cantidad de campos, Esperado: " + ALLTRIM(STR(lCantidadCamposEsperado)) + ", obtenido: " + ALLTRIM(STR(lCantidadCamposObtenido))
		RETURN .F.
	ENDIF
	
	FOR i = 1 TO lCantidadCamposObtenido
		IF LOWER(aCamposObtenido[i,1])<> LOWER(aCamposEsperado[i,1]) THEN
			? "El campo numero: "+ALLTRIM(STR(i))+" esta mal, valor esperado: " +ALLTRIM(aCamposObtenido[i,1]) + " valor obtenido: " + aCamposEsperado[i,1]
			RETURN .F.
		ENDIF
	ENDFOR
	
	* Valores
	LOCAL lCantidadRegistrosObtenido
	SELECT &pCursorObtenido.
	COUNT TO lCantidadRegistrosObtenido
	GO TOP

	LOCAL lCantidadRegistrosEsperado
	SELECT &pCursorEsperado.
	COUNT TO lCantidadRegistrosEsperado
	GO TOP
	
	IF lCantidadRegistrosObtenido<>lCantidadRegistrosEsperado THEN
		? "Cantidad de registro distinta, esperada: " + ALLTRIM(STR(lCantidadRegistrosEsperado)) + " obtenido: "+ ALLTRIM(STR(lCantidadRegistrosObtenido))
		RETURN .F.
	ENDIF
	
	LOCAL lValorEsperado, lValorObtenido
	
	SELECT &pCursorEsperado.
	* Para cada fila
	SCAN
	
		* Para cada campo
		FOR i=1 TO lCantidadCamposEsperado
			
			lSentencia =  "lValorEsperado = " + pCursorObtenido +"."+ aCamposObtenido[i,1]
			&lSentencia
			lSentencia =  "lValorObtenido = " + pCursorEsperado +"."+ aCamposEsperado[i,1]
			&lSentencia
			
			IF lValorEsperado <> lValorObtenido THEN
				? "El valor del campo esta mal"
				? "Esperado:"
				?lValorEsperado
				? "Obtenido"
				? lValorObtenido
				RETURN .F.
			ENDIF
		ENDFOR

		* tengo que avanzar en ambos cursores
		SELECT &pCursorObtenido.
		IF !EOF() THEN
			SKIP 1
		ENDIF

		SELECT &pCursorEsperado.		
		
	ENDSCAN
	
	RETURN .T.

ENDPROC


* ADDPROPERTY
* Simula la funcion ADDPROPERTY existente en VFP9
*
PROCEDURE AddProperty(poObject, pcProperty, puValue)
	poObject.addProperty(pcProperty, puValue)
ENDPROC


