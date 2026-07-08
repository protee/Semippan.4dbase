
Class extends ZEN__TABLES_LIST

Class constructor($vT_LB : Text)
	Super:C1705($vT_LB)  // Init LB
	
	
Function lb_initialize($vJ_data : Object; $is_local : Boolean)
	Super:C1706.lb_initialize($vJ_data; $is_local)  // Init LB
	var $vT_LB : Text
	$vT_LB:=This:C1470.t_LB
	If ($vT_LB#"")
		This:C1470.lb_meta_info_set()
	End if 
	
Function lb_meta_info($cE_SLOKAS : cs:C1710.SLOKASEntity)->$vJ_meta : Object
	var $vL_colors : Integer
	$vJ_meta:=New object:C1471
	
	//$vL_colors:=$c4E_entity.colors
	//woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True)
	//$vJ_meta.stroke:=$vT_color_stroke
	//$vJ_meta.fill:=$vT_color_fill
	$cE_PRODUCTS:=$cE_SLOKAS.SLOKAS_PRODUCTS
	$vL_colors:=$cE_PRODUCTS#Null:C1517 ? $cE_PRODUCTS.colors : $cE_SLOKAS.colors
	
	// For cells
	var $vJ_meta_cell : Object
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	var $vT_column : Text
	$vJ_meta_cell:=New object:C1471
	$vJ_meta.cell:=$vJ_meta_cell
	$vT_column:=This:C1470.get_column("SLOKAS_PRODUCTS.label")
	This:C1470.meta_cell_colors($vJ_meta_cell; $vT_column; $vL_colors)
	
Function lb_label($cE_SLOKAS : cs:C1710.SLOKASEntity)->$vT_label : Text
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	$cE_PRODUCTS:=$cE_SLOKAS.SLOKAS_PRODUCTS
	$vT_label:=$cE_PRODUCTS#Null:C1517 ? $cE_PRODUCTS.label : $cE_SLOKAS.label
	
	