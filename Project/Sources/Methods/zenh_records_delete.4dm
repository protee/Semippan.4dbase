//%attributes = {"lang":"en","preemptive":"incapable"}

// ----------------------------------------------------
// User name (OS): Carlos Pisterman
// Date and time: 22/11/19, 12:49:32
// ----------------------------------------------------
// Method: sys_DeleteRecords
// Description
//
//
// Parameters
// ----------------------------------------------------

#DECLARE($vL_table : Integer; $vL_pid : Integer; $c4ES_selection : 4D:C1709.EntitySelection; $c4ES_selected : 4D:C1709.EntitySelection)->$c4ES_selection_out : 4D:C1709.EntitySelection

var $vT_table : Text
$vT_table:=Table name:C256($vL_table)

var $cs_ZENH_DELETE : cs:C1710.ZENH_DELETE
$cs_ZENH_DELETE:=cs:C1710.ZENH_DELETE.new()
var $isOk : Boolean
$isOk:=$cs_ZENH_DELETE.records_delete($vT_table; $c4ES_selected)
If ($isOk)
	$c4ES_selection_out:=$c4ES_selection.copy().minus($c4ES_selected)
	POST OUTSIDE CALL:C329($vL_pid)  //Réactivation du process d'appel
	RESUME PROCESS:C320($vL_pid)
End if 

