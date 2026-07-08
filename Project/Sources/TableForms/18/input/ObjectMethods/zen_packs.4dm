
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		var $vJ_widget : Object
		var $c4E : 4D:C1709.Entity
		$vJ_widget:=Self:C308->
		$vJ_widget.c4E_set("KAVIYAM"; "UIDkaviyam")
		//$vJ_widget.t_table:="KAVIYAM"
		//$vJ_widget.bind_to_c4E("UIDkaviyam")
		//$vJ_widget.t_tip:="KAVIYAM record"
		
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		$c4E:=Form:C1466.c4E
		//Form.fc.isModeIcn()
		
End case 

