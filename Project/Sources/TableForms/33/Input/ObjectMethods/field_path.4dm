var $vL_event_code : Integer
var $c4E : 4D:C1709.Entity
$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Data Change:K2:15)
		$c4E:=Form:C1466.c4E
		$c4E.path:=wox_trim($c4E.path)
		Form:C1466.fc.activate_btns()
		
	Else 
		Form:C1466.fc.on_path_drop()
		
End case 

