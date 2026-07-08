
Class extends ZEN__TABLES_LIST

Class constructor($vT_LB : Text)
	Super:C1705($vT_LB)  // Init LB
	
Function lb_initialize($vJ_data : Object; $is_local : Boolean)
	Super:C1706.lb_initialize($vJ_data; $is_local)  // Init LB
	var $vT_LB : Text
	$vT_LB:=This:C1470.t_LB
	If ($vT_LB#"")
		//This.lb_meta_info_set()
	End if 
	
Function lb_meta_info($c4E_entity : 4D:C1709.Entity)->$vJ_meta : Object
	var $vL_colors : Integer
	var $vJ_meta_cell : Object
	var $vT_column : Text
	$vJ_meta:=New object:C1471
	$vL_colors:=$c4E_entity.colors
	//This.meta_line_colors($vJ_meta; $vL_colors)  // For line
	$vJ_meta_cell:=New object:C1471  // For cells
	$vJ_meta.cell:=$vJ_meta_cell
	$vT_column:=This:C1470.get_column("title")
	This:C1470.meta_cell_colors($vJ_meta_cell; $vT_column; $vL_colors)
	
	
Function lb_fileName($cE_MEDIA : cs:C1710.MEDIAEntity)->$vT_answer : Text
	var $vL_color_stroke; $vL_color_fill; $vL_orderMode; $vL_orderOffset : Integer
	var $vL_primary; $vL_secondary; $vL_ternary : Integer
	var $vT_fileStart; $vT_fileName; $vT_mime; $vT_picture; $vT_order; $vT_menu : Text
	var $cE_SETS : cs:C1710.SETSEntity
	var $vJ_menu; $vJ_DTO; $vJ_prefs_wox; $vJ_colors : Object
	var $cE_pictures : cs:C1710.PICTURESEntity
	$vJ_DTO:=Form:C1466.j_DTO
	$cE_SETS:=$vJ_DTO.cE_SETS
	$vL_orderMode:=$vJ_DTO.l_orderMode
	$vL_orderOffset:=$vJ_DTO.l_orderOffset
	
	$vT_fileName:=$cE_MEDIA.fileName
	$vT_order:=$vL_orderMode=2 ? String:C10($cE_MEDIA.order+$vL_orderOffset-1) : ""
	If ($cE_SETS#Null:C1517)  //&& False
		$vT_fileStart:=$cE_SETS.fileStart
		$vJ_menu:=zen__storage_menuBtns().m_outputMime
		$vT_mime:="."+$vJ_menu.at_lbl[$cE_SETS.mime]
	End if 
	$vT_menu:=$cE_MEDIA.menuItem
	
	$vJ_prefs_wox:=wox__storage_prefs
	$vJ_colors:=$vJ_prefs_wox.j_colors
	$vL_primary:=$vJ_colors.l_primary
	$vL_secondary:=$vJ_colors.l_secondary
	$vL_ternary:=$vJ_colors.l_ternary
	woc_sp_colors_to_rgb($vL_primary; ->$vL_color_stroke; ->$vL_color_fill)
	ST SET ATTRIBUTES:C1093($vT_fileStart; 1; 0; Attribute text color:K65:7; $vL_color_stroke; Attribute background color:K65:8; $vL_color_fill)
	woc_sp_colors_to_rgb($vL_secondary; ->$vL_color_stroke; ->$vL_color_fill)
	ST SET ATTRIBUTES:C1093($vT_fileName; 1; 0; Attribute text color:K65:7; $vL_color_stroke; Attribute background color:K65:8; $vL_color_fill)
	woc_sp_colors_to_rgb($vL_ternary; ->$vL_color_stroke; ->$vL_color_fill)
	ST SET ATTRIBUTES:C1093($vT_order; 1; 0; Attribute text color:K65:7; $vL_color_stroke; Attribute background color:K65:8; $vL_color_fill)
	$vT_answer:=$vT_fileStart+$vT_fileName+$vT_order+$vT_mime  //+Char(Carriage return)+$txt
	ST SET ATTRIBUTES:C1093($vT_answer; 1; 0; Attribute text size:K65:6; 12)  //;Attribute bold style;1)
	$vT_answer+=($vT_menu#"" ? " \""+$vT_menu+"\"" : "")
	
	$cE_pictures:=$cE_MEDIA.MEDIA_PICTURES
	$vT_picture:=$cE_pictures.label
	ST SET ATTRIBUTES:C1093($vT_picture; 1; 0; Attribute text size:K65:6; 10; Attribute italic style:K65:2; 1)
	$vT_answer+=Char:C90(Carriage return:K15:38)+$vT_picture
	
	
	
Function lb_preview_img($cE_MEDIA : cs:C1710.MEDIAEntity)->$vO_picture : Picture
	var $cE_SETS : cs:C1710.SETSEntity
	var $vL_width_max; $vL_height_max; $vL_colors_in : Integer
	var $vT_LB : Text
	var $vJ_DTO : Object
	
	$vJ_DTO:=Form:C1466.j_DTO
	$cE_SETS:=$vJ_DTO.cE_SETS
	$vL_colors_in:=$vJ_DTO.l_colors_in
	//$cE_BANKS:=$cE_SETS.SETS_BANKS
	//$cE_PACKS:=$cE_BANKS.BANKS_PACKS
	//$vL_colors_in:=sem_get_colors_alColorsIdx($cE_PACKS.j_alColors; $cE_BANKS.colorsIdx; $vL_colors_in)
	
	$vO_picture:=sem_media_calculate($cE_SETS; $cE_MEDIA; $vL_colors_in; False:C215)  // Horizontal concatenation)
	$vT_LB:=This:C1470.t_LB
	//$vL_width_max:=LISTBOX Get column width(*; "Column3"; $vL_minWidth; $vL_maxWidth)+1
	//$vL_height_max:=LISTBOX Get rows height(*; $vT_LB; lk pixels)
	$vL_width_max:=114
	$vL_height_max:=36
	$vO_picture:=woc_picture_maxScale($vL_width_max; $vL_height_max; $vO_picture)
	