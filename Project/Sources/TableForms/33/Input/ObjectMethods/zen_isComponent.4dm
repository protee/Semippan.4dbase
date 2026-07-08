
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		var $vJ_widget : Object
		$vJ_widget:=Self:C308->
		$vJ_widget.t_tip:="isComponent"
		$vJ_widget.bind_to_c4E("isComponent"; True:C214)
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
		//: ($vL_event_code=k_OnDataChange)
		//Form.fc.isModeIcn()
		
End case 
