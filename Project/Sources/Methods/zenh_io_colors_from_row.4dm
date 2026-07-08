//%attributes = {"preemptive":"incapable","lang":"en"}

#DECLARE($vJ_widget_in : Object; $vL_color_row : Integer; $is_icon_tr : Boolean)->$vJ_widget : Object
var $vL_colors; $vL_shape_colors; $vL_icon_color : Integer

$vJ_widget:=$vJ_widget_in || New object:C1471()

Use ($vJ_widget)
	$vL_colors:=woc_sp_colors_from_row($vL_color_row; 9; 1)
	If ($is_icon_tr)
		//$vL_icon_colors:=0xFFFF
		$vJ_widget.r_img_coef:=1
	End if 
	$vL_shape_colors:=woc_sp_colors_from_sf(woc_sp_color_from_row($vL_color_row; 5); k_MD_white)
	$vL_icon_color:=woc_sp_colors_to_s($vL_colors)
	$vL_icon_color:=woc_sp_color_from_row($vL_color_row; 8)
	
	$vJ_widget.l_colors:=$vL_colors
	$vJ_widget.l_shape_colors:=$vL_shape_colors
	$vJ_widget.l_icon_color:=$vL_icon_color
	
End use 

