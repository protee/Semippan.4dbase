
var $vJ_widget : Object

var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.t_tip:="Start End"
		$vJ_widget.l_min:=-180
		$vJ_widget.l_max:=180
		$vJ_widget.l_unit:=60
		$vJ_widget.l_step:=1
		$vJ_widget.resize()
		
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466._startEnd_chgt($vJ_widget)
		
End case 

