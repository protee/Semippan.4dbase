
var $vL_event_code; $vL_colors : Integer
var $vJ_widget : Object
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.l_border:=Border Dotted:K42:29
		$vJ_widget.is_sf:=True:C214
		$vL_colors:=woc_sp_colors_from_sf(k_MDcolorTransparent; k_MDcolorTransparent)
		$vJ_widget.bind_to_c4E("colorsSVG"; $vL_colors)
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466.fc._media_chgt($vJ_widget)
		
End case 

