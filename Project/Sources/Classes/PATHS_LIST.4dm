
Class extends ZEN__TABLES_LIST

Class constructor($vT_LB : Text)
	// Init LB
	Super:C1705($vT_LB)
	
Function lb_initialize($vJ_data : Object; $is_local : Boolean)
	Super:C1706.lb_initialize($vJ_data; $is_local)  // Init LB
	var $vT_LB : Text
	$vT_LB:=This:C1470.t_LB
	If ($vT_LB#"")
		//This.lb_meta_info_set()
	End if 
	
	
	//Function lb_meta_info($cE_PATHS : cs.PATHSEntity)->$vJ_meta : Object
	//$vJ_meta:=New object
	//var $vL_colors; $vL_colors_assPer : Integer
	//var $vT_color_stroke; $vT_color_fill : Text
	//$vL_colors:=$cE_PATHS.PATHS_PACKS.colors
	//woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True)
	//$vJ_meta.stroke:=$vT_color_stroke
	//$vJ_meta.fill:=$vT_color_fill
	
	//// For cells
	//var $vJ_meta_cell : Object
	//$vJ_meta_cell:=New object
	//$vJ_meta.cell:=$vJ_meta_cell
	//This.meta_colors($vJ_meta_cell; $vL_colors_assPer; "Column1")
	
	
Function lb_packs_label($cE_PATHS : cs:C1710.PATHSEntity)->$vT_answer : Text
	var $cE_packs : cs:C1710.PACKSEntity
	var $vL_colors; $vL_stroke; $vL_fill; $vL_colorStrokeH2; $vL_colorFillH2 : Integer
	var $vT_label; $vT_subPath : Text
	$vT_subPath:=$cE_PATHS.subPath
	$cE_packs:=$cE_PATHS.PATHS_PACKS
	$vT_label:=" "+$cE_packs.label+" "
	$vL_colors:=$cE_packs.colors
	woc_sp_colors_to_rgb($vL_colors; ->$vL_stroke; ->$vL_fill)
	woc_sp_colors_to_rgb(k_MDcolorsAppSecondary; ->$vL_colorStrokeH2; ->$vL_colorFillH2)
	ST SET ATTRIBUTES:C1093($vT_label; 1; 0; Attribute text color:K65:7; $vL_stroke; Attribute background color:K65:8; $vL_fill)
	ST SET ATTRIBUTES:C1093($vT_label; 1; 0; Attribute text size:K65:6; 12)  //;Attribute bold style;1)
	ST SET ATTRIBUTES:C1093($vT_subPath; 1; 0; Attribute text size:K65:6; 10; Attribute italic style:K65:2; 1)
	ST SET ATTRIBUTES:C1093($vT_subPath; 1; 0; Attribute text color:K65:7; $vL_colorStrokeH2; Attribute background color:K65:8; $vL_colorFillH2)
	$vT_answer:=$vT_label+" "+$vT_subPath  //+Char(Carriage return)+$txt
	
	
Function lb_products_label($cE_PATHS : cs:C1710.PATHSEntity)->$vT_answer : Text
	var $cE_products : cs:C1710.PRODUCTSEntity
	var $vL_colors; $vL_stroke; $vL_fill; $vL_colorStrokeH2; $vL_colorFillH2 : Integer
	var $vT_label; $vT_subPath : Text
	var $is_external : Boolean
	var $vJ_prefs_wox; $vJ_colors : Object
	$is_external:=$cE_PATHS.isExternalPath
	$vT_subPath:=$is_external ? $cE_PATHS.label : $cE_PATHS.subPath
	$cE_products:=$cE_PATHS.PATHS_PRODUCTS
	$vT_label:=" "+$cE_products.label+" "
	$vL_colors:=$cE_products.colors
	woc_sp_colors_to_rgb($vL_colors; ->$vL_stroke; ->$vL_fill)
	$vJ_prefs_wox:=wox__storage_prefs
	$vJ_colors:=$vJ_prefs_wox.j_colors
	$vL_colors:=$is_external ? $vJ_colors.l_secondary : $vJ_colors.l_primary
	woc_sp_colors_to_rgb($vL_colors; ->$vL_colorStrokeH2; ->$vL_colorFillH2)
	ST SET ATTRIBUTES:C1093($vT_label; 1; 0; Attribute text color:K65:7; $vL_stroke; Attribute background color:K65:8; $vL_fill)
	ST SET ATTRIBUTES:C1093($vT_label; 1; 0; Attribute text size:K65:6; 12)  //;Attribute bold style;1)
	ST SET ATTRIBUTES:C1093($vT_subPath; 1; 0; Attribute text size:K65:6; 10; Attribute italic style:K65:2; 1)
	ST SET ATTRIBUTES:C1093($vT_subPath; 1; 0; Attribute text color:K65:7; $vL_colorStrokeH2; Attribute background color:K65:8; $vL_colorFillH2)
	$vT_answer:=$vT_label+" "+$vT_subPath
	