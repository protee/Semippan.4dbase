
var $vL_event_code : Integer
var $vJ_widget : Object
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.t_tip:="Export SETS & MEDIA"
		$vJ_widget.l_type:=2  // Linear
		$vJ_widget.r_text:=0.55
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_event_code=k_OnDataChange)
		//Form.fc._do_play()
		Form:C1466._is_play:=True:C214
		SET TIMER:C645(1)
		
End case 
