
var $vL_event_code : Integer
var $vJ_widget : Object
var $vT_action : Text
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.j_form:=Form:C1466  // Do not trigger bounce
		
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		$vT_action:=$vJ_widget.t_action
		Form:C1466.fc.zen_record_events($vT_action)
		$vJ_widget.t_action:=""
		
End case 

