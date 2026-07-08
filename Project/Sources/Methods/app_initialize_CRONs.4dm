//%attributes = {"preemptive":"capable"}

// ## TO BE EXECUTED ON SERVER !

// ***** isActive(s)
// *
var $vC_aj_isAlive : Collection
$vC_aj_isAlive:=New collection:C1472
var $vJ_isAlive : Object
$vJ_isAlive:=New object:C1471
$vJ_isAlive.t_process:="p_CRON_main"
$vJ_isAlive.l_pid:=0
$vJ_isAlive.l_alerts:=0
$vJ_isAlive.is_running:=False:C215
$vC_aj_isAlive.push($vJ_isAlive)
// *
// *****

// ***** CRON(s)  
// *
// l_days       : time for launch.
//   ?00:00:01? : every 5 minutes
//   ?00:00:02? : every hour
//   ?00:00:03? : every 2 hours

// h_time : week day bits, Sunday... saturday or...
// h_time : <0 => unique day in month
//             0 => all days
//             d => days in week: bits [6-0] : saturday, friday... sunday
//             m => one day in a month if m<0


// ***** CRON(s)
// *
var $vC_aj_crons : Collection
$vC_aj_crons:=New collection:C1472

var $vJ_cron : Object
$vJ_cron:=New object:C1471
$vC_aj_crons.push($vJ_cron)
$vJ_cron.t_name:="CRON_Check"
$vJ_cron.fu_method:=Formula:C1597(K_cron_check)
$vJ_cron.l_days:=0x003E  // week days %011 1110
$vJ_cron.h_time:=?05:00:00?
$vJ_cron.isActive:=True:C214

$vJ_cron:=New object:C1471
$vC_aj_crons.push($vJ_cron)
$vJ_cron.t_name:="CRON_Check1"
$vJ_cron.fu_method:=Formula:C1597(K_cron_check1)
$vJ_cron.l_days:=0  // All days
$vJ_cron.h_time:=?15:55:00?
$vJ_cron.isActive:=True:C214

$vJ_cron:=New object:C1471
$vC_aj_crons.push($vJ_cron)
$vJ_cron.t_name:="CRON_Check2"
$vJ_cron.fu_method:=Formula:C1597(K_cron_check2)
$vJ_cron.l_days:=0  // All days
$vJ_cron.h_time:=?00:00:01?
$vJ_cron.isActive:=True:C214

// *
// *****


// ***** To put in storage
// *
var $vJ_crons : Object
$vJ_crons:=zen__storage_CRONs
Use ($vJ_crons)
	$vJ_crons.aj_isAlive:=$vC_aj_isAlive.copy(ck shared:K85:29; $vJ_crons)
	$vJ_crons.aj_crons:=$vC_aj_crons.copy(ck shared:K85:29; $vJ_crons)
End use 
// *
// *****


