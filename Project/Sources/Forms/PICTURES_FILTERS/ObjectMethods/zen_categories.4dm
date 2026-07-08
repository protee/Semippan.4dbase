

var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		var $vJ_widget : Object
		$vJ_widget:=Self:C308->
		$vJ_widget.t_tip:="CATEGORIES records"
		$vJ_widget.t_table:="CATEGORIES"
		$vJ_widget.is_multiple:=True:C214
		$vJ_widget.is_idle:=True:C214
		$vJ_widget.l_click:=2  // toggle
		$vJ_widget.l_count:=0
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
	: ($vL_event_code=k_OnDataChange)
		Form:C1466._filters()
		
End case 


