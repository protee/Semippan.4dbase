//%attributes = {"preemptive":"capable"}
// *****
// *
// Method: zenh__TablesClass
// Olivier Grimbert — Protée sarl — 03/07/2025 11:39:39
//
// Description: JUST IN CASE YOU WANT TO FULLY SETS ALL PARAMS FOR TablesClass
// Often use of app_TablesClass_easy() -> zen_TablesClass_easy_create()
//
// Date       | Who | Comment
// 03/07/2025 | OG  | Updated
// *
// *****

#DECLARE()->$vC_aj_TablesClass : Collection
$vC_aj_TablesClass:=New collection:C1472


// *
// ***** DataClass
// *
var $vL_color_module_idx; $vL_color_table_idx : Integer
var $vL_links_mdx; $vL_tables_mdx; $vL_modules_mdx : Integer
$vL_color_table_idx:=10
$vL_color_module_idx:=$vL_color_table_idx+1
$vL_modules_mdx:=6
$vL_tables_mdx:=7
var $vL_tables_mdx1 : Integer
$vL_tables_mdx1:=0
$vL_links_mdx:=2

var $vC_tables : Collection
var $vL_colors_module : Integer
$vL_colors_module:=woc_sp_colors_from_row($vL_color_module_idx; 0; $vL_modules_mdx)
$vL_color_module_idx:=($vL_color_module_idx+2)%16
$vC_tables:=zen_TablesClass_module($vC_aj_TablesClass; "P"; "PUBLIC"; $vL_colors_module)

//var $vL_colors_links; $vL_colors_table : Integer
//var $vJ_table : Object
//$vL_colors_table:=woc_sp_colors_from_row($vL_color_table_idx; $vL_tables_mdx; $vL_tables_mdx1)
//$vL_colors_links:=woc_sp_colors_from_row($vL_color_table_idx; $vL_links_mdx; 0)
//$vL_color_table_idx:=($vL_color_table_idx+1)%16
//$vJ_table:=zen_TablesClass_table($vC_tables; ->[ZEN_POPUPS]; $vL_colors_table; $vL_colors_links)
//$vL_colors_table:=woc_sp_colors_from_row($vL_color_table_idx; $vL_tables_mdx; $vL_tables_mdx1)
//$vL_colors_links:=woc_sp_colors_from_row($vL_color_table_idx; $vL_links_mdx; 0)
//$vL_color_table_idx:=($vL_color_table_idx+1)%16
//$vJ_table:=zen_TablesClass_table($vC_tables; ->[CLIENTS:24]; $vL_colors_table; $vL_colors_links)
//$vL_colors_table:=woc_sp_colors_from_row($vL_color_table_idx; $vL_tables_mdx; $vL_tables_mdx1)
//$vL_colors_links:=woc_sp_colors_from_row($vL_color_table_idx; $vL_links_mdx; 0)
//$vL_color_table_idx:=($vL_color_table_idx+1)%16
//$vJ_table:=zen_TablesClass_table($vC_tables; ->[ZEN_SCHEMAS]; $vL_colors_table; $vL_colors_links)
//$vL_colors_table:=woc_sp_colors_from_row($vL_color_table_idx; $vL_tables_mdx; $vL_tables_mdx1)
//$vL_colors_links:=woc_sp_colors_from_row($vL_color_table_idx; $vL_links_mdx; 0)
//$vL_color_table_idx:=($vL_color_table_idx+1)%16
//$vJ_table:=zen_TablesClass_table($vC_tables; ->[MULTIPLAY]; $vL_colors_table; $vL_colors_links)

