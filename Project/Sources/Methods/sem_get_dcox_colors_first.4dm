//%attributes = {"lang":"en"}

#DECLARE($vJ_dcox : Object; $is_btn : Boolean; $vL_colors_in : Integer)->$vC_al_colors : Collection
var $vL_count : Integer

$vL_colors_in:=$vL_colors_in#0 ? $vL_colors_in : k_MDcolorsBW

$vL_count:=$is_btn ? 4 : 1
$vC_al_colors:=New collection:C1472()
$vC_al_colors:=$vC_al_colors.resize($vL_count; $vL_colors_in)
If ($vJ_dcox#Null:C1517)
	$vC_al_colors:=sem_get_dcox_colors($vJ_dcox; $vC_al_colors)
End if 
