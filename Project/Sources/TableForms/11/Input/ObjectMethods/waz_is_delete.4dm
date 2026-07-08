
var $vJ_widget : Object
var $vL_event_code : Integer

$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.v_value:=False:C215
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
End case 
