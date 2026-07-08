//%attributes = {"lang":"en","preemptive":"capable"}

#DECLARE($vJ_cron : Object; $is_test : Boolean; $vD_date_start : Date; $vD_date_end : Date)

var $vL_count; $vL_progress : Integer
var $vJ_infos : Object
var $vT_infos : Text
$vJ_infos:=$vJ_cron.j_infos
If ($vJ_infos=Null:C1517)
	$vJ_infos:=New shared object:C1526
	Use ($vJ_cron)
		$vJ_cron.j_infos:=$vJ_infos
	End use 
End if 
$vL_progress:=0
$vL_count:=200
$vT_infos:=""
Use ($vJ_infos)
	$vJ_infos.isAbort:=False:C215
	$vJ_infos.h_start:=Current time:C178
	$vJ_infos.h_duration:=?00:00:00?
	$vJ_infos.t_infos:=$vT_infos
End use 

Repeat 
	$vL_progress+=1
	If (Not:C34($is_test))
		$vT_infos+=($vT_infos="") ? "" : " ; "
		$vT_infos+=String:C10($vL_progress)
	End if 
	Use ($vJ_infos)
		$vJ_infos.l_progress:=$vL_progress
		$vJ_infos.l_count:=$vL_count
		$vJ_infos.h_duration:=Current time:C178-$vJ_infos.h_start+?00:00:00?
		$vJ_infos.t_infos:=$vT_infos
	End use 
	DELAY PROCESS:C323(Current process:C322; 10)
	var $is_abort : Boolean
	$is_abort:=$vJ_infos.isAbort
Until ($is_abort || ($vL_progress>=$vL_count))

Use ($vJ_infos)
	$vJ_infos.l_progress:=$vJ_infos.l_count
End use 
DELAY PROCESS:C323(Current process:C322; 60)
var $vT_name : Text
$vT_name:=$vJ_cron.t_name
KILL WORKER:C1390($vT_name)  // Direct Kill!

