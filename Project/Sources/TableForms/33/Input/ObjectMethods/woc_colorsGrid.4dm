
var $vJ_widget; $vJ_value : Object

var $vL_formEvent : Integer
$vL_formEvent:=Form event code:C388

Case of 
	: ($vL_formEvent=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.is_sf:=True:C214
		//$vJ_widget.is_square:=True
		$vJ_widget.is_square:=False:C215
		$vJ_widget.is_auto:=False:C215
		$vJ_widget.l_widgets_wh:=30
		$vJ_widget.l_count_w:=8
		$vJ_widget.l_count_h:=4
		$vJ_value:=$vJ_widget.j_value
		If ($vJ_value=Null:C1517)
			$vJ_widget.init_j_value()
		End if 
		$vJ_widget.bind_to_c4E_vJ("j_colorsGrid")  // After resize to get a proper intialized j_value
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
		
End case 

