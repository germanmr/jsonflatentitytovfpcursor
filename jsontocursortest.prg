CLOSE ALL
CLEAR ALL
CLEAR

SET DEFAULT TO D:\vfp\Proyectos\qdfoxjson1.8

SET PROCEDURE TO qdfoxJSON
JSONStart()

?"JSON Test #7"
?"Version " + JSON.Version
?
?"THIS TEST SHOWS HOW TO ENCODE & DECODE DATA CURSORS IN PRIVATE DATA SESSIONS"
?

?"Starting a new datasession..."
LOCAL oSession
oSession = CREATEOBJECT("Session")
SET DATASESSION TO (oSession.dataSessionId)
??SET("DATASESSION")


?"Creating data cursor..."
USE customers
SELECT * FROM customers INTO CURSOR Q1 NOFILTER
USE IN customers
??"Done!!"

SELECT Q1
?"","Records:",RECCOUNT()
GO TOP
?"","First record:",custId,custName,custStat
GO BOTTOM
?"","Last record:",custId,custName,custStat


?
?"Encoding data cursor..."
cJSON = JSON.encodeCursor("Q1", SET("DATASESSION"))

CREATE CURSOR cJeison(valor memo)
INSERT INTO cJeison(valor) VALUES(cJSON)

BROWSE
SET STEP ON

lJson="{jsonschema:'cursor',name:'cDatos',"+;
"rows:[{custid:'0001',custname:'Jacobs, Russell',custstat:'Active'},"+;
"{custid:'0002',custname:'Metzger, Philip W.',custstat:'Active    '},"+;
"{custid:'0003',custname:'Boddie, John             ',custstat:'Active'},"+;
"{custid:'0004',custname:'Sydow, Dan Parks         ',custstat:'Inactive  '},"+;
"{custid:'0006',custname:'Lloyd, John              ',custstat:'Inactive  '},"+;
"{custid:'0008',custname:'Thiel, James R.          ',custstat:'Inactive  '},"+;
{custid:'0010',custname:'Ingham, Kenneth          ',custstat:'Inactive  '},{custid:'0012',custname:'Wellin, Paul             ',custstat:'Inactive  '},{custid:'0013',custname:'Kamin, Sam               ',custstat:'Active    '},{custid:'0014',custname:'Gaylord, Richard         ',custstat:'Active    '}],schemax:['CUSTID','C',4,0,false,false,'','','','','','','','','','',0,0,'CUSTNAME','C',25,0,false,false,'','','','','','','','','','',0,0,'CUSTSTAT','C',10,0,false,false,'','','','','','','','','','',0,0]}


??"Done!!"
?"",LEFT(cJSON,80)+"..."



?
?"Closing data cursor..."
USE IN Q1
??"Done!!"

?
?"Recreating data cursor..."
JSON.parseCursor(cJSON,,SET("DATASESSION"))
??"Done!!"

SELECT Q1
?"","Records:",RECCOUNT()
GO TOP
?"","First record:",custId,custName,custStat
GO BOTTOM
?"","Last record:",custId,custName,custStat

USE IN Q1 
?
?"Test completed"
?
?"For more information, read initial comments at qdfoxJSON.PRG file"

RETURN

