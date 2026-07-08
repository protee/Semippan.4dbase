
property cE_PACKS : cs:C1710.PACKSEntity
property cE_BANKS : cs:C1710.BANKSEntity
property cE_SETS : cs:C1710.SETSEntity
property j_zen_MEDIA : Object

Class constructor($cE_PACKS : cs:C1710.PACKSEntity; $cE_BANKS : cs:C1710.BANKSEntity; $cE_SETS : cs:C1710.SETSEntity; $vJ_zen_MEDIA : Object)
	var $cES_MEDIA : cs:C1710.MEDIASelection
	This:C1470.cE_PACKS:=$cE_PACKS  // Might be Null. For ajColors calculation
	This:C1470.cE_BANKS:=$cE_BANKS
	This:C1470.cE_SETS:=$cE_SETS
	This:C1470.j_zen_MEDIA:=$vJ_zen_MEDIA
	$cES_MEDIA:=$vJ_zen_media.lb_selection
	
	
Function _get_selected($is_all : Boolean)->$cES_MEDIA : cs:C1710.MEDIASelection  // Get selected or all
	var $vJ_zen_MEDIA : Object
	$vJ_zen_MEDIA:=This:C1470.j_zen_MEDIA
	$cES_MEDIA:=$vJ_zen_MEDIA.lb_selected
	If ($cES_MEDIA.length=0) && ($is_all)
		$cES_MEDIA:=$vJ_zen_MEDIA.lb_selection
	End if 
	
	
