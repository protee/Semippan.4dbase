
var $vJ_widget : Object
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.sublist_set("BANKS"; "packs"; "UIDpack"; "label")
		$vJ_widget.update()
		
		
	: ($vL_event_code=-On Selection Change:K2:29) || ($vL_event_code=-On Clicked:K2:4)
		$vJ_widget:=Self:C308->
		Form:C1466.fc._lb_banks_event($vJ_widget; $vL_event_code)
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466.fc._lb_banks_event($vJ_widget; $vL_event_code)
		
End case 

