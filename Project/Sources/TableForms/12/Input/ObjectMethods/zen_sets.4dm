
var $vJ_widget : Object
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.sublist_set("SETS"; "banks"; "UIDbank"; "fileStart")
		$vJ_widget.is_first:=True:C214  // Selection of the fist line
		$vJ_widget.resize()
		//$vJ_widget.redraw()
		
		
	: ($vL_event_code=-On Selection Change:K2:29)
		$vJ_widget:=Self:C308->
		Form:C1466.fc._lb_sets_event($vJ_widget; $vL_event_code)
		
End case 