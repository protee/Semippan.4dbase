//%attributes = {}

#DECLARE($cE_TEMPLATES : cs:C1710.TEMPLATESEntity; $is_btn : Boolean; $vC_al_colors_in : Collection)->$vC_al_colors : Collection
var $is_visible : Boolean
var $vC_at_bind : Collection
var $vL_TEMPLATES_main; $idx; $vL_colors_out : Integer
var $vJ_TEMPLATES_dcox; $vJ_bind : Object
var $vT_bind : Text

$vJ_TEMPLATES_dcox:=$cE_TEMPLATES#Null:C1517 ? $cE_TEMPLATES.j_dcox : Null:C1517
$vL_TEMPLATES_main:=$vJ_TEMPLATES_dcox.l_main

// DCOX -> separated, or H | V, for LB or output
$vC_al_colors:=New collection:C1472()
$vC_at_bind:=sem_get_at_dcox()
$idx:=0
For each ($vT_bind; $vC_at_bind)
	$is_visible:=$idx=0 || $is_btn
	If ($is_visible)
		$vL_colors_out:=$vC_al_colors_in#Null:C1517 ? $vC_al_colors_in[$idx] : k_MDcolorsBW
		If ($vJ_TEMPLATES_dcox#Null:C1517)
			$vJ_bind:=$vJ_TEMPLATES_dcox["j_"+$vT_bind]
			$vL_colors_out:=woc_dcoxWidget_get_colors($vL_TEMPLATES_main; $vJ_bind; $vL_colors_out)
		End if 
		$vC_al_colors.push($vL_colors_out)
	Else 
		break
	End if 
	$idx+=1
End for each 

