
var $vJ_widget; $vJ_field : Object
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.bind_to_c4E_vJ("j_alColors")
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		//: ($vL_event_code=k_OnDataChange)
		//$vJ_widget:=Self->
		//Form.fc._cmb_chgt($vJ_widget)
		
End case 

