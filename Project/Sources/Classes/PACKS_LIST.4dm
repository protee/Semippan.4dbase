
Class extends ZEN__TABLES_LIST

Class constructor($vT_LB : Text)
	Super:C1705($vT_LB)  // Init LB
	
Function lb_initialize($vJ_data : Object; $is_local : Boolean)
	var $vT_LB : Text
	Super:C1706.lb_initialize($vJ_data; $is_local)  // Init LB
	$vT_LB:=This:C1470.t_LB
	If ($vT_LB#"")
		This:C1470.lb_meta_info_set()
	End if 
	
Function lb_meta_info($c4E_entity : 4D:C1709.Entity)->$vJ_meta : Object
	var $vL_colors : Integer
	var $vJ_meta_cell : Object
	var $vT_column : Text
	$vJ_meta:=New object:C1471
	$vL_colors:=$c4E_entity.colors
	//woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True)
	//$vJ_meta.stroke:=$vT_color_stroke
	//$vJ_meta.fill:=$vT_color_fill
	// For cells
	$vJ_meta_cell:=New object:C1471
	$vJ_meta.cell:=$vJ_meta_cell
	$vT_column:=This:C1470.get_column("label")
	This:C1470.meta_colors($vJ_meta_cell; $vL_colors; $vT_column)
	
	
Function lb_paths_count($cE_packs : cs:C1710.PACKSEntity)->$vL_count : Integer
	$vL_count:=$cE_packs.PACKS_PATHS.length
	