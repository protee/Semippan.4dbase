//%attributes = {"invisible":true,"lang":"en"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Olivier GRIMBERT
// Date et heure : 05/04/16, 15:45:54
// ----------------------------------------------------
// Méthode : ogX_btn_toogleRead
// Description
// 
//
// Paramètres
// $1 <PTR> : sur bouton image
// $0 <INT> : valeur du toogle
// ----------------------------------------------------

var $vP_button : Pointer
$vP_button:=$1
var $vL_value; $k : Integer

var $vT_btnFormat : Text
If ($vP_button=Null:C1517)
	TRACE:C157
	$vL_value:=0
Else 
	$vT_btnFormat:=OBJECT Get format:C894($vP_button->)
	$k:=Position:C15(k_png_ext; $vT_btnFormat)
	//$value:=Num(Substring($btnFormat;$k-1;1))
	
	var $vT_char : Text
	var $vL_nbDigits : Integer
	$vT_char:=Substring:C12($vT_btnFormat; $k-2; 1)  // Check if 0-9 digit on dizains
	$vL_nbDigits:=Num:C11(($vT_char>="0") & ($vT_char<="9"))+1  // nb digits : 1 or 2
	$vL_value:=Num:C11(Substring:C12($vT_btnFormat; $k-$vL_nbDigits; $vL_nbDigits))
End if 
$0:=$vL_value










