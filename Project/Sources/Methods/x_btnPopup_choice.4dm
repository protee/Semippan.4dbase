//%attributes = {"invisible":true,"lang":"en"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Olivier GRIMBERT
// Date et heure : 15/04/16, 11:27:17
// ----------------------------------------------------
// Méthode : ogX_imgPopup_choose
// Description
// 
//
// Paramètres
// ----------------------------------------------------
// $1 <PTR> : field/var num 
// $2 <STR> : name icons
// $3 <PTR> : array label | nombre de valeurs
// ${4} <PTR> : array Longint idx or Boolean active // Pour menu variables en items

// $0 : vrai si Write

var $vP_field; $1; $vP_t_labels; $3; $vP_t_idxs; $4 : Pointer
var $vT_strIcons; $2 : Text

$vP_field:=$1
$vT_strIcons:=$2
$vP_t_labels:=$3
$vL_tt:=Size of array:C274($vP_t_labels->)
If (Count parameters:C259>=4)
	$vP_t_idxs:=$4
Else 
	ARRAY BOOLEAN:C223($aB_masks; $vL_tt)  // No param
	$vP_t_idxs:=->$aB_masks
	For ($i; 1; $vL_tt)
		$aB_masks{$i}:=True:C214
	End for 
End if 
var $isBooleanArray : Boolean
$isBooleanArray:=(Type:C295($vP_t_idxs->)=Boolean array:K8:21)


var $isOk : Boolean
$isOk:=False:C215

var $vT_cheminPictos; $vT_path_icon_info : Text
$vT_cheminPictos:="path:/RESOURCES/"+$vT_strIcons
$vT_path_icon_info:="path:/RESOURCES/icons/icn_magik_info.png"

$vL_value:=$vP_field->

var $vT_refMenu : Text
var $i; $vL_start; $vL_tt : Integer
var $vT_label : Text
If ($vP_t_labels->{0}="")
	$vL_start:=1
Else 
	$vL_start:=0
End if 
$vL_tt:=Size of array:C274($vP_t_labels->)

$vT_refMenu:=Create menu:C408
For ($i; $vL_start; $vL_tt)
	$vL_idx:=$i-1
	If ($i=0)
		$vT_label:=$vP_t_labels->{$i}
		If ($vT_label="")
			$vT_label:="Choose an action..."
		End if 
	Else 
		$vT_label:=$vP_t_labels->{$i}
	End if 
	$vT_label:=$vT_label+(" "*Num:C11(Length:C16($vT_label)=0))  // Espace si vide
	APPEND MENU ITEM:C411($vT_refMenu; $vT_label; *)
	If ($i=0)
		SET MENU ITEM PARAMETER:C1004($vT_refMenu; -1; "-1")
		SET MENU ITEM ICON:C984($vT_refMenu; -1; $vT_path_icon_info)
		DISABLE MENU ITEM:C150($vT_refMenu; -1)
	Else 
		If ($isBooleanArray)
			SET MENU ITEM PARAMETER:C1004($vT_refMenu; -1; String:C10($i-1))
			If (Not:C34($vP_t_idxs->{$i}))
				DISABLE MENU ITEM:C150($vT_refMenu; -1)
			End if 
			var $vL_noIdx : Integer
			$vL_noIdx:=$i-1
		Else 
			$vL_noIdx:=$vP_t_idxs->{$i}
			SET MENU ITEM PARAMETER:C1004($vT_refMenu; -1; String:C10($vL_noIdx))
		End if 
		SET MENU ITEM ICON:C984($vT_refMenu; -1; $vT_cheminPictos+String:C10($vL_noIdx)+k_png_ext)
		If ($vL_idx=$vL_value)
			SET MENU ITEM MARK:C208($vT_refMenu; -1; Char:C90(18))
		End if 
	End if 
End for 

var $vT_answerMenu : Text
$vT_answerMenu:=Dynamic pop up menu:C1006($vT_refMenu)
RELEASE MENU:C978($vT_refMenu)
var $vL_value; $vL_idx : Integer
$isOk:=(""#$vT_answerMenu)
If ($isOk)
	$vL_idx:=Num:C11($vT_answerMenu)
	$isOk:=($vL_idx>=0)  //& ($vL_value#$vL_idx)
	If ($isOk)
		$vP_field->:=$vL_idx
	End if 
End if 
$0:=$isOk

