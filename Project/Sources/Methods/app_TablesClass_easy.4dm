//%attributes = {"lang":"en","preemptive":"capable"}

#DECLARE()->$vC_aj_TablesClass : Collection
var $vC_aj_modulesTables; $vC_tables : Collection
var $vL_colors_start_row : Integer
var $vJ_module; $vJ_relate; $vJ_table : Object


// ***** Easy create
// *
$vJ_relate:=zen__storage_widgets().j_relate
Use ($vJ_relate)
	$vJ_relate.t_base_name:=sem__storage_prefs.t_name
	//$vJ_relate.l_bkg_color:=k_MDcolorBlack
	$vJ_relate.l_modules_mdx:=13
	$vJ_relate.l_tables_mdx:=5
	$vJ_relate.l_links_mdx:=4
	$vJ_relate.l_modules_opacity:=50
	//$vJ_relate.l_opacity:=80
End use 
$vL_colors_start_row:=6  // Start color MD idx
// *
// *****

$vC_aj_modulesTables:=New collection:C1472()


// ***** Module Sēmippān
// *
$vJ_module:=New object:C1471()
$vC_aj_modulesTables.push($vJ_module)
$vJ_module.t_char:="S"
$vJ_module.t_label:="Sēmippān"
$vC_tables:=New collection:C1472()
$vJ_module.ap_tables:=$vC_tables
$vC_tables.push(->[PACKS:11]; ->[TEMPLATES:8]; ->[COMBINATIONS:36]; ->[BANKS:12]; ->[SETS:14]; ->[MEDIA:13])
$vC_tables.push(->[PICTURES:15]; ->[CATEGORIES:16])

// ***** Module Pictures
// *
//$vJ_module:=New object()
//$vC_aj_modulesTables.push($vJ_module)
//$vJ_module.t_char:="P"
//$vJ_module.t_label:="Pictures"
//$vC_tables:=New collection()
//$vJ_module.ap_tables:=$vC_tables
//$vC_tables.push(->[PICTURES]; ->[CATEGORIES])

// ***** Module Databases
// *
$vJ_module:=New object:C1471()
$vC_aj_modulesTables.push($vJ_module)
$vJ_module.t_char:="D"
$vJ_module.t_label:="Databases"
$vC_tables:=New collection:C1472()
$vJ_module.ap_tables:=$vC_tables
$vC_tables.push(->[PRODUCTS:33]; ->[TYPES:32]; ->[PATHS:7])

// ***** Module Vedās
// *
$vJ_module:=New object:C1471()
$vC_aj_modulesTables.push($vJ_module)
$vJ_module.t_char:="V"
$vJ_module.t_label:="Vedās"
$vC_tables:=New collection:C1472()
$vJ_module.ap_tables:=$vC_tables
$vC_tables.push(->[KAVIYAM:17]; ->[SLOKAS:18])



// ***** EASY CREATE
// *
$vC_aj_TablesClass:=zen_TablesClass_easy_create($vC_aj_modulesTables; $vL_colors_start_row)


// ***** Add some properties wor tables
// *
$vJ_table:=zen_TablesClass_get_table($vC_aj_TablesClass; Table:C252(->[TYPES:32]))
$vJ_table.t_wor:="m_4d_types"  // Indicate wor, and what m_menu to use
// *
// *****

