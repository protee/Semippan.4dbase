
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	Super:C1706.record_load_upd()
	This:C1470._lb_PATHS_event()
	This:C1470._lb_banks_event()
	
	
Function record_checkout()->$isOk : Boolean
	var $c4E_entity : 4D:C1709.Entity
	$c4E_entity:=Form:C1466.c4E
	var $vJ_okValidate : Object
	$vJ_okValidate:=zen_okValidate_init
	zen_okValidate_check($vJ_okValidate; ($c4E_entity.label=""); True:C214; "Fill in label!")
	$isOk:=zen_okValidate_checkout($vJ_okValidate)
	
	
Function record_touched($c4E_record : 4D:C1709.Entity)->$is_touched : Boolean
	//$vT_widget:="zen_speeches"
	//$vJ_widget:=OBJECT Get value($vT_widget)
	//$is_touched:=$vJ_widget.is_touched
	//If (Not($is_touched))
	$is_touched:=$c4E_record.touched()
	//End if
	
	
Function do_touched()
	Form:C1466.is_touched:=True:C214
	
	
	//Function record_save($c4E_entity : 4D.Entity)
	//Super.record_save($c4E_entity)
	
	// *
	// *****
	
	
	// *****
	// *
Function form_events()
	var $vL_event_code : Integer
	$vL_event_code:=Form event code:C388
	
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	$vJ_formEvent:=FORM Event:C1606
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Close Box:K2:21)
			This:C1470.zen_record_events("closeBox")
			
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
				: ($vT_objectName="btn_adds")
					This:C1470._do_add_products()
					
				: ($vT_objectName="bt_template")
					This:C1470._do_link_template()
					
					
					//: ($vT_objectName="bt_play")
					//This._do_play()
					
					
				: ($vT_objectName="field_logo")
					If (Right click:C712) && (Form:C1466.is_editing)
						This:C1470._btn_logo()
					End if 
					
			End case 
			
		: ($vL_event_code=On Timer:K2:25)
			SET TIMER:C645(0)
			If (Form:C1466._is_play)
				Form:C1466._is_play:=False:C215
				This:C1470._do_play()
			End if 
			
			//: ($vL_event_code=On Double Clicked)
			
			//: ($vL_event_code=On Data Change)
			
			//: ($vL_event_code=On Double Clicked)
			
	End case 
	// *
	// *****
	
	
	
	
	// *****
	// *
Function _do_add_products()
	var $c4ES_selection; $c4ES_selected : 4D:C1709.EntitySelection
	var $isOk : Boolean
	var $vJ_PATHS; $vJ_params : Object
	var $vL_colors; $vL_order : Integer
	var $vT_UID : Text
	var $c4DC_PATHS : 4D:C1709.DataClass
	var $cE_PATHS : cs:C1710.PATHSEntity
	var $cES_PATHS : cs:C1710.PATHSSelection
	var $cE_products : cs:C1710.PRODUCTSEntity
	var $cES_products : cs:C1710.PRODUCTSSelection
	
	$vJ_PATHS:=OBJECT Get value:C1743("zen_PATHS")
	$vJ_params:=New object:C1471()
	$vJ_params.t_table:="PRODUCTS"
	$vJ_params.is_multiple:=True:C214
	$vJ_params.t_label:="label"
	//$c4Fu_orwells:=Formula(This.yinTongue+" • "+This.yangTongue)
	//$vJ_params.fu_value:=$c4Fu_orwells
	
	$cES_PATHS:=$vJ_PATHS.lb_selection
	$cES_products:=$cES_PATHS.PATHS_PRODUCTS
	$c4ES_selection:=ds:C1482.PRODUCTS.all().minus($cES_products)
	$vJ_params.c4ES_selection:=$c4ES_selection
	$isOk:=zen_c4ES_form($vJ_params)
	If ($isOk)
		// Add records
		$c4DC_PATHS:=ds:C1482.PATHS
		$vT_UID:=Form:C1466.c4E.UID
		$vL_order:=$cES_PATHS.length
		$vL_colors:=0
		$c4ES_selected:=$vJ_params.c4ES
		For each ($cE_products; $c4ES_selected)
			$cE_PATHS:=zen_entity_new($c4DC_PATHS)
			$cE_PATHS.UIDproduct:=$cE_products.UID
			$cE_PATHS.UIDpack:=$vT_UID
			$cE_PATHS.isActive:=True:C214
			zen_entity_save($cE_PATHS)
			$vL_order+=1
		End for each 
		// Reorder
		//$vJ_PATHS.do_reorder()
		$vJ_PATHS.redraw()
	End if 
	
	
	// *****
	// *