//$vL_colors_module:=woc_sp_colors_from_row($vL_color_module_idx; 0; $vL_modules_mdx)
//$vL_color_module_idx:=($vL_color_module_idx+2)%16
//$vC_tables:=zen_TablesClass_module($vC_aj_TablesClass; "V"; "VENTES"; $vL_colors_module)
//$vL_colors_table:=woc_sp_colors_from_row($vL_color_table_idx; $vL_tables_mdx; $vL_tables_mdx1)
//$vL_colors_links:=woc_sp_colors_from_row($vL_color_table_idx; $vL_links_mdx; 0)
//$vL_color_table_idx:=($vL_color_table_idx+1)%16
//$vJ_table:=zen_TablesClass_table($vC_tables; ->[PRODUITS:27]; $vL_colors_table; $vL_colors_links)
//$vL_colors_table:=woc_sp_colors_from_row($vL_color_table_idx; $vL_tables_mdx; $vL_tables_mdx1)
//$vL_colors_links:=woc_sp_colors_from_row($vL_color_table_idx; $vL_links_mdx; 0)
//$vL_color_table_idx:=($vL_color_table_idx+1)%16
//$vJ_table:=zen_TablesClass_table($vC_tables; ->[ACHATS:11]; $vL_colors_table; $vL_colors_links)
//$vL_colors_table:=woc_sp_colors_from_row($vL_color_table_idx; $vL_tables_mdx; $vL_tables_mdx1)
//$vL_colors_links:=woc_sp_colors_from_row($vL_color_table_idx; $vL_links_mdx; 0)
//$vL_color_table_idx:=($vL_color_table_idx+1)%16
//$vJ_table:=zen_TablesClass_table($vC_tables; ->[PARTENAIRES:22]; $vL_colors_table; $vL_colors_links)
//$vL_colors_table:=woc_sp_colors_from_row($vL_color_table_idx; $vL_tables_mdx; $vL_tables_mdx1)
//$vL_colors_links:=woc_sp_colors_from_row($vL_color_table_idx; $vL_links_mdx; 0)
//$vL_color_table_idx:=($vL_color_table_idx+1)%16
//$vJ_table:=zen_TablesClass_table($vC_tables; ->[HISTORIQUE_CREDITS:13]; $vL_colors_table; $vL_colors_links)
//$vL_colors_table:=woc_sp_colors_from_row($vL_color_table_idx; $vL_tables_mdx; $vL_tables_mdx1)
//$vL_colors_links:=woc_sp_colors_from_row($vL_color_table_idx; $vL_links_mdx; 0)
//$vL_color_table_idx:=($vL_color_table_idx+1)%16
//$vJ_table:=zen_TablesClass_table($vC_tables; ->[MESSAGES_HORS_SESSION:17]; $vL_colors_table; $vL_colors_links)

//$vL_colors_module:=woc_sp_colors_from_row($vL_color_module_idx; 0; $vL_modules_mdx)
//$vL_color_module_idx:=($vL_color_module_idx+2)%16
//$vC_tables:=zen_TablesClass_module($vC_aj_TablesClass; "S"; "SESSIONS"; $vL_colors_module)
//$vL_colors_table:=woc_sp_colors_from_row($vL_color_table_idx; $vL_tables_mdx; $vL_tables_mdx1)
//$vL_colors_links:=woc_sp_colors_from_row($vL_color_table_idx; $vL_links_mdx; 0)
//$vL_color_table_idx:=($vL_color_table_idx+1)%16
//$vJ_table:=zen_TablesClass_table($vC_tables; ->[VOYANTS:18]; $vL_colors_table; $vL_colors_links)
//$vL_colors_table:=woc_sp_colors_from_row($vL_color_table_idx; $vL_tables_mdx; $vL_tables_mdx1)
//$vL_colors_links:=woc_sp_colors_from_row($vL_color_table_idx; $vL_links_mdx; 0)
//$vL_color_table_idx:=($vL_color_table_idx+1)%16
//$vJ_table:=zen_TablesClass_table($vC_tables; ->[CONTRATS:21]; $vL_colors_table; $vL_colors_links)
//$vL_colors_table:=woc_sp_colors_from_row($vL_color_table_idx; $vL_tables_mdx; $vL_tables_mdx1)
//$vL_colors_links:=woc_sp_colors_from_row($vL_color_table_idx; $vL_links_mdx; 0)
//$vL_color_table_idx:=($vL_color_table_idx+1)%16
//$vJ_table:=zen_TablesClass_table($vC_tables; ->[SESSIONS:16]; $vL_colors_table; $vL_colors_links)
//$vL_colors_table:=woc_sp_colors_from_row($vL_color_table_idx; $vL_tables_mdx; $vL_tables_mdx1)
//$vL_colors_links:=woc_sp_colors_from_row($vL_color_table_idx; $vL_links_mdx; 0)
//$vL_color_table_idx:=($vL_color_table_idx+1)%16
//$vJ_table:=zen_TablesClass_table($vC_tables; ->[MESSAGES:15]; $vL_colors_table; $vL_colors_links)


