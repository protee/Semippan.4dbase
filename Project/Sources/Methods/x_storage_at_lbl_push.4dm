//%attributes = {"preemptive":"capable"}
// Project Method: x__storage_at_lbl_push
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 24/07/2022   OG   Initial version.

#DECLARE($vJ_menu : Object)  // #{2}

// TODO manage add to existing if exists
var $vC_aT_lbl : Collection
var $i; $vL_count : Integer
$vL_count:=Count parameters:C259
$vC_aT_lbl:=New shared collection:C1527
For ($i; 2; $vL_count)
	$vC_aT_lbl.push(${$i})
End for 
$vJ_menu.at_lbl:=$vC_aT_lbl