Function do_choose_menu()
	var $isOk : Boolean
	var $vC_menu_lbl; $vC_menu_tag : Collection
	var $idx; $vL_action : Integer
	var $vT_path_icon; $vT_refMenu; $vT_label; $vT_tag; $vT_answer; $vT_UID : Text
	var $vT_refMenu_sub : Text
	
	// *****
	// *
	$vC_menu_lbl:=New collection:C1472()
	$vC_menu_tag:=New collection:C1472()
	$vC_menu_lbl.push("Show on disk")
	$vC_menu_lbl.push("PathName to Clipboard")
	$vC_menu_lbl.push("Export for waz_menuBtn")
	$vC_menu_lbl.push("Colors to Clipboard")
	//$vC_menu_lbl.push("Create Project colors")
	$vC_menu_lbl.push("Buttons - clear images")
	$vC_menu_lbl.push("Buttons - clear text")
	$vC_menu_lbl.push("Buttons - clear prefix in name")
	$vC_menu_lbl.push("Buttons - clear in name end numbers")
	$vC_menu_lbl.push("Buttons - clear name")
	$vC_menu_lbl.push("Crop local pictures")
	
	$vC_menu_tag.push("show")
	$vC_menu_tag.push("pathname")
	$vC_menu_tag.push("menuBtn")
	$vC_menu_tag.push("colors")
	$vC_menu_tag.push("project")
	$vC_menu_tag.push("clear_pict")
	$vC_menu_tag.push("clear_text")
	$vC_menu_tag.push("clear_prefix")
	$vC_menu_tag.push("clear_number")
	$vC_menu_tag.push("clear_name")
	$vC_menu_tag.push("crop_pict")
	
	//$vT_path_icon:="Path:/RESOURCES/metier/bank_tools/icn_"
	$vT_path_icon:="Path:/RESOURCES/icons/icn_btnTools"
	
	$vT_refMenu:=Create menu:C408()
	$idx:=0
	For each ($vT_label; $vC_menu_lbl)
		$vT_tag:=$vC_menu_tag[$idx]
		Case of 
			: ($vT_tag="Show")
				$vT_refMenu_sub:=This:C1470._show_on_disk_menu($vT_tag)
				APPEND MENU ITEM:C411($vT_refMenu; $vT_label; $vT_refMenu_sub; *)
				
			: ($vT_tag="pathname")
				$vT_refMenu_sub:=This:C1470._show_on_disk_menu($vT_tag)
				APPEND MENU ITEM:C411($vT_refMenu; $vT_label; $vT_refMenu_sub; *)
				
			: ($vT_tag="colors")
				$vT_refMenu_sub:=This:C1470._colors_menu($vT_tag; $idx)
				APPEND MENU ITEM:C411($vT_refMenu; $vT_label; $vT_refMenu_sub; *)
				
			Else 
				APPEND MENU ITEM:C411($vT_refMenu; $vT_label; *)
		End case 
		SET MENU ITEM PARAMETER:C1004($vT_refMenu; -1; $vT_tag)
		SET MENU ITEM ICON:C984($vT_refMenu; -1; $vT_path_icon+String:C10($idx)+k_png_ext)
		$idx+=1
	End for each 
	
	$vT_answer:=Dynamic pop up menu:C1006($vT_refMenu)
	RELEASE MENU:C978($vT_refMenu)
	$isOk:=($vT_answer#"")
	If ($isOk)
		//$cES_MEDIA:=This._get_selected(True)
		Case of 
			: ($vT_answer="show.@")
				$vT_UID:=Replace string:C233($vT_answer; "show."; "")
				This:C1470._show_on_disk($vT_UID)
				
			: ($vT_answer="pathname.@")
				$vT_UID:=Replace string:C233($vT_answer; "pathname."; "")
				This:C1470._pathname_to_pp($vT_UID)
				
			: ($vT_answer="colors.@")
				$vL_action:=Num:C11(Replace string:C233($vT_answer; "colors."; ""))
				This:C1470._colors_to_pp($vL_action)
				
			: ($vT_answer="menuBtn")
				This:C1470._export_menuBtn()
				
				//: ($vT_answer="project")
				//This._create_colors()
				
			: ($vT_answer="clear_pict")
				This:C1470._clear_pict()
				
			: ($vT_answer="clear_text")
				This:C1470._clear_text()
				
			: ($vT_answer="clear_prefix")
				This:C1470._clear_prefix()
				
			: ($vT_answer="clear_number")
				This:C1470._clear_number()
				
			: ($vT_answer="clear_name")
				This:C1470._clear_name()
				
			: ($vT_answer="crop_pict")
				This:C1470._crop_pict()
		End case 
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function _show_on_disk_menu($vT_prefix : Text)->$vT_refMenu : Text
	var $idx_color : Integer
	var $is_externalPath : Boolean
	var $vT_path_icon; $vT_label : Text
	var $cE_BANKS : cs:C1710.BANKSEntity
	var $cES_MEDIA : cs:C1710.MEDIASelection
	var $cES_PATHS : cs:C1710.PATHSSelection
	var $cE_SETS : cs:C1710.SETSEntity
	var $cE_PATHS : cs:C1710.PATHSEntity
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	
	$cE_BANKS:=This:C1470.cE_BANKS
	$cE_SETS:=This:C1470.cE_SETS
	$cES_MEDIA:=This:C1470._get_selected(True:C214)
	$cES_PATHS:=$cE_BANKS.BANKS_PACKS.PACKS_PATHS.orderBy("PATHS_PRODUCTS.label, label")
	
	$vT_path_icon:="Path:/RESOURCES/icons/icn_btnTools"
	$vT_prefix+="."
	$vT_refMenu:=Create menu:C408
	For each ($cE_PATHS; $cES_PATHS)
		$is_externalPath:=$cE_PATHS.isExternalPath
		$vT_label:=$is_externalPath ? $cE_PATHS.label : $cE_PATHS.PATHS_PRODUCTS.label
		APPEND MENU ITEM:C411($vT_refMenu; $vT_label; *)
		SET MENU ITEM PARAMETER:C1004($vT_refMenu; -1; $vT_prefix+$cE_PATHS.UID)
		$idx_color:=$cE_PRODUCTS.colors
		woc_SET_MENU_ITEM_icnm($vT_refMenu; -1; $idx_color; True:C214)
		//If ($vL_id=$vL_id_current)
		//SET MENU ITEM MARK($vT_refMenu; -1; Char(18))
		//DISABLE MENU ITEM($vT_refMenu; -1)
		//End if 
		If ($is_externalPath)
			SET MENU ITEM STYLE:C425($vT_refMenu; -1; Bold:K14:2)
		End if 
	End for each 
	// *
	// *****
	
	
	// *****
	// *
Function _colors_menu($vT_prefix : Text; $idx_main : Integer)->$vT_refMenu : Text
	var $vC_menu_lbl : Collection
	var $idx : Integer
	var $vT_path_icon; $vT_label : Text
	
	$vC_menu_lbl:=New collection:C1472()
	$vC_menu_lbl.push("woc SF")
	$vC_menu_lbl.push("\"woc_sp_colors_from_SF\"")
	$vC_menu_lbl.push("Stroke woc")
	$vC_menu_lbl.push("Stroke_rgb\"")
	$vC_menu_lbl.push("Stroke_#rgb")
	$vC_menu_lbl.push("Fill woc")
	$vC_menu_lbl.push("Fill_rgb")
	$vC_menu_lbl.push("Fill_#rgb")
	
	//$vT_path_icon:="Path:/RESOURCES/icons/icn_btnToolsColors"
	$vT_path_icon:="Path:/RESOURCES/icons/icn_btnTools"
	$vT_prefix+="."
	
	$vT_refMenu:=Create menu:C408()
	$idx:=0
	For each ($vT_label; $vC_menu_lbl)
		APPEND MENU ITEM:C411($vT_refMenu; $vT_label; *)
		SET MENU ITEM PARAMETER:C1004($vT_refMenu; -1; $vT_prefix+String:C10($idx))
		SET MENU ITEM ICON:C984($vT_refMenu; -1; $vT_path_icon+String:C10($idx_main)+k_png_ext)
		$idx+=1
	End for each 
	// *
	// *****
	
	
	// *****
	// *
Function _pathname_to_pp($vT_UID : Text)
	var $vT_answer; $vT_title; $vT_fileName : Text
	var $c4Fo_root; $c4Fo_path : 4D:C1709.Folder
	var $vC_answer : Collection
	var $c4Fi_file : 4D:C1709.File
	var $cE_BANKS : cs:C1710.BANKSEntity
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	var $cES_MEDIA : cs:C1710.MEDIASelection
	var $cE_PATHS : cs:C1710.PATHSEntity
	var $cE_SETS : cs:C1710.SETSEntity
	
	$cE_BANKS:=This:C1470.cE_BANKS
	$cE_SETS:=This:C1470.cE_SETS
	$cE_PATHS:=ds:C1482.PATHS.get($vT_UID)
	$c4Fo_root:=sem_PATHS_path($cE_PATHS)
	$c4Fo_path:=sem_BANKS_SETS_path($c4Fo_root; $cE_BANKS; $cE_SETS)
	
	$cES_MEDIA:=This:C1470._get_selected(True:C214)
	$vC_answer:=New collection:C1472()
	For each ($cE_MEDIA; $cES_MEDIA)
		$vT_fileName:=sem_MEDIA_fileName($cE_BANKS; $cE_SETS; $cE_MEDIA)
		$c4Fi_file:=$c4Fo_path.file($vT_fileName)
		$vC_answer.push($c4Fi_file.path)
	End for each 
	$vT_answer:=$vC_answer.join(Char:C90(Carriage return:K15:38))
	SET TEXT TO PASTEBOARD:C523($vT_answer)
	$vT_title:="Copy pathName's to PP?"
	If (waz_io_confirm($vT_title; $vT_answer; "copy"; "Copy"))
		SET TEXT TO PASTEBOARD:C523($vT_answer)
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function _show_on_disk($vT_UID : Text)
	var $vT_fileName : Text
	var $c4Fi_file : 4D:C1709.File
	var $c4Fo_root; $c4Fo_path : 4D:C1709.Folder
	var $vC_answer : Collection
	var $cE_BANKS : cs:C1710.BANKSEntity
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	var $cES_MEDIA : cs:C1710.MEDIASelection
	var $cE_PATHS : cs:C1710.PATHSEntity
	var $cE_SETS : cs:C1710.SETSEntity
	
	$cE_BANKS:=This:C1470.cE_BANKS
	$cE_SETS:=This:C1470.cE_SETS
	$cE_PATHS:=ds:C1482.PATHS.get($vT_UID)
	If ($cE_PATHS#Null:C1517)
		$c4Fo_root:=sem_PATHS_path($cE_PATHS)
		$c4Fo_path:=sem_BANKS_SETS_path($c4Fo_root; $cE_BANKS; $cE_SETS)
		If ($c4Fo_path.exists)
			$cES_MEDIA:=This:C1470._get_selected(True:C214)
			$vC_answer:=New collection:C1472()
			For each ($cE_MEDIA; $cES_MEDIA)
				$vT_fileName:=sem_MEDIA_fileName($cE_BANKS; $cE_SETS; $cE_MEDIA)
				$c4Fi_file:=$c4Fo_path.file($vT_fileName)
				SHOW ON DISK:C922($c4Fi_file.platformPath; *)
			End for each 
		End if 
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function _colors_to_pp($vL_output : Integer)
	var $is_short : Boolean
	var $vC_answer; $vC_at_al_lbl : Collection
	var $vL_stroke; $vL_fill : Integer
	var $vL_count_per_line; $vL_SETS_main; $vL_MEDIA_main; $vL_TEMPLATES_main; $vL_colors_out; $vL_colors_in : Integer
	var $vT_answer; $vT_title; $vT_vC_name; $vT_bind : Text
	var $cE_BANKS : cs:C1710.BANKSEntity
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	var $cES_MEDIA : cs:C1710.MEDIASelection
	var $cE_SETS : cs:C1710.SETSEntity
	var $cE_TEMPLATES : cs:C1710.TEMPLATESEntity
	var $vJ_SETS_dcox; $vJ_MEDIA_dcox; $vJ_TEMPLATES_dcox; $vJ_bind : Object
	var $cE_PACKS : cs:C1710.PACKSEntity
	
	$cE_PACKS:=This:C1470.cE_PACKS
	$cE_BANKS:=This:C1470.cE_BANKS
	$cE_SETS:=This:C1470.cE_SETS
	
	$vT_bind:="default"
	$vL_colors_in:=($cE_PACKS#Null:C1517) ? woc_sp_colors_from_alColorsIdx($cE_PACKS.j_alColors; $cE_BANKS.colorsIdx) : 0
	$cE_TEMPLATES:=$cE_SETS.SETS_TEMPLATES  // SET TEMPLATE missing!!
	$vJ_TEMPLATES_dcox:=$cE_TEMPLATES#Null:C1517 ? $cE_TEMPLATES.j_dcox : Null:C1517
	If ($vJ_TEMPLATES_dcox#Null:C1517)
		$vJ_bind:=$vJ_TEMPLATES_dcox["j_"+$vT_bind]
		$vL_colors_in:=woc_dcoxWidget_get_colors($vL_SETS_main; $vJ_bind; $vL_colors_in)
	End if 
	
	$vJ_SETS_dcox:=$cE_SETS.j_dcox
	$vL_SETS_main:=$vJ_SETS_dcox.l_main
	$vJ_bind:=$vJ_SETS_dcox["j_"+$vT_bind]
	$vL_colors_in:=woc_dcoxWidget_get_colors($vL_SETS_main; $vJ_bind; $vL_colors_in)
	
	$vC_at_al_lbl:=New collection:C1472()
	$cES_MEDIA:=This:C1470._get_selected(True:C214)
	For each ($cE_MEDIA; $cES_MEDIA)
		$vL_colors_out:=$vL_colors_in
		$vJ_MEDIA_dcox:=$cE_MEDIA.j_dcox
		$vL_MEDIA_main:=$vJ_MEDIA_dcox.l_main
		$cE_TEMPLATES:=$cE_MEDIA.MEDIA_TEMPLATES
		$vJ_TEMPLATES_dcox:=$cE_TEMPLATES#Null:C1517 ? $cE_TEMPLATES.j_dcox : Null:C1517
		If ($vJ_TEMPLATES_dcox#Null:C1517)
			$vL_TEMPLATES_main:=$vJ_TEMPLATES_dcox.l_main
			$vJ_bind:=$vJ_TEMPLATES_dcox["j_"+$vT_bind]
			$vL_colors_out:=woc_dcoxWidget_get_colors($vL_TEMPLATES_main; $vJ_bind; $vL_colors_out)
		End if 
		$vJ_bind:=$vJ_MEDIA_dcox["j_"+$vT_bind]
		$vL_colors_out:=woc_dcoxWidget_get_colors($vL_MEDIA_main; $vJ_bind; $vL_colors_out)
		woc_sp_colors_to_sf($vL_colors_out; ->$vL_stroke; ->$vL_fill)
		
		Case of 
			: ($vL_output=0)  // Colors direct
				$vC_at_al_lbl.push(String:C10($vL_colors_out; "&x"))
				
			: ($vL_output=1)  // Corlors indirect
				$vC_at_al_lbl.push("woc_sp_colors_from_SF ("+String:C10($vL_stroke; "&x")+";"+String:C10($vL_fill; "&x")+")")
				
			: ($vL_output=2)  // Color stroke direct
				$vC_at_al_lbl.push(String:C10($vL_stroke; "&x"))
				
			: ($vL_output=3)  // Color stroke_rgb
				//$vT_answer:=$vT_answer+Char(13)+"$vC_xxxx_color.push("+String(woc_sp_color_to_rgb($vL_stroke))+")"
				$vC_at_al_lbl.push("0x"+woc_sp_color_to_html($vL_stroke; False:C215; False:C215)+")")
				//woc_sp_colorToRGB
				
			: ($vL_output=4)  // Color stroke_#rgb
				$vC_at_al_lbl.push("\""+woc_sp_color_to_html($vL_stroke; True:C214; False:C215)+"\"")
				
			: ($vL_output=5)  // Color fill direct
				$vC_at_al_lbl.push(String:C10($vL_fill; "&x"))
				
			: ($vL_output=6)  // Color fill_rgb
				$vC_at_al_lbl.push("0x"+woc_sp_color_to_html($vL_fill; False:C215; False:C215))
				
			: ($vL_output=7)  // Color fill_#rgb
				$vC_at_al_lbl.push("\""+woc_sp_color_to_html($vL_fill; True:C214; False:C215)+"\"")
		End case 
	End for each 
	
	$vC_answer:=New collection:C1472()
	$is_short:=$vL_output#1
	$vL_count_per_line:=$is_short ? 6 : 1
	$vT_vC_name:="$vC_al_lbl"
	$vC_answer.push($vT_vC_name+":=New collection()")
	This:C1470._calculate_code($vC_answer; $vT_vC_name; $vC_at_al_lbl; $vL_count_per_line)
	
	$vT_answer:=$vC_answer.join(Char:C90(Carriage return:K15:38))
	$vT_title:="Color's code to copy?"
	If (waz_io_confirm($vT_title; $vT_answer; "copy"; "Copy"))
		SET TEXT TO PASTEBOARD:C523($vT_answer)
	End if 
	
	
	
Function _calculate_code($vC_answer : Collection; $vT_vC_name : Text; $vC_at_lbl : Collection; $vL_count_per_line : Integer)
	var $vL_count : Integer
	var $vT_answer; $vT_line : Text
	$vL_count:=-1  // Init
	$vT_answer:=""
	For each ($vT_line; $vC_at_lbl)
		If ($vL_count<=0)
			If ($vL_count=0)
				$vT_answer+=")"
				$vC_answer.push($vT_answer)
			End if 
			$vT_answer:=$vT_vC_name+".push("
			$vL_count:=$vL_count_per_line>0 ? $vL_count_per_line : 100
		Else 
			$vT_answer+=" ; "
		End if 
		$vT_answer+=$vT_line
		$vL_count+=-1
	End for each 
	If ($vT_answer#"")
		$vT_answer+=")"
		$vC_answer.push($vT_answer)
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function _export_menuBtn()
	var $is_btn_w; $is_set_colors : Boolean
	var $vC_at_al_lbl; $vC_at_at_lbl; $vC_answer; $vC_al_colors; $vC_al_colors_bk : Collection
	var $vL_colors; $vL_stroke; $vL_fill; $vL_count_per_line; $vL_rsct : Integer
	var $vT_vC_name; $vT_answer; $vT_title; $vT_menuItem : Text
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	var $cE_SETS : cs:C1710.SETSEntity
	var $cE_BANKS : cs:C1710.BANKSEntity
	var $cES_MEDIA : cs:C1710.MEDIASelection
	var $vJ_menuBtn; $vJ_dcox : Object
	var $cE_TEMPLATES : cs:C1710.TEMPLATESEntity
	var $cE_PACKS : cs:C1710.PACKSEntity
	
	$cE_PACKS:=This:C1470.cE_PACKS
	$cE_BANKS:=This:C1470.cE_BANKS
	$cE_SETS:=This:C1470.cE_SETS
	$cES_MEDIA:=This:C1470._get_selected(True:C214)
	
	$vC_at_at_lbl:=New collection:C1472()  // Text
	$vC_at_al_lbl:=New collection:C1472()  // Colors
	
	$is_set_colors:=$cE_SETS.j_options.isSetColors
	
	//$vC_al_colors:=Form.al_colors
	//$is_btn:=$cE_SETS.type>0
	//$cE_TEMPLATES:=$cE_SETS.SETS_TEMPLATES
	//$vJ_dcox:=$cE_TEMPLATES.j_dcox
	//$vC_al_colors:=sem_get_dcox_colors_first($vJ_dcox; $is_btn)
	//$vJ_dcox:=$cE_SETS.j_dcox
	//$vC_al_colors_bk:=sem_get_dcox_colors($vJ_dcox; $vC_al_colors)
	
	$vC_al_colors_bk:=Form:C1466.al_colors  // From Entity already calculated
	For each ($cE_MEDIA; $cES_MEDIA)
		$vC_al_colors:=$vC_al_colors_bk
		$vT_menuItem:=$cE_MEDIA.menuItem
		If ($vT_menuItem#"")
			If (Not:C34($is_set_colors))
				$cE_TEMPLATES:=$cE_MEDIA.MEDIA_TEMPLATES
				If ($cE_TEMPLATES#Null:C1517)
					$vJ_dcox:=$cE_TEMPLATES.j_dcox
					$vC_al_colors:=sem_get_dcox_colors($vJ_dcox; $vC_al_colors)
				End if 
				$vJ_dcox:=$cE_MEDIA.j_dcox
				$vC_al_colors:=sem_get_dcox_colors($vJ_dcox; $vC_al_colors)
			End if 
			$vL_colors:=$vC_al_colors[0]
			woc_sp_colors_to_sf($vL_colors; ->$vL_stroke; ->$vL_fill)
			$vC_at_at_lbl.push("\""+$vT_menuItem+"\"")
			$vC_at_al_lbl.push(String:C10($vL_colors; "&x"))
		End if 
	End for each 
	
	$vJ_menuBtn:=$cE_BANKS.j_menuBtn
	$vC_answer:=New collection:C1472()
	$vC_answer.push("// ***** m_"+$vJ_menuBtn.t_key+" btnMenu")
	$vC_answer.push("// *")
	$vC_answer.push("$vJ_menu:=New shared object()")
	$vC_answer.push("$vJ_menuBtns.m_"+$vJ_menuBtn.t_menu+":=$vJ_menu")
	$vC_answer.push("$vJ_menu.t_label:=\""+$vJ_menuBtn.t_label+"\"")
	If ($vJ_menuBtn.t_tip#"")
		$vC_answer.push("$vJ_menu.t_tip:=\""+$vJ_menuBtn.t_tip+"\"")
	End if 
	$is_btn_w:=$cE_SETS.width#$cE_SETS.height
	If ($is_btn_w)
		$vC_answer.push("$vJ_menu.l_btn_w:="+String:C10($cE_SETS.width))
	End if 
	$vC_answer.push("$vJ_menu.t_key:=\""+$vJ_menuBtn.t_key+"\"")
	$vC_answer.push("$vJ_menu.t_path:=\""+$cE_BANKS.subPath+"\"")
	//$vC_answer.push("$vJ_menu.t_icns:=\""+[Banks]pathRelative+"\"icn_"+[Banks]toggle_btn+"\"")
	$vC_answer.push("$vJ_menu.fo_rsc:=$c4Fo_rsc")
	$vC_answer.push("$vJ_menu.fu_icon:=$c4Fu_icon")
	$vL_rsct:=$vJ_menuBtn.l_rsct
	If ($vL_rsct>=0)
		$vC_answer.push("$vJ_menu.l_rsct:="+String:C10($vL_rsct))
	End if 
	
	//$vL_count_per_line:=wox_max(1; $vJ_menuBtn.l_countPerLine)
	$vL_count_per_line:=$vJ_menuBtn.l_countPerLine
	$vT_vC_name:="$vC_at_lbl"
	$vC_answer.push($vT_vC_name+":=wox_shared_at_lbl_new($vJ_menu)")
	This:C1470._calculate_code($vC_answer; $vT_vC_name; $vC_at_at_lbl; $vL_count_per_line)
	If ($vJ_menuBtn.isColors)
		$vT_vC_name:="$vC_al_lbl"
		$vC_answer.push($vT_vC_name+":=wox_shared_al_lbl_new($vJ_menu)")
		This:C1470._calculate_code($vC_answer; $vT_vC_name; $vC_at_al_lbl; $vL_count_per_line)
	End if 
	
	$vT_answer:=$vC_answer.join(Char:C90(Carriage return:K15:38))+Char:C90(Carriage return:K15:38)
	$vT_title:="Export for menu?"
	If (waz_io_confirm($vT_title; $vT_answer; "copy"; "Copy"))
		SET TEXT TO PASTEBOARD:C523($vT_answer)
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function _confirm_cES_MEDIA($vT_text : Text; $is_all : Boolean)->$cES_MEDIA_out : cs:C1710.MEDIASelection
	var $cES_MEDIA : cs:C1710.MEDIASelection
	var $vL_tt_records : Integer
	var $vT_answer : Text
	$cES_MEDIA:=This:C1470._get_selected($is_all)
	$vL_tt_records:=$cES_MEDIA.length
	If ($vL_tt_records=0)
		waz_io_alert_popup("No MEDIA selected!"; "stop")
	Else 
		$vT_text+=" - MEDIA ("+String:C10($vL_tt_records)+") ?"
		//$vT_text:=Replace string($vT_answer; "{number}"; String($vL_tt_records))
		If (waz_io_confirm_popup($vT_answer))
			$cES_MEDIA_out:=$cES_MEDIA
		End if 
	End if 
	
	
Function _clear_pict()
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	var $cES_MEDIA : cs:C1710.MEDIASelection
	$cES_MEDIA:=This:C1470._confirm_cES_MEDIA("Clear image links")
	If ($cES_MEDIA#Null:C1517)
		For each ($cE_MEDIA; $cES_MEDIA)
			$cE_MEDIA.UIDpicture:=Null:C1517
			zen_entity_save($cE_MEDIA)
		End for each 
	End if 
	// DO REFRESH !!!
	// *
	// *****
	
	
	// *****
	// *
Function _clear_text()
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	var $cES_MEDIA : cs:C1710.MEDIASelection
	$cES_MEDIA:=This:C1470._confirm_cES_MEDIA("Clear texts")
	If ($cES_MEDIA#Null:C1517)
		For each ($cE_MEDIA; $cES_MEDIA)
			$cE_MEDIA.text:=""
			zen_entity_save($cE_MEDIA)
		End for each 
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function _clear_prefix()
	var $k; $vL_lenght : Integer
	var $vT_fileStart; $vT_fileName : Text
	var $cE_BANKS : cs:C1710.BANKSEntity
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	var $cES_MEDIA : cs:C1710.MEDIASelection
	var $cE_SETS : cs:C1710.SETSEntity
	$cES_MEDIA:=This:C1470._confirm_cES_MEDIA("Clear fileStart found in fileName")
	If ($cES_MEDIA#Null:C1517)
		$cE_BANKS:=This:C1470.cE_BANKS
		$cE_SETS:=This:C1470.cE_SETS
		$vT_fileStart:=$cE_SETS.fileStart
		$vL_lenght:=Length:C16($vT_fileStart)+1
		For each ($cE_MEDIA; $cES_MEDIA)
			$vT_fileName:=$cE_MEDIA.fileName
			$k:=Position:C15($vT_fileStart; $vT_fileName)
			If ($k=1)
				$cE_MEDIA.fileName:=Substring:C12($vT_fileName; $vL_lenght)
				zen_entity_save($cE_MEDIA)
			End if 
		End for each 
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function _clear_number()
	var $vL_tt; $k; $i : Integer
	var $vT_char; $vT_fileName : Text
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	var $cES_MEDIA : cs:C1710.MEDIASelection
	$cES_MEDIA:=This:C1470._confirm_cES_MEDIA("Clear numbers at end")
	If ($cES_MEDIA#Null:C1517)
		For each ($cE_MEDIA; $cES_MEDIA)
			$vT_fileName:=$cE_MEDIA.fileName
			$vL_tt:=Length:C16($vT_fileName)
			$k:=0
			For ($i; $vL_tt; 1; -1)
				$vT_char:=$vT_fileName[[$i]]
				If (Not:C34(($vT_char>="0") & ($vT_char<="9")))
					$k:=$i
					break
				End if 
			End for 
			If ($k#0)
				$cE_MEDIA.fileName:=Substring:C12($vT_fileName; 1; $k)
				zen_entity_save($cE_MEDIA)
			End if 
		End for each 
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function _clear_name()
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	var $cES_MEDIA : cs:C1710.MEDIASelection
	$cES_MEDIA:=This:C1470._confirm_cES_MEDIA("Clear fileName")
	If ($cES_MEDIA#Null:C1517)
		For each ($cE_MEDIA; $cES_MEDIA)
			$cE_MEDIA.fileName:=""
			zen_entity_save($cE_MEDIA)
		End for each 
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function _crop_pict()
	var $isOk; $is_horizontal : Boolean
	var $vL_width_final; $vL_height_final; $vL_image_type; $vL_count; $vL_width; $vL_height : Integer
	var $vO_picture : Picture
	var $vR_width1; $vR_height1 : Real
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	var $cES_MEDIA : cs:C1710.MEDIASelection
	var $cE_SETS : cs:C1710.SETSEntity
	$cES_MEDIA:=This:C1470._confirm_cES_MEDIA("Crop pictures")
	If ($cES_MEDIA#Null:C1517)
		$vL_width_final:=$cE_SETS.width
		$vL_height_final:=$cE_SETS.height
		$vL_image_type:=$cE_SETS.type
		$vL_count:=4
		For each ($cE_MEDIA; $cES_MEDIA)
			If (Not:C34($cE_MEDIA.isLinkedPicture))
				$vO_picture:=$cE_MEDIA.picture
				PICTURE PROPERTIES:C457($vO_picture; $vL_width; $vL_height)
				If (($vL_width+$vL_height)#0)
					$isOk:=False:C215
					Case of 
						: ($vL_image_type=3)
							$is_horizontal:=True:C214
						: ($vL_image_type=4)
							$is_horizontal:=False:C215
						Else 
							$is_horizontal:=($vL_width>$vL_height)
					End case 
					
					If ($is_horizontal)
						$vR_width1:=$vL_width/$vL_count
						$isOk:=($vR_width1=Int:C8($vR_width1))
						If ($isOk)
							TRANSFORM PICTURE:C988($vO_picture; Crop:K61:7; 0; 0; $vR_width1; $vL_height)
							$vL_width_final:=$vR_width1
							$vL_height_final:=$vL_height
							$vL_image_type:=3
						End if 
					Else 
						$vR_height1:=$vL_height/$vL_count
						$isOk:=($vR_height1=Int:C8($vR_height1))
						If ($isOk)
							TRANSFORM PICTURE:C988($vO_picture; Crop:K61:7; 0; 0; $vL_width; $vR_height1)
							$vL_width_final:=$vL_width
							$vL_height_final:=$vR_height1
							$vL_image_type:=4
						End if 
					End if 
					If ($isOk)
						$cE_MEDIA.picture:=$vO_picture
						zen_entity_save($cE_MEDIA)
					End if 
				End if 
			End if 
		End for each 
		If ($cE_SETS#Null:C1517)
			$cE_SETS.type:=$vL_image_type
			$cE_SETS.width:=$vL_width_final
			$cE_SETS.height:=$vL_height_final
			//F_BANK_set_record("set_modified")
			//F_BANK_set_record("display")
			//F_BANK_set_record("btn_validate")
			//f_baq_calculMajShapes
		End if 
	End if 
	// *
	// *****
	