
var $vL_event_code : Integer
var $vJ_widget : Object
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		wox_vJ_overload(app__storage_stuff.j_colors_text; $vJ_widget)
		$vJ_widget.bind_to_c4E("colors"; 0)
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
		//: ($vL_event_code=k_OnDataChange)
		//Form.fc.redraw()
		
		
End case 
