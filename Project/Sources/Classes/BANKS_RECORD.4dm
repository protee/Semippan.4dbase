
property is_touched; is_SETS_touched : Boolean

Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	Super:C1706.record_load_upd()
	Form:C1466.cE_SETS:=Null:C1517
	Form:C1466.cE_MEDIA:=Null:C1517
	This:C1470.al_colorsIdx_set()
	This:C1470.lb_media_redraw()
	SET TIMER:C645(-1)  // Finish the zen_sets job once updated
	This:C1470.is_touched:=False:C215
	This:C1470.is_SETS_touched:=False:C215
	
	
Function record_checkout()->$isOk : Boolean
	var $c4E_entity : 4D:C1709.Entity
	$c4E_entity:=Form:C1466.c4E
	var $vJ_okValidate : Object
	$vJ_okValidate:=zen_okValidate_init
	zen_okValidate_check($vJ_okValidate; ($c4E_entity.label=""); True:C214; "Fill in label!")
	zen_okValidate_check($vJ_okValidate; ($c4E_entity.subPath=""); False:C215; "Fill in subPath!")
	$isOk:=zen_okValidate_checkout($vJ_okValidate)
	
	
Function record_touched($c4E_record : 4D:C1709.Entity)->$is_touched : Boolean
	var $vJ_widget : Object
	var $vT_widget : Text
	$vT_widget:="zen_sets"
	$vJ_widget:=OBJECT Get value:C1743($vT_widget)
	$is_touched:=$vJ_widget.is_touched
	If (Not:C34($is_touched))
		$is_touched:=$c4E_record.touched() || This:C1470.is_SETS_touched
	End if 
	
	
Function do_touched()
	Form:C1466.is_touched:=True:C214
	
	
