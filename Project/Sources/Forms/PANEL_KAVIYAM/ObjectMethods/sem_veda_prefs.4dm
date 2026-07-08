
var $vL_event_code : Integer
var $vJ_widget : Object
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.set_widget_name()
		//Form.c4E.j_veda_prefs:=Null
		//$vJ_widget.bind_to_c4E_vJ("j_veda_prefs")
		//$vJ_widget.resize()
		//$vJ_widget.redraw()
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466.fc._vedaPrefs_chge($vJ_widget)
		
End case 

