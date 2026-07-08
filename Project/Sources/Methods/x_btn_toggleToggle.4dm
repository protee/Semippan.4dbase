//%attributes = {"invisible":true,"lang":"en"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Olivier GRIMBERT
// Date et heure : 05/04/16, 15:51:05
// ----------------------------------------------------
// Méthode : ogX_btn_toogleToogle
// Description
//
//
// Paramètres
// $1 <PTR> : sur bouton image
// $2 <INT> : modulo du toogle
// $0 <INT> : valeur du toogle
// ----------------------------------------------------


var $vP_button : Pointer
var $vL_modulo : Integer
$vP_button:=$1
$vL_modulo:=$2

var $vL_value : Integer
$vL_value:=x_btn_toggleRead($vP_button)
$vL_value:=($vL_value+1)%$vL_modulo
x_btn_toggleSet($vP_button; $vL_value)

$0:=$vL_value