Function SETS_entity_save()
	var $cE_SETS : cs:C1710.SETSEntity
	var $is_touched : Boolean
	$cE_SETS:=Form:C1466.cE_SETS
	If ($cE_SETS#Null:C1517)
		$is_touched:=$cE_SETS.touched()
		//If (Not($is_touched))
		//$is_touched:=This.is_SETS_touched
		//This.is_SETS_touched:=False
		//End if
		If ($is_touched)
			zen_entity_save($cE_SETS)
		End if 
	End if 
	
	
Function record_save($c4E_entity : 4D:C1709.Entity)
	This:C1470.SETS_entity_save()
	Super:C1706.record_save($c4E_entity)
	// *
	// *****
	
	
	// *****
	// *
Function form_events()
	var $vL_event_code : Integer
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	var $cE_SETS : cs:C1710.SETSEntity
	$vL_event_code:=Form event code:C388
	$vJ_formEvent:=FORM Event:C1606
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Close Box:K2:21)
			This:C1470.zen_record_events("closeBox")
			
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
				: ($vT_objectName="bt_favorites")
					woc_popColorsGrid_palette()
					
				: ($vT_objectName="btn_media_tools")
					This:C1470._media_tools()
					
					//: ($vT_objectName="sets_btn_template")
					//This._sets_from_template()
					
					//: ($vT_objectName="sets_btn_tools")
					//This._sets_tools()
					
				: ($vT_objectName="sets_btn_to")
					This:C1470._sets_to_template()
					
				: ($vT_objectName="sets_btn_from")
					This:C1470._sets_from_template()
					
					//: ($vT_objectName="sets_btn_accept")
					//This.SETS_entity_save()
					
				: ($vT_objectName="sets_btn_cancel")
					$cE_SETS:=Form:C1466.cE_SETS
					If ($cE_SETS#Null:C1517) && (This:C1470.is_SETS_touched)
						If (waz_io_confirm_popup("Undo SETS?"; "delete"))
							$cE_SETS.reload()
							This:C1470._lb_sets_event()
						End if 
					End if 
					
			End case 
			
			
			
			//: ($vL_event_code=On Double Clicked)
			
			//: ($vL_event_code=On Data Change)
			
		: ($vL_event_code=On Timer:K2:25)
			SET TIMER:C645(0)
			If (Form:C1466._is_play)
				Form:C1466._is_play:=False:C215
				This:C1470._do_play()
			Else 
				This:C1470._lb_sets_event()
			End if 
			
	End case 
	// *
	// *****
	
	
Function get_cE_PACKS()->$cE_PACKS : cs:C1710.PACKSEntity
	//var $vJ_zen_packs : Object
	//$vJ_zen_packs:=OBJECT Get value("zen_packs")
	//$cE_PACKS:=$vJ_zen_packs.c4E  // Get true parent
	$cE_PACKS:=zen_linked_related_one("BANKS_PACKS")
	
	
Function al_colorsIdx_set()
	var $cE_PACKS : cs:C1710.PACKSEntity
	var $vJ_woc_alColorsIdx; $vJ_zen_sets; $vJ_DTO : Object
	var $vL_colors_in : Integer
	$cE_PACKS:=This:C1470.get_cE_PACKS()
	If ($cE_PACKS#Null:C1517)
		$vJ_woc_alColorsIdx:=OBJECT Get value:C1743("woc_alColorsIdx")
		$vJ_woc_alColorsIdx.j_alColors:=$cE_PACKS.j_alColors
		$vJ_woc_alColorsIdx.redraw()
		
		$vL_colors_in:=$vJ_woc_alColorsIdx.l_colors
		$vJ_zen_sets:=OBJECT Get value:C1743("zen_sets")
		//$vL_colors_in:=This._get_alColorsIdx()
		$vJ_DTO:=$vJ_zen_sets.j_DTO
		$vJ_DTO.l_colors_in:=$vL_colors_in
		$vJ_zen_sets.is_first:=True:C214  // Selection of the fist line
		$vJ_zen_sets.redraw()
	End if 
	
	
Function _alColorsIdx_event($vJ_widget : Object)
	This:C1470.SETS_entity_save()
	This:C1470.al_colorsIdx_set()
	This:C1470.lb_media_redraw()
	SET TIMER:C645(-1)  // Finish the zen_sets job once updated
	
	
Function _get_alColorsIdx()->$vL_colors_in : Integer
	var $cE_BANKS : cs:C1710.BANKSEntity
	var $cE_PACKS : cs:C1710.PACKSEntity
	$cE_BANKS:=Form:C1466.c4E
	$cE_PACKS:=This:C1470.get_cE_PACKS()
	$vL_colors_in:=$cE_PACKS#Null:C1517 ? woc_sp_colors_from_alColorsIdx($cE_PACKS.j_alColors; $cE_BANKS.colorsIdx) : 0
	Form:C1466.l_colors_in:=$vL_colors_in
	
	
	// *****
	// *
Function _get_colors1($cE_SETS : cs:C1710.SETSEntity)->$vC_al_colors1 : Collection
	var $is_btn : Boolean
	var $cE_TEMPLATES : cs:C1710.TEMPLATESEntity
	var $vJ_dcox : Object
	var $vL_colors_in : Integer
	
	$vL_colors_in:=Form:C1466.l_colors_in
	
	$is_btn:=$cE_SETS.type>0
	$cE_TEMPLATES:=$cE_SETS.SETS_TEMPLATES
	$vJ_dcox:=$cE_TEMPLATES.j_dcox
	$vC_al_colors1:=woc_dcox_al_colors_init($vJ_dcox; $is_btn; $vL_colors_in)
	Form:C1466.al_colors1:=$vC_al_colors1
	
	
Function _get_colors($cE_SETS : cs:C1710.SETSEntity; $vC_al_colors_in : Collection)->$vC_al_colors : Collection
	var $vJ_dcox : Object
	
	$vC_al_colors_in:=$vC_al_colors_in#Null:C1517 ? $vC_al_colors_in : Form:C1466.al_colors1
	$vJ_dcox:=$cE_SETS.j_dcox
	$vC_al_colors:=woc_dcox_al_colors_get($vJ_dcox; $vC_al_colors_in)
	Form:C1466.al_colors:=$vC_al_colors
	// *
	// *****
	
	
	
	// *****
	// *
Function _lb_sets_c4E($vJ_zen_sets : Object)->$cE_SETS : cs:C1710.SETSEntity
	var $vJ_zen_media; $vJ_DTO : Object
	var $vL_colors_in : Integer
	$vJ_zen_sets:=$vJ_zen_sets#Null:C1517 ? $vJ_zen_sets : OBJECT Get value:C1743("zen_sets")
	$cE_SETS:=$vJ_zen_sets.lb_current
	Form:C1466.cE_SETS:=$cE_SETS
	$vJ_zen_media:=OBJECT Get value:C1743("zen_media")
	$vJ_DTO:=$vJ_zen_media.j_DTO
	$vL_colors_in:=This:C1470._get_alColorsIdx()
	$vJ_DTO.l_colors_in:=$vL_colors_in
	$vJ_DTO.cE_SETS:=$cE_SETS
	
	
Function _lb_sets_event($vJ_zen_sets : Object; $vL_event : Integer)
	var $is_selected; $is_editing : Boolean
	var $cE_SETS : cs:C1710.SETSEntity
	var $vJ_widget; $vJ_isActive : Object
	var $vT_decox : Text
	var $vC_al_colors1; $vC_al_colors : Collection
	
	//$vJ_zen_sets:=$vJ_zen_sets#Null ? $vJ_zen_sets : OBJECT Get value("zen_sets")
	//$vL_colors_in:=This._get_alColorsIdx()
	//$vJ_DTO:=$vJ_zen_sets.j_DTO
	////$cE_BANKS:=Form.c4E
	////$cE_PACKS:=This.get_cE_PACKS()
	////$vL_colors_in:=woc_sp_colors_from_alColorsIdx($cE_PACKS.j_alColors; $cE_BANKS.colorsIdx)
	//$vJ_DTO.l_colors_in:=$vL_colors_in
	////$vJ_zen_sets.redraw()
	
	This:C1470.SETS_entity_save()
	$cE_SETS:=This:C1470._lb_sets_c4E($vJ_zen_sets)
	$is_selected:=$cE_SETS#Null:C1517
	OBJECT SET ENABLED:C1123(*; "bt_play"; $is_selected)
	OBJECT SET VISIBLE:C603(*; "sets_@"; $is_selected)
	$is_editing:=Form:C1466.is_editing
	If ($is_selected)
		OBJECT SET ENABLED:C1123(*; "sets_btn_@"; $is_editing)
		
		$vJ_isActive:=OBJECT Get value:C1743("sets_banner")
		x_io_banner_sets($cE_SETS; $vJ_isActive)
		
		$vJ_widget:=OBJECT Get value:C1743("sets_output")
		$vJ_widget.is_editing:=$is_editing
		$vJ_widget.j_value:=$cE_SETS
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		$vJ_widget:=OBJECT Get value:C1743("sets_options")
		$vJ_widget.is_editing:=$is_editing
		$vJ_widget.j_value:=$cE_SETS.j_options
		$vJ_widget.redraw()
		
		$vJ_widget:=OBJECT Get value:C1743("sets_metarect")
		$vJ_widget.is_editing:=$is_editing
		$vJ_widget.j_value:=$cE_SETS.j_metarect
		$vJ_widget.redraw()
		
		$vJ_widget:=OBJECT Get value:C1743("sets_picture")
		$vJ_widget.is_editing:=$is_editing
		$vJ_widget.j_value:=$cE_SETS.j_picture
		$vJ_widget.redraw()
		
		$vJ_widget:=OBJECT Get value:C1743("sets_text")
		$vJ_widget.is_editing:=$is_editing
		$vJ_widget.j_value:=$cE_SETS.j_text
		$vJ_widget.redraw()
		
		$vJ_widget:=OBJECT Get value:C1743("sets_templates")
		$vJ_widget.UID:=$cE_SETS.UIDtemplate
		//$vJ_widget.bind_to_c4E("UIDtemplate")
		$vJ_widget.redraw()
		
		$vC_al_colors1:=This:C1470._get_colors1($cE_SETS)
		This:C1470.redraw_colors1($vC_al_colors1)
		
		$vJ_widget:=OBJECT Get value:C1743("sets_dcox")
		$vJ_widget.al_in:=$vC_al_colors1
		$vJ_widget.is_editing:=$is_editing
		$vJ_widget.j_value:=$cE_SETS.j_dcox
		$vJ_widget.resize($vT_decox)
		$vJ_widget.redraw()
		
		$vC_al_colors:=This:C1470._get_colors($cE_SETS; $vC_al_colors1)
		This:C1470.redraw_colors($vC_al_colors)
		This:C1470.redraw_pict_dcox()
		This:C1470.lb_media_refresh($cE_SETS)
	End if 
	
	
Function _template_chgt($vJ_zen_templates : Object)
	var $vC_al_colors1; $vC_al_colors : Collection
	var $cE_SETS : cs:C1710.SETSEntity
	var $vJ_widget : Object
	$cE_SETS:=This:C1470._lb_sets_c4E()
	$cE_SETS.UIDtemplate:=$vJ_zen_templates.UID
	This:C1470.is_SETS_touched:=True:C214
	
	$vC_al_colors1:=This:C1470._get_colors1($cE_SETS)
	$vJ_widget:=OBJECT Get value:C1743("sets_dcox")
	$vJ_widget.al_in:=$vC_al_colors1
	$vJ_widget.redraw()
	This:C1470.redraw_colors1($vC_al_colors1)
	$vC_al_colors:=This:C1470._get_colors($cE_SETS; $vC_al_colors1)
	This:C1470.redraw_colors($vC_al_colors)
	This:C1470.redraw_pict_dcox()
	This:C1470.lb_media_refresh($cE_SETS)
	
	
Function redraw_colors1($vC_al_colors1 : Collection)
	var $vC_at_bind : Collection
	var $idx; $tt : Integer
	var $vJ_widget : Object
	var $vT_bind; $vT_widget : Text
	var $is_visible : Boolean
	
	$vC_al_colors1:=$vC_al_colors1#Null:C1517 ? $vC_al_colors1 : Form:C1466.al_colors
	$tt:=$vC_al_colors1.length
	$vC_at_bind:=woc_dcox_at_get()
	$idx:=0
	For each ($vT_bind; $vC_at_bind)
		$vT_widget:="sets_"+$vT_bind+"1"
		$is_visible:=$idx<$tt
		OBJECT SET VISIBLE:C603(*; $vT_widget; $is_visible)
		If ($is_visible)
			$vJ_widget:=OBJECT Get value:C1743($vT_widget)
			$vJ_widget.is_editing:=False:C215
			$vJ_widget.l_colors:=$vC_al_colors1[$idx]
			$vJ_widget.redraw()
		End if 
		$idx+=1
	End for each 
	// *
	// *****
	
	
	
Function _order_chgt()
	var $cE_SETS : cs:C1710.SETSEntity
	$cE_SETS:=Form:C1466.cE_SETS
	This:C1470.lb_media_refresh($cE_SETS)
	
	
Function _sets_chgt()
	var $cE_SETS : cs:C1710.SETSEntity
	This:C1470.is_SETS_touched:=True:C214
	$cE_SETS:=Form:C1466.cE_SETS
	This:C1470._get_colors1($cE_SETS)
	This:C1470._get_colors($cE_SETS)
	This:C1470.redraw_pict_dcox($cE_SETS)
	This:C1470.lb_media_refresh($cE_SETS)
	
	
Function _sets_dcox_chgt()
	var $cE_SETS : cs:C1710.SETSEntity
	var $vC_al_colors : Collection
	This:C1470.is_SETS_touched:=True:C214
	$cE_SETS:=Form:C1466.cE_SETS
	$vC_al_colors:=This:C1470._get_colors($cE_SETS)
	This:C1470.redraw_colors($vC_al_colors)
	This:C1470.redraw_pict_dcox($cE_SETS)
	This:C1470.lb_media_refresh($cE_SETS)
	// *
	// *****
	
	
	
	// *****
	// *
Function redraw_colors($vC_al_colors : Collection)
	var $vC_at_bind : Collection
	var $idx; $tt : Integer
	var $vJ_widget : Object
	var $vT_bind; $vT_widget : Text
	var $is_visible : Boolean
	
	$vC_al_colors:=$vC_al_colors#Null:C1517 ? $vC_al_colors : Form:C1466.al_colors
	$tt:=$vC_al_colors.length
	$vC_at_bind:=woc_dcox_at_get()
	$idx:=0
	For each ($vT_bind; $vC_at_bind)
		$vT_widget:="sets_"+$vT_bind
		$is_visible:=$idx<$tt
		OBJECT SET VISIBLE:C603(*; $vT_widget; $is_visible)
		If ($is_visible)
			$vJ_widget:=OBJECT Get value:C1743($vT_widget)
			$vJ_widget.is_editing:=False:C215
			$vJ_widget.l_colors:=$vC_al_colors[$idx]
			$vJ_widget.redraw()
		End if 
		$idx+=1
	End for each 
	
	
Function lb_media_redraw()
	var $vJ_widget : Object
	$vJ_widget:=OBJECT Get value:C1743("zen_media")
	$vJ_widget.redraw()
	
	
Function lb_media_refresh($cE_SETS : cs:C1710.SETSEntity)
	var $vJ_DTO; $vJ_zen_media : Object
	var $cE_BANKS : cs:C1710.BANKSEntity
	$vJ_zen_media:=OBJECT Get value:C1743("zen_media")
	$vJ_DTO:=$vJ_zen_media.j_DTO
	$vJ_DTO.cE_SETS:=$cE_SETS
	$cE_BANKS:=Form:C1466.c4E
	$vJ_DTO.l_orderMode:=$cE_BANKS.orderMode
	$vJ_DTO.l_orderOffset:=$cE_BANKS.orderOffset
	$vJ_zen_media.refresh()
	
	
Function _lb_media_event($vJ_widget : Object; $vL_event_code : Integer)
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	$cE_MEDIA:=$vJ_widget.lb_current
	If ($cE_MEDIA#Null:C1517)
		$cE_MEDIA.reload()
	End if 
	Form:C1466.cE_MEDIA:=$cE_MEDIA
	This:C1470.redraw_pict_dcox()
	
	
Function redraw_pict_dcox($cE_SETS : cs:C1710.SETSEntity)
	var $is_visible; $is_grey_scale; $is_img_offset; $is_MEDIA; $is_set_colors : Boolean
	var $vC_at_bind; $vC_al_colors : Collection
	var $idx; $vL_colors_out; $vL_brightness; $tt : Integer
	var $vJ_picture; $vJ_widget; $vJ_dcox : Object
	var $vO_picture; $vO_img_picture : Picture
	var $vT_bind; $vT_widget : Text
	var $cE_TEMPLATES : cs:C1710.TEMPLATESEntity
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	
	$cE_SETS:=$cE_SETS#Null:C1517 ? $cE_SETS : Form:C1466.cE_SETS
	If ($cE_SETS#Null:C1517)
		$cE_MEDIA:=Form:C1466.cE_MEDIA
		$is_MEDIA:=($cE_MEDIA#Null:C1517)  // COMMON
		$is_set_colors:=$cE_SETS.j_options.isSetColors
		$vJ_picture:=$cE_SETS.j_picture
		$vC_al_colors:=Form:C1466.al_colors
		If ($is_MEDIA) && Not:C34($is_set_colors)
			$cE_TEMPLATES:=$cE_MEDIA.MEDIA_TEMPLATES
			If ($cE_TEMPLATES#Null:C1517)
				$vJ_dcox:=$cE_TEMPLATES.j_dcox
				$vC_al_colors:=woc_dcox_al_colors_get($vJ_dcox; $vC_al_colors)
			End if 
			$vJ_dcox:=$cE_MEDIA.j_dcox
			$vC_al_colors:=woc_dcox_al_colors_get($vJ_dcox; $vC_al_colors)
		End if 
		
		$vO_img_picture:=$cE_MEDIA.isLinkedPicture ? $cE_MEDIA.MEDIA_PICTURES.picture : $cE_MEDIA.picture
		
		// DCOX -> separated, or H | V, for LB or output
		$tt:=$vC_al_colors.length
		$vC_at_bind:=woc_dcox_at_get()
		$idx:=0
		For each ($vT_bind; $vC_at_bind)
			$vT_widget:="sets_picture_"+$vT_bind
			$is_visible:=$idx<$tt
			OBJECT SET VISIBLE:C603(*; $vT_widget; $is_visible)
			If ($is_visible)
				$vL_colors_out:=$vC_al_colors[$idx]
				$vL_brightness:=$vJ_picture["l_br_"+$vT_bind]
				$is_grey_scale:=($idx=3) && $vJ_picture.is_greyDisabled
				$is_img_offset:=($idx=1) && $vJ_picture.is_offsetClick
				$vO_picture:=sem_img_calculate($cE_SETS; $cE_MEDIA; $vO_img_picture; $vL_colors_out; $vL_brightness; $is_grey_scale; $is_img_offset)
				
				// OUTPUT
				$vJ_widget:=OBJECT Get value:C1743($vT_widget)
				$vJ_widget.is_editing:=False:C215
				$vJ_widget.r_coef:=-1
				$vJ_widget.o_picture:=$vO_picture
				$vJ_widget.redraw()
			End if 
			$idx+=1
		End for each 
	End if 
	
	
	
	// *****
	// *
Function _menuBtn_chgt($vJ_widget : Object)
	This:C1470.do_touched()
	
	
Function _menuBtn_click($vJ_widget : Object)
	var $cs_BANKS_TOOLS : cs:C1710.BANKS_TOOLS
	var $cE_BANKS : cs:C1710.BANKSEntity
	var $cE_SETS : cs:C1710.SETSEntity
	var $vJ_zen_media : Object
	var $vT_click : Text
	var $cE_PACKS : cs:C1710.PACKSEntity
	$vT_click:=$vJ_widget.t_value
	Case of 
		: ($vT_click="create")
			
		: ($vT_click="code")
			$cE_PACKS:=This:C1470.get_cE_PACKS()
			$cE_BANKS:=Form:C1466.c4E
			$cE_SETS:=Form:C1466.cE_SETS
			$vJ_zen_media:=OBJECT Get value:C1743("zen_media")
			$cs_BANKS_TOOLS:=cs:C1710.BANKS_TOOLS.new($cE_PACKS; $cE_BANKS; $cE_SETS; $vJ_zen_MEDIA)
			$cs_BANKS_TOOLS._export_menuBtn()
			
			//$cES_MEDIA:=$vJ_zen_media.lb_selection
			//If ($cES_MEDIA.length#0)
			//$cs_BANKS_menuBtn_code:=cs.BANKS_menuBtn_code.new()
			//$cE_BANKS:=Form.c4E
			//$cE_SETS:=Form.cE_SETS
			//$cs_BANKS_menuBtn_code._export_menuBtn($cE_BANKS; $cE_SETS; $cES_MEDIA)
			//Else
			//cs.wox.TUNES.me.play_beep()
			//End if
	End case 
	
	
Function _btn_create()
	
	
Function _media_tools()
	var $cs_BANKS_TOOLS : cs:C1710.BANKS_TOOLS
	var $cE_BANKS : cs:C1710.BANKSEntity
	var $cE_SETS : cs:C1710.SETSEntity
	var $vJ_zen_media : Object
	var $cE_PACKS : cs:C1710.PACKSEntity
	$cE_PACKS:=This:C1470.get_cE_PACKS()
	$cE_BANKS:=Form:C1466.c4E
	$cE_SETS:=Form:C1466.cE_SETS
	$vJ_zen_media:=OBJECT Get value:C1743("zen_media")
	$cs_BANKS_TOOLS:=cs:C1710.BANKS_TOOLS.new($cE_PACKS; $cE_BANKS; $cE_SETS; $vJ_zen_MEDIA)
	$cs_BANKS_TOOLS.do_choose_menu()
	
	
Function _sets_tools()
	var $isOk : Boolean
	var $vC_menu_lbl : Collection
	var $idx : Integer
	var $vT_refMenu; $vT_label; $vT_answer : Text
	$vC_menu_lbl:=New collection:C1472()
	$vC_menu_lbl.push("dcox from Template…")
	$vC_menu_lbl.push("dcox to Template")
	$vT_refMenu:=Create menu:C408()
	$idx:=0
	For each ($vT_label; $vC_menu_lbl)
		APPEND MENU ITEM:C411($vT_refMenu; $vT_label; *)
		SET MENU ITEM PARAMETER:C1004($vT_refMenu; -1; String:C10($idx))
		//SET MENU ITEM ICON($vT_refMenu; -1; $vT_path_icon+String($idx)+k_png_ext)
		$idx+=1
	End for each 
	
	$vT_answer:=Dynamic pop up menu:C1006($vT_refMenu)
	RELEASE MENU:C978($vT_refMenu)
	$isOk:=($vT_answer#"")
	If ($isOk)
		//$cES_MEDIA:=This._get_selected(True)
		Case of 
			: ($vT_answer="0")
				This:C1470._sets_from_template()
				
			: ($vT_answer="1")
				This:C1470._sets_to_template()
		End case 
	End if 
	
	
Function _sets_to_template()
	var $c4DC_templates : 4D:C1709.DataClass
	var $cE_SETS : cs:C1710.SETSEntity
	var $cE_templates : cs:C1710.TEMPLATESEntity
	var $vT_name : Text
	var $cE_BANKS : cs:C1710.BANKSEntity
	$vT_name:=waz_io_request(""; "Template's name ?")
	If ($vT_name#"")
		$c4DC_templates:=ds:C1482.TEMPLATES
		$cE_BANKS:=Form:C1466.c4E
		$cE_SETS:=Form:C1466.cE_SETS
		$cE_templates:=zen_entity_new($c4DC_templates)
		$cE_SETS.UIDtemplate:=$cE_templates.UID
		$cE_templates.isActive:=True:C214
		$cE_templates.label:=$vT_name
		$cE_templates.UIDpack:=$cE_BANKS.UIDpack
		$cE_templates.shape:=$cE_SETS.shape
		$cE_templates.stroke:=$cE_SETS.stroke
		$cE_templates.j_dcox:=$cE_SETS.j_dcox
		zen_entity_save($cE_templates)
		This:C1470.is_SETS_touched:=True:C214
		This:C1470._lb_sets_event()  // Redraw
	End if 
	
	
Function _sets_from_template()
	var $isOk : Boolean
	var $cE_SETS : cs:C1710.SETSEntity
	var $cE_templates : cs:C1710.TEMPLATESEntity
	var $vT_table : Text
	var $vC_al_colors1; $vC_al_colors : Collection
	var $vJ_widget : Object
	var $vV_UID : Variant
	$vJ_widget:=OBJECT Get value:C1743("sets_templates")
	$vV_UID:=$cE_SETS.UIDtemplate
	$isOk:=($vV_UID#Null:C1517) && Not:C34(Macintosh command down:C546)
	If ($isOk)
		$isOk:=waz_io_confirm_popup("dcox from current template?")
	Else 
		$vT_table:="TEMPLATES"
		$vV_UID:=zen_table_picker_one($vT_table)
		$isOk:=zen_UID_isOk($vV_UID)
	End if 
	If ($isOk)
		$cE_templates:=ds:C1482.TEMPLATES.get($vV_UID)
		$cE_SETS:=Form:C1466.cE_SETS
		//$cE_SETS.j_dcox:=$cE_templates.j_dcox // NOP ! As ref chgt not allowed
		This:C1470.is_SETS_touched:=True:C214
		wox_vJ_overloads($cE_templates.j_dcox; $cE_SETS.j_dcox)
		$vC_al_colors1:=Form:C1466.al_colors1
		$vJ_widget:=OBJECT Get value:C1743("sets_dcox")
		$vJ_widget.al_in:=$vC_al_colors1
		$vJ_widget.redraw()
		This:C1470.redraw_colors1($vC_al_colors1)
		$vC_al_colors:=This:C1470._get_colors($cE_SETS; $vC_al_colors1)
		This:C1470.redraw_colors($vC_al_colors)
		This:C1470.redraw_pict_dcox()
		This:C1470.lb_media_refresh($cE_SETS)
	End if 
	
	
Function _do_play()
	var $is_delete : Boolean
	var $cES_PATHS : cs:C1710.PATHSSelection
	var $cs_SEMIPPAN_PLAY : cs:C1710.SEMIPPAN_PLAY
	var $vJ_zen_PATHS; $vJ_zen_SETS; $vJ_zen_MEDIA; $vJ_is_delete : Object
	var $cE_BANKS : cs:C1710.BANKSEntity
	var $cES_MEDIA : cs:C1710.MEDIASelection
	var $cES_SETS : cs:C1710.SETSSelection
	var $cE_PACKS : cs:C1710.PACKSEntity
	
	This:C1470.SETS_entity_save()  // Save to get the proper entity
	
	$vJ_zen_PATHS:=Form:C1466.j_DTO.j_PATHS
	$cES_PATHS:=$vJ_zen_PATHS.lb_selected
	$cES_PATHS:=($cES_PATHS.length>0) ? $cES_PATHS : $vJ_zen_PATHS.lb_selection.query("isActive = true")  // Takes all active
	
	$cE_PACKS:=This:C1470.get_cE_PACKS()
	$cE_BANKS:=Form:C1466.c4E
	$vJ_zen_SETS:=OBJECT Get value:C1743("zen_SETS")
	$cES_SETS:=$vJ_zen_SETS.lb_selected
	$cES_SETS:=($cES_SETS.length>0) ? $cES_SETS : $vJ_zen_SETS.lb_selection.query("isActive = true")  // Takes all active
	
	$vJ_zen_MEDIA:=OBJECT Get value:C1743("zen_MEDIA")
	$cES_MEDIA:=$vJ_zen_MEDIA.lb_selected
	$cES_MEDIA:=($cES_MEDIA.length>0) ? $cES_MEDIA : $vJ_zen_MEDIA.lb_selection.query("isActive = true")  // Takes all active
	
	$vJ_is_delete:=OBJECT Get value:C1743("waz_is_delete")
	$is_delete:=$vJ_is_delete.v_value
	$vJ_is_delete.v_value:=False:C215
	$vJ_is_delete.redraw()
	
	$cs_SEMIPPAN_PLAY:=cs:C1710.SEMIPPAN_PLAY.new()
	$cs_SEMIPPAN_PLAY.do_BANK_PLAY($cES_PATHS; $cE_PACKS; $cE_BANKS; $cES_SETS; $cES_MEDIA; $is_delete)
	// *
	// *****
	
	