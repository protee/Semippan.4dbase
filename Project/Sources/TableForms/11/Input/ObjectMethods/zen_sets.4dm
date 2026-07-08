
var $vJ_widget : Object
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.t_tip:="SETS records"
		$vJ_widget.t_table:="SETS"
		$vJ_widget.t_label:="fileStart"  // For sort
		$vJ_widget.t_colors:=""
		$vJ_widget.is_multiple:=False:C215
		$vJ_widget.l_click:=1
		$vJ_widget.is_idle:=False:C215
		//$vJ_widget.l_click:=2  // toggle
		//$vJ_widget.l_count:=50
		$vJ_widget.resize()
		//$vJ_widget.redraw()
		
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466.fc._lb_sets_event($vJ_widget; $vL_event_code)
		
End case 


