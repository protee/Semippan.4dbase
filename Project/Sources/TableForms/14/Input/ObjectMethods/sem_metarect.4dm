

var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		var $vJ_widget : Object
		$vJ_widget:=Self:C308->
		$vJ_widget.is_editing:=Form:C1466.is_editing
		$vJ_widget.l_colors:=wox_field_colors(Form:C1466.is_new; Form:C1466.is_editing)
		$vJ_widget.l_clear:=0  // Mode none
		//$vJ_metarect:=Form.c4E.j_metarect
		//$vJ_widget.j_value:=$vJ_metarect
		
		$vJ_widget.bind_to_c4E_vJ("j_metarect")
		
		//If (Form.is_new) // Already made in Entity if is_new
		//$vJ_widget.clear()
		//End if 
		
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
		//: ($vL_event_code=k_OnDataChange)
		//Form.fc.isModeIcn()
		
End case 

