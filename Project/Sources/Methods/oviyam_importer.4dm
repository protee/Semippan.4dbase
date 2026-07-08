//%attributes = {"lang":"en"}

var $vL_form; $vL_refwin : Integer
var $vJ_form : Object
var $vT_form : Text
READ ONLY:C145(*)

$vT_form:="OG_IMPORTER"
$vL_form:=Plain form window:K39:10
$vL_refwin:=Open form window:C675($vT_form; $vL_form; On the left:K39:2; At the top:K39:5)
$vJ_form:=New object:C1471
DIALOG:C40($vT_form; $vJ_form)
CLOSE WINDOW:C154($vL_refwin)

