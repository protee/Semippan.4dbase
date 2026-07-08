
var $vJ_widget : Object
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=-On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466.fc._veda_chgt($vJ_widget)
		
	: ($vL_event_code=k_OnDoubleClicked)
		//$vJ_widget:=Self->
		Form:C1466.fc._expand()
		
End case 

