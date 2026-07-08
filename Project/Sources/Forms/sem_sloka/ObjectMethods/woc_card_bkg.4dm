
var $vJ_widget : Object
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.set_widget_name()
		
		//$vJ_widget.resize()
		
End case 

