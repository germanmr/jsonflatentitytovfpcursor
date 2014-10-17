CLOSE ALL
CLEAR ALL
CLEAR

SET DEFAULT TO D:\vfp\Proyectos\qdfoxjson1.8

SET PROCEDURE TO qdfoxJSON
JSONStart()
* Tengo que armar con el Json que recibo:

* Ejemplo:

*!*	{
*!*		jsonschema:'cursor',
*!*		name:'Q1',
*!*		rows:[
*!*			{custid:'0001',custname:'Jacobs, Russell          ',custstat:'Active    '},
*!*			{custid:'0002',custname:'Metzger, Philip W.       ',custstat:'Active    '},
*!*			{custid:'0003',custname:'Boddie, John             ',custstat:'Active    '},
*!*			{custid:'0004',custname:'Sydow, Dan Parks         ',custstat:'Inactive  '},
*!*			{custid:'0006',custname:'Lloyd, John              ',custstat:'Inactive  '},
*!*			{custid:'0008',custname:'Thiel, James R.          ',custstat:'Inactive  '},
*!*			{custid:'0010',custname:'Ingham, Kenneth          ',custstat:'Inactive  '},
*!*			{custid:'0012',custname:'Wellin, Paul             ',custstat:'Inactive  '},
*!*			{custid:'0013',custname:'Kamin, Sam               ',custstat:'Active    '},
*!*			{custid:'0014',custname:'Gaylord, Richard         ',custstat:'Active    '}
*!*		],
*!*		schemax:[
*!*			'CUSTID','C',4,0,false,false,'','','','','','','','','','',0,0,'CUSTNAME',
*!*			'C',25,0,false,false,'','','','','','','','','','',0,0,'CUSTSTAT','C',10,0,false,false,'','','','','','','','','','',0,0
*!*		]
*!*	}

* De una fila
lJsonRecibido='{codigoPais:1, nombrePais:"ARGENTINA",codigoProvincia:1,nombreProvincia:"SANTA FE"}'

lNombreCursor="cDatos"
lColeccionDatos='{"custid":"0001","custname":"Jacobs Russell","custstat":"Active"},'+;
					'{"custid":"0002","custname":"Metzger Philip W.","custstat":"Active    "},'+;
					'{"custid":"0003","custname":"Boddie John             ","custstat":"Active"},'+;
					'{"custid":"0004","custname":"Sydow Dan Parks         ","custstat":"Inactive  "},'+;
					'{"custid":"0006","custname":"Lloyd John              ","custstat":"Inactive  "},'+;
					'{"custid":"0008","custname":"Thiel James R.          ","custstat":"Inactive  "},'+;
					'{"custid":"0010","custname":"Ingham Kenneth          ","custstat":"Inactive  "},'+;
					'{"custid":"0012","custname":"Wellin Paul             ","custstat":"Inactive  "},'+;
					'{"custid":"0013","custname":"Kamin Sam               ","custstat":"Active    "},'+;
					'{"custid":"0014","custname":"Gaylord Richard         ","custstat":"Active    "}'

* Para cada columna del Cursor a crear
* array de definicion de columnas de datos
DECLARE aDefiniciones(3)

aDefiniciones(1)=CREATEOBJECT("DefinicionColumna","CUSTID","C",4,0)
aDefiniciones(2)=CREATEOBJECT("DefinicionColumna","CUSTNAME","C",25,0)
aDefiniciones(3)=CREATEOBJECT("DefinicionColumna","CUSTSTAT","C",10,0)

lLongitud=ALEN(aDefiniciones)
lDefinicionCadena=""
lIndice=1
FOR EACH lDefinicionColumna IN aDefiniciones
	lDefinicionCadena = lDefinicionCadena +;
				'"' + lDefinicionColumna.nombreCampo + '","' + lDefinicionColumna.tipoDatoVFP + '","' + ALLTRIM(STR(lDefinicionColumna.longitud)) +;
				'","' + ALLTRIM(STR(lDefinicionColumna.decimales)) + '" ' + ;
				' ,false,false,"","","","","","","","","","",0,0 ' + IIF(lIndice<>lLongitud,",","" )
	lIndice = lIndice + 1

ENDFOR


lJson='{"jsonschema":"cursor","name":"' + lNombreCursor + '",' + '"rows":[' + lColeccionDatos + ' ],' + '"schemax":[' + lDefinicionCadena + ']}'


CREATE CURSOR cJsonaCursear(json memo)
INSERT INTO cJsonaCursear(json) VALUES(lJson)

BROWSE

JSON.parseCursor(lJson,,SET("DATASESSION"))


lSentencia = "SELECT " + lNombreCursor
&lSentencia
BROWSE


DEFINE CLASS DefinicionColumna AS Custom

	nombreCampo=""
	tipoDatoVFP=""
	longitud=0
	decimales=0

	PROCEDURE INIT(pNombreCampo, pTipoDatoVFP, pLongitud, pDecimales)
		THIS.nombreCampo=pNombreCampo
		THIS.tipoDatoVFP=pTipoDatoVFP
		THIS.longitud=pLongitud
		THIS.decimales=pDecimales
	ENDPROC
	
ENDDEFINE
