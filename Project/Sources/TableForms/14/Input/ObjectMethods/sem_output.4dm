

var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		var $vJ_widget : Object
		$vJ_widget:=Self:C308->
		$vJ_widget.is_editing:=Form:C1466.is_editing
		If (Form:C1466.is_new) && Not:C34(Form:C1466.is_dup)
			wox_vJ_overload($vJ_widget.j_value; Form:C1466.c4E)
		End if 
		$vJ_widget.j_value:=Form:C1466.c4E
		
		//$vJ_widget.bind_to_c4E_vJ("j_metarect"; Form.c4E)
		
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
	: ($vL_event_code=k_OnDataChange)
		Form:C1466.fc._template_chgt()
		
End case 


