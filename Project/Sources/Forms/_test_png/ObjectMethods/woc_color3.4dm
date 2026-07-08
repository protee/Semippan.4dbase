
var $vL_event_code; $vL_color : Integer
var $vJ_widget : Object
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.l_border:=Border Dotted:K42:29
		$vJ_widget.is_sf:=False:C215
		$vL_color:=woc_sp_color_from_row(3; 10)
		Form:C1466.l_color_target:=$vL_color
		$vJ_widget.bind_to("l_color_target")
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		//: ($vL_event_code=k_OnDataChange)
		//$vJ_widget:=Self->
		//Form.fc._color_chgt($vJ_widget)
		
End case 

