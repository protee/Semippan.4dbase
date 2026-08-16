
var $vL_event_code : Integer
var $vJ_widget : Object
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		wox_vJ_overload(sem__storage_stuff.j_colors_square; $vJ_widget)
		$vJ_widget.bind_to_c4E("colors_in"; woc_sp_colors_random())
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
	: ($vL_event_code=k_OnDataChange)
		Form:C1466.fc._dcox_redraw()
		
		
End case 

