//%attributes = {"lang":"en"}

// ----------------------------------------------------
// User name (OS): Carlos Pisterman
// Date and time: 07/04/20, 10:07:53
// ----------------------------------------------------
// Method: sys_CheckIfFormExist
// Description
// 
//
// Parameters
// ----------------------------------------------------

#DECLARE($vT_form : Text; $vP_table : Pointer)->$isOk : Boolean

ARRAY TEXT:C222($aT_form_names; 0x0000)
FORM GET NAMES:C1167($vP_table->; $aT_form_names)  // get form names for one table
$isOk:=(Find in array:C230($aT_form_names; $vT_form)>0)

