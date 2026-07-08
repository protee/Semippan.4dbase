//%attributes = {}

var $c4Fu_query : 4D:C1709.Function
var $c4Fi_toto : 4D:C1709.File
var $vC_cs_host; $vC_cs_components; $vC_at_spaces; $vC_at_spaces1 : Collection
var $cs_sem_output : cs:C1710.sem_output
var $cC_wox_TranslateAPI : cs:C1710.wox.TranslateAPI
var $vJ_wox; $vJ_cs : Object

$c4Fi_toto:=File:C1566("")

//var $c4CS_wox : 4D.ClassStore
//$c4CS_wox:=cs.wox

$cC_wox_TranslateAPI:=cs:C1710.wox.TranslateAPI.new()
$vJ_wox:=cs:C1710.wox


$vJ_cs:=cs:C1710
$vC_cs_host:=OB Entries:C1720(cs:C1710)
$c4Fu_query:=Formula:C1597(OB Class:C1730($1.value.value).name="ClassStore")
$vC_cs_components:=$vC_cs_host.filter($c4Fu_query)
$vC_at_spaces:=$vC_cs_components.extract("key").orderBy()

$vC_at_spaces1:=wod_components_spaces_get().orderBy()

$cs_sem_output:=cs:C1710.sem_output.new()
