//%attributes = {"preemptive":"capable"}

// ## TO BE EXECUTED ON SERVER !

// ***** isActive(s)
// *
var $vC_aj_isAlive; $vC_aj_crons : Collection
var $vJ_isAlive; $vJ_cron; $vJ_crons : Object

$vC_aj_isAlive:=New shared collection:C1527
$vC_aj_crons:=New shared collection:C1527

$vJ_crons:=zen__storage_CRONs()
Use ($vJ_crons)
	$vJ_crons.aj_isAlive:=$vC_aj_isAlive
	$vJ_crons.aj_crons:=$vC_aj_crons
End use 


// ***** isAlive(s)
// *
$vJ_isAlive:=New shared object:C1526
$vC_aj_isAlive.push($vJ_isAlive)
Use ($vJ_isAlive)
	$vJ_isAlive.t_process:="p_CRON_main"
	$vJ_isAlive.l_pid:=0
	$vJ_isAlive.l_alerts:=0
	$vJ_isAlive.is_running:=False:C215
End use 
// *
// *****

// ***** CRON(s)
// *
// l_days       : time for launch.
//   ?00:00:01? : every 5 minutes
//   ?00:00:06? : every hour
//   ?00:00:07? : every 2 hours

// h_time : week day bits, Sunday... saturday or...
// h_time : <0 => unique day in month
//             0 => all days
//             d => days in week: bits [6-0] : saturday, friday... sunday
//             m => one day in a month if m<0


// ***** CRON(s)
// *

$vJ_cron:=New shared object:C1526
$vC_aj_crons.push($vJ_cron)
Use ($vJ_cron)
	$vJ_cron.t_name:="CRON_Check"
	$vJ_cron.fu_method:=Formula:C1597(K_cron_check)
	$vJ_cron.l_days:=0x003E  // week days %011 1110
	$vJ_cron.h_time:=?00:00:07?  // 2h
	$vJ_cron.isActive:=True:C214
End use 

$vJ_cron:=New shared object:C1526
$vC_aj_crons.push($vJ_cron)
Use ($vJ_cron)
	$vJ_cron.t_name:="CRON_Check1"
	$vJ_cron.fu_method:=Formula:C1597(K_cron_check1)
	$vJ_cron.l_days:=0  // All days
	$vJ_cron.h_time:=?00:00:03?  // 15 mn
	$vJ_cron.isActive:=True:C214
End use 

$vJ_cron:=New shared object:C1526
$vC_aj_crons.push($vJ_cron)
Use ($vJ_cron)
	$vJ_cron.t_name:="CRON_Check2"
	$vJ_cron.fu_method:=Formula:C1597(K_cron_check2)
	$vJ_cron.l_days:=0  // All days
	$vJ_cron.h_time:=?00:00:01?
	$vJ_cron.isActive:=True:C214
End use 
// *
// *****


