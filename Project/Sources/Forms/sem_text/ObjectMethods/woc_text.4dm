
var $vL_event_code : Integer
var $vJ_widget : Object
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.is_sf:=False:C215
		$vJ_widget.l_shape:=-1  // Square
		$vJ_widget.resize()
		
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466._color_chgt($vJ_widget)
		
End case 

