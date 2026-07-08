//%attributes = {"invisible":true,"lang":"en"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Olivier GRIMBERT
// Date et heure : 05/04/16, 15:48:59
// ----------------------------------------------------
// Méthode : ogX_btn_toogleSet
// Description
// 
//
// Paramètres
// $1 <PTR> : sur bouton image
// $2 <INT> : valeur du toogle
// ----------------------------------------------------

var $vP_button : Pointer
var $vL_value : Integer
$vP_button:=$1
$vL_value:=$2

var $vT_btnFormat : Text
var $k : Integer
If ($vP_button=Null:C1517)
	TRACE:C157
Else 
	$vT_btnFormat:=OBJECT Get format:C894($vP_button->)
	$k:=Position:C15(k_png_ext; $vT_btnFormat)
	//OBJECT SET FORMAT($PtrButton->;Substring($btnFormat;1;$k-2)+String($Value)+Substring($btnFormat;$k))
	
	var $vT_char : Text
	var $vL_nbDigits : Integer
	$vT_char:=Substring:C12($vT_btnFormat; $k-2; 1)  // Check if 0-9 digit on dizains
	$vL_nbDigits:=Num:C11(($vT_char>="0") & ($vT_char<="9"))+1  // nb digits : 1 or 2
	OBJECT SET FORMAT:C236($vP_button->; Substring:C12($vT_btnFormat; 1; $k-$vL_nbDigits-1)+String:C10($vL_value)+Substring:C12($vT_btnFormat; $k))
End if 











