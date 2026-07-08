
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		var $vJ_widget : Object
		$vJ_widget:=Self:C308->
		$vJ_widget.l_border:=Border Sunken:K42:31
		$vJ_widget.t_tip:="Links color"
		$vJ_widget.is_sf:=False:C215
		$vJ_widget.resize()
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466._widgets_chgt($vJ_widget)
		
		
End case 
