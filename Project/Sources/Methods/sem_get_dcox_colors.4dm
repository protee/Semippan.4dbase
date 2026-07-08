//%attributes = {}

#DECLARE($vJ_dcox : Object; $vC_al_colors_in : Collection)->$vC_al_colors : Collection
var $vC_at_bind : Collection
var $vL_colors_main; $idx; $vL_colors_in : Integer
var $vJ_bind : Object
var $vT_bind : Text

$vL_colors_main:=$vJ_dcox.l_main
$vC_al_colors:=New collection:C1472()
$vC_at_bind:=sem_get_at_dcox()
$idx:=0
For each ($vL_colors_in; $vC_al_colors_in)
	$vT_bind:=$vC_at_bind[$idx]
	$vJ_bind:=$vJ_dcox["j_"+$vT_bind]
	//$vC_al_colors.push(woc_dcoxWidget_get_colors($vL_colors_main; $vJ_bind; $vC_al_colors_in[$idx]))
	$vC_al_colors.push(woc_dcoxWidget_get_colors($vL_colors_main; $vJ_bind; $vL_colors_in))
	$idx+=1
End for each 

