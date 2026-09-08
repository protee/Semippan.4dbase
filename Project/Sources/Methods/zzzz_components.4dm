//%attributes = {}

var $cC_wox_Dependencies : cs:C1710.wox.Dependencies
var $vC_fo_tools; $vC_aj_dependencies : Collection
var $c4Fu_trojan : 4D:C1709.Function
var $cC_wox_syntaxEN : cs:C1710.wox.syntaxEN
var $vJ_sem; $vJ_4D_SVG; $vJ_syntaxEN : Object
var $vT_4D_SVG : Text

$cC_wox_Dependencies:=cs:C1710.wox.Dependencies.new()
$vC_fo_tools:=$cC_wox_Dependencies.getTools()

$cC_wox_syntaxEN:=cs:C1710.wox.syntaxEN.new()
$cC_wox_syntaxEN:=cs:C1710.wox.syntaxEN.me

$vC_aj_dependencies:=$cC_wox_syntaxEN.get_dependencies()
$vJ_sem:=$vC_aj_dependencies.query("t_app = sem").first()


$c4Fu_trojan:=_wox_Xlibrary()
$vC_aj_dependencies:=$c4Fu_trojan.call(Null:C1517; "cs.syntaxEN.me.get_dependencies()").call()
$vT_4D_SVG:="4D-SVG"
$vJ_4D_SVG:=$vC_aj_dependencies.query("t_app = :1"; $vT_4D_SVG).first()


$vJ_syntaxEN:=$cC_wox_syntaxEN.get_syntaxEN($vT_4D_SVG)

