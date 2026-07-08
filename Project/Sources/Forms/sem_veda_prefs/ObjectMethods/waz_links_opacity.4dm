
var $vJ_widget : Object

var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.t_tip:="Links opacity"
		$vJ_widget.l_min:=0
		$vJ_widget.l_max:=100
		$vJ_widget.l_unit:=25
		$vJ_widget.l_step:=1
		$vJ_widget.resize()
		
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466._widgets_chgt($vJ_widget)
		
End case 

