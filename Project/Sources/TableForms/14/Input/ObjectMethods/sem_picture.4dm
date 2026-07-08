

var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		var $vJ_widget : Object
		$vJ_widget:=Self:C308->
		$vJ_widget.is_editing:=Form:C1466.is_editing
		
		//$vJ_picture:=Form.c4E.j_picture
		//$vJ_widget.j_value:=$vJ_picture
		//If (Form.is_new)
		//Form.c4E.j_picture:=$vJ_widget.j_value
		//Else 
		//$vJ_widget.j_value:=Form.c4E.j_picture
		//End if 
		$vJ_widget.bind_to_c4E_vJ("j_picture")
		
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
		//: ($vL_event_code=k_OnDataChange)
		//Form.fc.isModeIcn()
		
End case 

