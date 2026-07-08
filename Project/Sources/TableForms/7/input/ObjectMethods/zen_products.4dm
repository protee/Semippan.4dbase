
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		var $vJ_widget : Object
		$vJ_widget:=Self:C308->
		$vJ_widget.c4E_set("PRODUCTS"; "UIDproduct")
		//$vJ_widget.t_table:="PRODUCTS"
		//$vJ_widget.bind_to_c4E("UIDproduct")
		//$vJ_widget.t_tip:="PRODUCTS record"
		
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
		//: ($vL_event_code=k_OnDataChange)
		//Form.fc.isModeIcn()
		
End case 


