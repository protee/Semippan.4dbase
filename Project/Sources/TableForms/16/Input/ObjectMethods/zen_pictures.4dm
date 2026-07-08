
var $vJ_widget : Object
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.sublist_set("PICTURES"; "categories"; "UIDcategory"; "label")
		$vJ_widget.update()
		
		
		//: ($vL_event_code=On Data Change)
		//$vJ_widget:=Self->
		//var $vT_action : Text
		//$vT_action:=$vJ_widget.t_action
		//Form.fc.wib_record_events($vT_action)
		//$vJ_widget.t_action:=""
		
End case 

