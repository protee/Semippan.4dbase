//%attributes = {}

#DECLARE($vJ_dcox : Object; $is_btn : Boolean; $vC_al_colors_in : Collection)->$vC_al_colors : Collection
var $is_visible : Boolean
var $vC_at_bind : Collection
var $vL_colors_main; $idx; $vL_colors_out : Integer
var $vJ_bind : Object
var $vT_bind : Text

$vL_colors_main:=$vJ_dcox.l_main

// DCOX -> separated, or H | V, for LB or output
$vC_al_colors:=New collection:C1472()
$vC_at_bind:=sem_get_at_dcox()
$idx:=0
For each ($vT_bind; $vC_at_bind)
	$is_visible:=$idx=0 || $is_btn
	If ($is_visible)
		$vL_colors_out:=$vC_al_colors_in#Null:C1517 ? $vC_al_colors_in[$idx] : k_MDcolorsBW
		$vJ_bind:=$vJ_dcox["j_"+$vT_bind]
		$vL_colors_out:=woc_dcoxWidget_get_colors($vL_colors_main; $vJ_bind; $vL_colors_out)
		$vC_al_colors.push($vL_colors_out)
	Else 
		break
	End if 
	$idx+=1
End for each 

