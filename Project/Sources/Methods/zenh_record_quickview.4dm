//%attributes = {"preemptive":"incapable"}

#DECLARE($vT_process_name : Text; $vJ_params : Object)

var $vT_form : Text
var $vT_table : Text
$vT_table:=$vJ_params.t_table
$vT_form:=$vJ_params.t_form

var $vP_table : Pointer
var $vL_table : Integer
$vL_table:=$vJ_params.l_table
$vP_table:=Table:C252($vL_table)

If (x_check_form_exists($vT_form; $vP_table))  // Calculate the form to open
	CALL WORKER:C1389($vT_process_name; Formula:C1597(zenh_records_quickview_worker); $vJ_params)
Else 
	BEEP:C151
End if 

