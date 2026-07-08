//%attributes = {"lang":"en"}

$vJ_cs:=cs:C1710
$vJ_wox:=$vJ_cs.wox

$vC_cs:=OB Keys:C1719(cs:C1710).orderBy()
$vC_cs:=OB Values:C1718(cs:C1710)


//var $cs_PICTURES_LIST : cs.PICTURES_LIST
//var $cE_pictures : cs.PICTURESEntity
//var $vT : Text
//$cE_pictures:=ds.PICTURES.all().first()

//$cs_PICTURES_LIST:=cs.PICTURES_LIST.new()

//$vT:=$cs_PICTURES_LIST.lb_label($cE_pictures)

//#DECLARE($vT_toto : Text; $vL_titi : Integer;  ...  : Text)

//var $vJ_catalog; $vJ_prefs; $vJ_dup_related_many; $vJ_screen; $vJ_cs; $vJ_wox_cs : Object
//$vJ_catalog:=zen__catalog_parse()

//$vJ_prefs:=zen__storage_prefs()
//$vJ_dup_related_many:=$vJ_prefs.j_dup_related_many

//$vJ_screen:=wox__storage_prefs_screen()

//$vJ_cs:=cs

//$vJ_wox_cs:=cs.wox

var $vJ_components; $vJ_cs; $vJ_wox; $vJ_component; $vJ_syntaxEN : Object
var $c4Fi_syntaxEN : 4D:C1709.File
var $vC_cs; $vC_at_keys; $vC_at_spaces : Collection
var $idx : Integer
var $vT_component; $vT_space : Text

//$vC_at_spaces:=wok_spaces_get()

//$vJ_components:=wok___components()
$vJ_components:=wod_components_get()
//$vJ_components:=Storage.j_components
For each ($vT_component; $vJ_components)
	$vJ_component:=$vJ_components[$vT_component]
	$c4Fi_syntaxEN:=$vJ_component.fo_rsc.folder("en.lproj").file("syntaxEN.json")
	If ($c4Fi_syntaxEN.exists)
		$vJ_syntaxEN:=JSON Parse:C1218($c4Fi_syntaxEN.getText("UTF-8"))
		$vC_at_keys:=OB Keys:C1719($vJ_syntaxEN)
		//$vT_space:=$vC_at_keys.query("cs.@").first()
		$idx:=$vC_at_keys.indexOf("cs.@")
		If ($idx>=0)
			$vT_space:=Substring:C12($vC_at_keys[$idx]; 4)  // Get space !
		End if 
	End if 
End for each 
// *
// *****
// *

$vC_at_spaces:=wod_components_spaces_get()


