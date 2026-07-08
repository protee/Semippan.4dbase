//%attributes = {"lang":"en","preemptive":"incapable"}
// *****
// *
// Method: y_host_record_newRead
// By Olivier Grimbert — Protée sarl
// on 28/12/2023 18:50:13
//
// Description: 
//
// Date        Init  Description
// ===================================================================
// 28/12/2023   OG   Initial version.
// *
// *****

#DECLARE($vT_process_name : Text; $vJ_params : Object)->$vL_pid : Integer

$vL_pid:=New process:C317("zenh_record_newRead_P"; 0; $vT_process_name; $vJ_params)

