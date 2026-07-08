
var $vJ_widget : Object
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.j_form:=Form:C1466
		
		//$vJ_widget:=$vJ_widget // Dont work
		//Self->:=Self->  // This one ok Bounced
		
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		var $vT_action : Text
		$vT_action:=$vJ_widget.t_action
		Form:C1466.fc.zen_record_events($vT_action)
		$vJ_widget.t_action:=""
		
End case 

