

lNombreCampo = "A"
FOR i=1 TO 254

	lNombreCampo = lNombreCampo + "A"	
	lSentencia = "CREATE CURSOR cDatos(" + lNombreCampo + " C(1))"
	&lSentencia
	?i
ENDFOR


CREATE CURSOR cDatos(campo1 C(1),campo1 c(1))
