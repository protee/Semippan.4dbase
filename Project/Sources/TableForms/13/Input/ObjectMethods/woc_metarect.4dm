
var $vL_event_code : Integer
var $vJ_widget : Object

$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.is_editing:=Form:C1466.is_editing
		$vJ_widget.l_colors:=wox_field_colors(Form:C1466.is_new; Form:C1466.is_editing)
		$vJ_widget.l_clear:=-1  // Mode bypass
		$vJ_widget.j_value:=Form:C1466.c4E.j_metarect
		If (Form:C1466.is_new)
			$vJ_widget.clear()
		End if 
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466.fc._media_chgt($vJ_widget)
		
End case 

