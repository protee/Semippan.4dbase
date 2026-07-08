//%attributes = {"lang":"en","preemptive":"incapable"}
// *****
// *
// Method: y_host_list_filter
// By Olivier Grimbert — Protée sarl
// on 28/12/2023 18:50:29
//
// Description:
//
// Date        Init  Description
// ===================================================================
// 28/12/2023   OG   Initial version.
// *
// *****

#DECLARE($vT_table : Text; $vT_view : Text; $c4ES_selection : 4D:C1709.EntitySelection)->$c4ES_MySelection : 4D:C1709.EntitySelection

If ($c4ES_selection=Null:C1517)
	var $c4ES_root : 4D:C1709.EntitySelection
	$c4ES_root:=zen__ds[$vT_table].all()
Else 
	$c4ES_root:=$c4ES_selection
End if 

$c4ES_MySelection:=$c4ES_root


//If ($is_transpose)  // OG-CP TO SEE 19/12/2023 18:24:28
//Case of 
//: ($vT_table="CLIENTS") || ($vT_table="MESSAGES") || ($vT_table="ACHATS") || ($vT_table="HISTORIQUE_CREDITS") || ($vT_table="MESSAGES_HORS_SESSION")
//If ($vT_filtre#"Tous")
//$c4ES_MySelection:=$c4ES_root.query("Marche=:1"; $vT_filtre)
//Else 
//$c4ES_MySelection:=$c4ES_root
//End if 

//Case of 
//: ($vT_view="Clients") && ($vT_table="CLIENTS")
////$c4ES_MySelection:=$c4ES_MySelection.query("isClient =:1"; True)
//$c4ES_MySelection:=$c4ES_root.query("prospect =:1"; False)

//: ($vT_view="Prospects") && ($vT_table="CLIENTS")
////$c4ES_MySelection:=$c4ES_MySelection.query("isClient =:1"; False)
//$c4ES_MySelection:=$c4ES_root.query("prospect =:1"; True)
//End case 


//: ($vT_table="SESSIONS")
//If ($vT_view="Consultations")
//If ($vT_view="transpo")
//If ($vT_filtre#"Tous")
//$c4ES_MySelection:=$c4ES_root.query("Marche=:1 AND EstFermee =:2"; $vT_filtre; True)
//Else 
//$c4ES_MySelection:=$c4ES_root.query("EstFermee =:1"; True)
//End if 
//Else 
//If ($vT_filtre#"Tous")
//$c4ES_MySelection:=$c4ES_root.query("Marche=:1 AND EstFermee =:2"; $vT_filtre; True)
//Else 
////$c4ES_MySelection:=zen___ds[$vT_table].query("EstFermee =:1"; True)
//$c4ES_MySelection:=$c4ES_root.query("EstFermee =:1"; True)
//End if 
//End if 

//Else 
//If ($vT_view="transpo")
//If ($vT_filtre#"Tous")
//$c4ES_MySelection:=$c4ES_root.query("Marche=:1"; $vT_filtre)
//Else 
//$c4ES_MySelection:=$c4ES_root
//End if 
//Else 
//If ($vT_filtre#"Tous")
//$c4ES_MySelection:=$c4ES_root.query("Marche=:1 AND EstFermee =:2"; $vT_filtre; False)
//Else 
////$c4ES_MySelection:=zen___ds[$vT_table].query("EstFermee =:1"; False)
//$c4ES_MySelection:=$c4ES_root.query("EstFermee =:1"; False)
//End if 
//End if 
//End if 
//Else 
//$c4ES_MySelection:=$c4ES_root
//End case 


