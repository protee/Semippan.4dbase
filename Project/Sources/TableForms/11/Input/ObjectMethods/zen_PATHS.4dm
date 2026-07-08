
var $vJ_widget : Object
var $vL_event : Integer
$vL_event:=Form event code:C388
Case of 
	: ($vL_event=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.sublist_set("PATHS"; "packs"; "UIDpack"; "PATHS_PRODUCTS.label")
		$vJ_widget.update()
		
		
	: ($vL_event=-On Selection Change:K2:29)
		$vJ_widget:=Self:C308->
		Form:C1466.fc._lb_PATHS_event($vJ_widget; $vL_event)
		
End case 