Function _lb_PATHS_event($vJ_zen_PATHS : Object; $vL_event : Integer)
	var $is_selected : Boolean
	var $cE_PATHS : cs:C1710.PATHSEntity
	$vJ_zen_PATHS:=$vJ_zen_PATHS#Null:C1517 ? $vJ_zen_PATHS : OBJECT Get value:C1743("zen_PATHS")
	$cE_PATHS:=This:C1470._lb_PATHS_c4E($vJ_zen_PATHS)
	$is_selected:=$cE_PATHS#Null:C1517
	//OBJECT SET ENABLED(*; "bt_play"; $is_selected)
	
	
Function _lb_PATHS_c4E($vJ_zen_PATHS : Object)->$cE_PATHS : cs:C1710.PATHSEntity
	var $vJ_zen_banks : Object
	$vJ_zen_banks:=OBJECT Get value:C1743("zen_banks")
	$cE_PATHS:=$vJ_zen_PATHS.lb_current
	//Form.cE_PATHS:=$cE_PATHS
	//$vJ_zen_banks.j_DTO.cE_PATHS:=$cE_PATHS
	$vJ_zen_banks.j_DTO.j_PATHS:=$vJ_zen_PATHS
	
	
Function _lb_PATHS_c4ES($is_all : Boolean)->$cES_PATHS : cs:C1710.PATHSSelection
	var $vT_zen_PATHS : Text
	var $vJ_zen_PATHS : Object
	$vT_zen_PATHS:="zen_PATHS"
	$vJ_zen_PATHS:=OBJECT Get value:C1743($vT_zen_PATHS)
	$cES_PATHS:=$vJ_zen_PATHS.lb_selected
	If ($is_all && (($cES_PATHS=Null:C1517) || ($cES_PATHS.length=0)))
		$cES_PATHS:=$vJ_zen_PATHS.lb_selection
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function _lb_banks_event($vJ_zen_banks : Object; $vL_event_code : Integer)
	var $cE_BANKS : cs:C1710.BANKSEntity
	var $cES_SETS : cs:C1710.SETSSelection
	var $vJ_zen_sets; $vJ_this; $vJ_params : Object
	var $cE_sets : cs:C1710.SETSEntity
	var $isOk; $is_BANKS : Boolean
	var $cE_PACKS : cs:C1710.PACKSEntity
	var $vV_UID : Variant
	var $vT_zen_sets : Text
	$vJ_zen_banks:=$vJ_zen_banks#Null:C1517 ? $vJ_zen_banks : OBJECT Get value:C1743("zen_banks")
	$cE_BANKS:=$vJ_zen_banks.lb_current
	If ($vL_event_code=-On Selection Change:K2:29)
		$is_BANKS:=$cE_BANKS#Null:C1517
		$cES_SETS:=$is_BANKS ? $cE_BANKS.BANKS_SETS : ds:C1482.SETS.newSelection()
		$vT_zen_sets:="zen_sets"
		OBJECT SET VISIBLE:C603(*; $vT_zen_sets; $is_BANKS)
		$vJ_zen_sets:=OBJECT Get value:C1743($vT_zen_sets)
		$vJ_zen_sets.c4ES_selection:=$cES_SETS
		$vJ_this:=This:C1470
		//$c4Fu_sets:=Formula(This.fileStart+" • "+This.subPath+" / "+String(This.type))
		//$vJ_zen_sets.fu_value:=$c4Fu_sets
		$cE_sets:=$cES_SETS.orderBy("fileStart").first()
		//$vJ_zen_sets.UID:=$cE_sets#Null ? $cE_sets.UID : ""
		$vJ_zen_sets.UID:=$cE_sets.UID
		$vJ_zen_sets.fu_value:=Formula:C1597($vJ_this._sets_fu_value(This:C1470))
		$vJ_zen_sets.redraw()
	End if 
	This:C1470._media_redraw()
	
	If ($vL_event_code=-On Clicked:K2:4) && (Right click:C712)
		If ($cE_BANKS#Null:C1517)
			//wox_vJ_overload($vJ_params; $vJ_widget; "t_table"; ""; "is_idle"; "fu_value"; ""; "t_key"; ""; "is_editing")
			//wox_vJ_overload($vJ_params; $vJ_widget; "UID"; "c4E"; "c4ES"; "c4ES_selection")
			$vJ_params:=New object:C1471()
			$vJ_params.t_table:="PACKS"
			$vJ_params.is_multiple:=False:C215
			$vJ_params.t_label:="label"
			$vJ_params.t_colors:="colors"
			$vJ_params.c4ES_selection:=zen__ds().PACKS.all()
			$isOk:=zen_c4ES_form($vJ_params)
			If ($isOk)
				$vV_UID:=$vJ_params.UID
				$cE_PACKS:=zen__ds().PACKS.get($vV_UID)
				$isOk:=waz_io_confirm_popup("Move to Pack \""+$cE_PACKS.label+"\" ?")
				If ($isOk)
					$cE_BANKS.UIDpack:=$vV_UID
					zen_entity_save($cE_BANKS)
					$vJ_zen_banks.resize()
					$vJ_zen_banks.redraw()
				End if 
			End if 
		End if 
	End if 
	
	
Function _sets_fu_value($vJ_this : Object)->$vT_value : Text
	var $vJ_menu : Object
	var $vT_type : Text
	$vT_value:=$vJ_this.fileStart+" • "+$vJ_this.subPath
	$vJ_menu:=zen__storage_menuBtns().m_outputType
	$vT_type:=$vJ_menu.at_lbl[$vJ_this.type]
	$vT_value+=" ("+$vT_type+", "+String:C10($vJ_this.width)+"×"+String:C10($vJ_this.height)+")"
	// *
	// *****
	
	
Function _lb_sets_event($vJ_zen_sets : Object; $vL_event_code : Integer)
	$vJ_zen_sets:=$vJ_zen_sets#Null:C1517 ? $vJ_zen_sets : OBJECT Get value:C1743("zen_sets")
	This:C1470._media_refresh()
	
	
Function _media_redraw()
	var $cE_BANKS : cs:C1710.BANKSEntity
	var $vJ_zen_banks; $vJ_zen_media : Object
	var $vV_UID : Variant
	$vJ_zen_media:=OBJECT Get value:C1743("zen_media")
	$vJ_zen_banks:=OBJECT Get value:C1743("zen_banks")
	//$vJ_zen_sets:=OBJECT Get valGnanam:Users:oleeku:Desktop:Command.jpgue("zen_sets")
	$cE_BANKS:=$vJ_zen_banks.lb_current
	//$cE_SETS:=$vJ_zen_sets.c4E
	//$cES_MEDIA ($cE_BANKS#Null)?$cE_BANKS.BANKS_MEDIAS:ds.MEDIA.newSelection()
	//$vJ_zen_media.c4ES:=$cES_MEDIA
	//$vT_UID:=($cE_BANKS#Null) ? $cE_BANKS.UID : ""
	$vV_UID:=($cE_BANKS#Null:C1517) ? $cE_BANKS.UID : Null:C1517
	//$vJ_zen_media.cE_SETS:=$cE_SETS
	$vJ_zen_media.UID:=$vV_UID  //$cE_BANKS.UID
	$vJ_zen_media.c4ES:=Null:C1517
	$vJ_zen_media.redraw()
	This:C1470._media_refresh()
	
	
Function _media_refresh()
	var $cE_BANKS : cs:C1710.BANKSEntity
	var $cE_SETS : cs:C1710.SETSEntity
	var $vJ_zen_banks; $vJ_zen_sets; $vJ_DTO; $vJ_zen_media : Object
	var $cE_PACKS : cs:C1710.PACKSEntity
	var $vL_colors_in : Integer
	$vJ_zen_banks:=OBJECT Get value:C1743("zen_banks")
	$vJ_zen_sets:=OBJECT Get value:C1743("zen_sets")
	$cE_BANKS:=$vJ_zen_banks.lb_current
	$cE_SETS:=$vJ_zen_sets.c4E
	If ($cE_SETS#Null:C1517)
		$cE_SETS.reload()
		$vJ_zen_media:=OBJECT Get value:C1743("zen_media")
		$vJ_DTO:=$vJ_zen_media.j_DTO
		$cE_PACKS:=Form:C1466.c4E
		$vL_colors_in:=woc_sp_colors_from_alColorsIdx($cE_PACKS.j_alColors; $cE_BANKS.colorsIdx)
		$vJ_DTO.l_colors_in:=$vL_colors_in
		
		$vJ_DTO.cE_SETS:=$cE_SETS
		$vJ_DTO.l_orderMode:=$cE_BANKS.orderMode
		$vJ_DTO.l_orderOffset:=$cE_BANKS.orderOffset
		$vJ_zen_media.refresh()
	End if 
	
	
	
Function _lb_media_event($vJ_zen_media : Object; $vL_event_code : Integer)
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	$vJ_zen_media:=$vJ_zen_media#Null:C1517 ? $vJ_zen_media : OBJECT Get value:C1743("zen_media")
	$cE_MEDIA:=$vJ_zen_media.lb_current
	
	
	
Function _do_link_template()
	var $cES_MEDIA : cs:C1710.MEDIASelection
	var $cE_TEMPLATES : cs:C1710.TEMPLATESEntity
	var $tt : Integer
	var $vJ_zen_templates; $vJ_zen_media : Object
	var $vT_subtitle; $vT_title; $vT_UID : Text
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	$vJ_zen_templates:=OBJECT Get value:C1743("zen_templates")
	$cE_TEMPLATES:=$vJ_zen_templates.lb_current
	If ($cE_TEMPLATES#Null:C1517)
		$vJ_zen_media:=OBJECT Get value:C1743("zen_media")
		$cES_MEDIA:=$vJ_zen_media.lb_selected
		$tt:=$cES_MEDIA.length
		If ($tt>0)
			$vT_title:="Affect \""+$cE_TEMPLATES.label+"\"…"
			$vT_subtitle:="To "+wox_str_pluralise($tt; "Medium"; "Media")
			If (waz_io_confirm_popup($vT_title; ""; $vT_subtitle))
				$vT_UID:=$cE_TEMPLATES.UID
				For each ($cE_MEDIA; $cES_MEDIA)
					$cE_MEDIA.UIDtemplate:=$vT_UID
					zen_entity_save($cE_MEDIA)
				End for each 
				cs:C1710.wox.TUNES.me.play_done()
				$vJ_zen_media.refresh()
			End if 
		Else 
			waz_io_alert_popup("Select Media!")
		End if 
	Else 
		waz_io_alert_popup("Select one Template!")
	End if 
	// *
	// *****
	
	
	
	// *****
	// *
Function _btn_logo()
	var $c4Fi_avatar : 4D:C1709.File
	var $vO_logo : Picture
	var $cE_PACKS : cs:C1710.PACKSEntity
	$c4Fi_avatar:=waz_avatars_choose()
	If ($c4Fi_avatar#Null:C1517)
		READ PICTURE FILE:C678($c4Fi_avatar.platformPath; $vO_logo)
		$cE_PACKS:=Form:C1466.c4E
		$cE_PACKS.logo:=$vO_logo
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function _do_play()
	var $is_delete : Boolean
	var $cES_BANKS : cs:C1710.BANKSSelection
	var $cES_PATHS : cs:C1710.PATHSSelection
	var $cs_SEMIPPAN_PLAY : cs:C1710.SEMIPPAN_PLAY
	var $vJ_zen_PATHS; $vJ_zen_banks; $vJ_is_delete : Object
	var $cE_PACKS : cs:C1710.PACKSEntity
	
	$cE_PACKS:=Form:C1466.c4E
	$vJ_zen_PATHS:=OBJECT Get value:C1743("zen_PATHS")
	$cES_PATHS:=$vJ_zen_PATHS.lb_selected
	$cES_PATHS:=($cES_PATHS.length>0) ? $cES_PATHS : $vJ_zen_PATHS.lb_selection.query("isActive = true")  // Takes all active
	
	$vJ_zen_banks:=OBJECT Get value:C1743("zen_banks")
	$cES_BANKS:=$vJ_zen_banks.lb_selected
	$cES_BANKS:=($cES_BANKS.length>0) ? $cES_BANKS : $vJ_zen_banks.lb_selection.query("isActive = true")  // Takes all active
	
	$vJ_is_delete:=OBJECT Get value:C1743("waz_is_delete")
	$is_delete:=$vJ_is_delete.v_value
	$vJ_is_delete.v_value:=False:C215
	$vJ_is_delete.redraw()
	
	$cs_SEMIPPAN_PLAY:=cs:C1710.SEMIPPAN_PLAY.new()
	$cs_SEMIPPAN_PLAY.do_PACK_PLAY($cES_PATHS; $cE_PACKS; $cES_BANKS; $is_delete)
	// *
	// *****
	
	