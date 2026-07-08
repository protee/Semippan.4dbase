
var $vJ_widget : Object
var $vL_event_code; $vL_event : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.sublist_set("MEDIA"; "banks"; "UIDbank"; "order"; True:C214)
		$vJ_widget.resize()
		
		
	: ($vL_event_code=-On Selection Change:K2:29)
		$vJ_widget:=Self:C308->
		Form:C1466.fc._lb_media_event($vJ_widget; $vL_event)
		
End case 

