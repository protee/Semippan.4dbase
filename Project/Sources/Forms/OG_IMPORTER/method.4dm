
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		Form:C1466.fc:=cs:C1710.OG_IMPORTER.new()
	Else 
		Form:C1466.fc.form_events($vL_event_code)
End case 

