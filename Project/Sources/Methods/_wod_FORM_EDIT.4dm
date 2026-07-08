//%attributes = {}
// *****
// *
// Method: _wod_FORM_EDIT
// By Olivier Grimbert — Protée sarl
// on 29/03/2024 11:03:53
//
// Description: 
//
// Date        Init  Description
// ===================================================================
// 29/03/2024   OG   Initial version.
// *
// *****

#DECLARE($vL_noTable : Integer; $vT_form : Text; $vT_object : Text)
var $vP_table : Pointer

If ($vL_noTable=0)
	FORM EDIT:C1749($vT_form; $vT_object)
Else 
	$vP_table:=Table:C252($vL_noTable)
	FORM EDIT:C1749($vP_table->; $vT_form; $vT_object)
End if 

