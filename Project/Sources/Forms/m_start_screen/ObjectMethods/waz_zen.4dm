
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
var $vJ_widget; $vJ_prefs : Object
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_prefs:=zen__storage_prefs()
		$vJ_widget.fo_rsc:=$vJ_prefs.fo_rsc  // Host
		$vJ_widget.t_tip:=$vJ_prefs.t_name
		$vJ_widget.t_value:="pictures/btn_product"  // TODO
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_event_code=k_OnDataChange)
		Form:C1466.fc.btn_zen()
		
End case 
