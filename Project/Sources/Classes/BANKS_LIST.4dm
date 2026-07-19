
Class extends ZEN__TABLES_LIST

Class constructor($vT_LB : Text)
	Super:C1705($vT_LB)  // Init LB
	
	
Function lb_initialize($vJ_data : Object; $is_local : Boolean)
	Super:C1706.lb_initialize($vJ_data; $is_local)  // Init LB
	var $vT_LB; $vT_column : Text
	$vT_LB:=This:C1470.t_LB
	If ($vT_LB#"")
		This:C1470.lb_meta_info_set()
		$vT_column:=This:C1470.get_column("SETS")
		If ($vT_column="")
			$vT_column:=This:C1470.get_column("label")
		End if 
		LISTBOX SET AUTO ROW HEIGHT:C1501(*; $vT_LB; lk row min height:K53:73; 20; lk pixels:K53:22)
		LISTBOX SET AUTO ROW HEIGHT:C1501(*; $vT_LB; lk row max height:K53:74; 250; lk pixels:K53:22)
		//$vT_column:=This.get_column("label")
		LISTBOX SET PROPERTY:C1440(*; $vT_column; lk auto row height:K53:72; lk yes:K53:69)
		LISTBOX SET PROPERTY:C1440(*; $vT_column; lk allow wordwrap:K53:39; lk yes:K53:69)
	End if 
	
Function lb_meta_info($cE_banks : cs:C1710.BANKSEntity)->$vJ_meta : Object
	var $vL_colors : Integer
	var $vJ_meta_cell : Object
	var $vT_column : Text
	$vJ_meta:=New object:C1471
	$vL_colors:=$cE_banks.BANKS_PACKS.colors
	//woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True)
	//$vJ_meta.stroke:=$vT_color_stroke
	//$vJ_meta.fill:=$vT_color_fill
	// For cells
	$vJ_meta_cell:=New object:C1471
	$vJ_meta.cell:=$vJ_meta_cell
	$vT_column:=This:C1470.get_column("BANKS_PACKS.label")
	This:C1470.meta_colors($vJ_meta_cell; $vL_colors; $vT_column)
	
	
Function lb_packs_label($cE_BANKS : cs:C1710.BANKSEntity)->$vT_answer : Text
	var $cE_packs : cs:C1710.PACKSEntity
	var $vL_colors; $vL_stroke; $vL_fill : Integer
	var $vT_label; $vT_subPath : Text
	var $cE_PATHS : cs:C1710.PATHSEntity
	$vT_subPath:=$cE_PATHS.subPath
	$cE_packs:=$cE_BANKS.BANKS_PACKS
	$vT_label:=" "+$cE_packs.label+" "
	$vL_colors:=$cE_packs.colors
	woc_sp_colors_to_rgb($vL_colors; ->$vL_stroke; ->$vL_fill)
	ST SET ATTRIBUTES:C1093($vT_label; 1; 0; Attribute text color:K65:7; $vL_stroke; Attribute background color:K65:8; $vL_fill)
	//ST SET ATTRIBUTES($vT_label; 1; 0; Attribute text size; 12)  //;Attribute bold style;1)
	//ST SET ATTRIBUTES($vT_label; 1; 0; Attribute bold style; 1)
	$vT_answer:=$vT_label
	
	
Function lb_label($cE_banks : cs:C1710.BANKSEntity)->$vT_answer : Text
	var $vL_color_stroke; $vL_color_fill; $vL_primary; $vL_secondary : Integer
	var $vT_label; $vT_subPath : Text
	var $vJ_prefs_wox; $vJ_colors : Object
	$vJ_prefs_wox:=wox__storage_prefs
	$vJ_colors:=$vJ_prefs_wox.j_colors
	$vL_primary:=$vJ_colors.l_primary
	$vL_secondary:=$vJ_colors.l_secondary
	woc_sp_colors_to_rgb($vL_primary; ->$vL_color_stroke; ->$vL_color_fill)
	$vT_label:=" "+$cE_banks.label+" "
	ST SET ATTRIBUTES:C1093($vT_label; 1; 0; Attribute text color:K65:7; $vL_color_stroke; Attribute background color:K65:8; $vL_color_fill)
	ST SET ATTRIBUTES:C1093($vT_label; 1; 0; Attribute text size:K65:6; 12)  //;Attribute bold style;1)
	$vT_subPath:=$cE_banks.subPath
	woc_sp_colors_to_rgb($vL_secondary; ->$vL_color_stroke; ->$vL_color_fill)
	ST SET ATTRIBUTES:C1093($vT_subPath; 1; 0; Attribute text size:K65:6; 10; Attribute italic style:K65:2; 1)
	ST SET ATTRIBUTES:C1093($vT_subPath; 1; 0; Attribute text color:K65:7; $vL_color_stroke; Attribute background color:K65:8; $vL_color_fill)
	$vT_answer:=$vT_label+" "+$vT_subPath  //+Char(Carriage return)+$txt
	
	
	
Function lb_sets_count($cE_banks : cs:C1710.BANKSEntity)->$vL_count : Integer
	$vL_count:=$cE_banks.BANKS_SETS.length
	
Function lb_label_sets($cE_banks : cs:C1710.BANKSEntity; $is_CR : Boolean)->$vT_answer : Text
	$vT_answer:=This:C1470.lb_label($cE_banks)
	$vT_answer+=This:C1470.lb_sets_txt($cE_banks; $is_CR)
	
	
Function lb_sets_txt($cE_banks : cs:C1710.BANKSEntity; $is_CR : Boolean)->$vT_answer : Text
	var $cE_SETS : cs:C1710.SETSEntity
	var $cES_SETS : cs:C1710.SETSSelection
	var $idx; $vL_ternary; $vL_color_stroke; $vL_color_fill : Integer
	var $vJ_prefs_wox; $vJ_colors : Object
	var $vT_label : Text
	$cES_SETS:=$cE_banks.BANKS_SETS.orderBy("fileStart")
	$vT_answer:=""
	$vJ_prefs_wox:=zen__storage_prefs
	$vJ_colors:=$vJ_prefs_wox.j_colors
	$vL_ternary:=$vJ_colors.l_ternary
	woc_sp_colors_to_rgb($vL_ternary; ->$vL_color_stroke; ->$vL_color_fill)
	$idx:=0
	For each ($cE_SETS; $cES_SETS)
		//$vT_answer+=$idx=0 ? "" : " • "
		$vT_answer+=($idx=0 && Not:C34($is_CR)) ? "" : Char:C90(Carriage return:K15:38)
		$vT_label:=$cE_SETS.fileStart
		ST SET ATTRIBUTES:C1093($vT_label; 1; 0; Attribute text color:K65:7; $vL_color_stroke; Attribute background color:K65:8; $vL_color_fill)
		$vT_answer+=$vT_label+" "+String:C10($cE_SETS.width)+"×"+String:C10($cE_SETS.height)
		
		$idx+=1
	End for each 
	
	