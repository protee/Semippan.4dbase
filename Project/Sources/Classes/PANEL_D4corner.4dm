
//property _is_run; _is_deploy; _is_init; _is_settings : Boolean
//property _l_veda_last : Integer
//property j_registered : Object

Class constructor
	zen_startup_screen_get_menuBar()
	This:C1470.form_init()
	
	
	// *****
	// *
Function form_events()
	var $vL_event_code : Integer
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	
	$vL_event_code:=Form event code:C388
	$vJ_formEvent:=FORM Event:C1606
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Unload:K2:2)
			wox_prefs_windows_save()
			
		: ($vL_event_code=On Close Box:K2:21)
			CANCEL:C270
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
				: ($vT_objectName="bt_add")
					This:C1470._do_add()
					
				: ($vT_objectName="bt_save")
					This:C1470._do_save()
					
					//: ($vT_objectName="bt_save")
					//This._do_settings_save()
					
					
			End case 
			
			
			//: ($vL_event_code=On Double Clicked)
			
		: ($vL_event_code=On Resize:K2:27)
			//SET TIMER(0)
			This:C1470.D4corner_resize()
			
		: ($vL_event_code=On Timer:K2:25)
			This:C1470.progress_close()
			
	End case 
	// *
	// *****
	
	
Function form_init()
	wox_prefs_windows_load()
	//If (Not(Bool(Form.is_moved)))
	//$vL_winRef:=Current form window
	//$cs_ZEN__FORM_MOVE:=cs.ZEN__FORM_MOVE.new($vL_winRef)
	//Form.is_moved:=True
	//End if 
	This:C1470._is_settings:=False:C215
	This:C1470.record_load_upd()
	
	
Function record_load_upd()
	var $c4Fi_D4corner : 4D:C1709.File
	var $cE_ZEN_DASHBOARD : cs:C1710.ZEN_DASHBOARDEntity
	var $vJ_biz : Object
	var $vT_D4corner; $vT_github; $vT_text : Text
	var $vC_aj_D4corner : Collection
	var $cES_PRODUCTS : cs:C1710.PRODUCTSSelection
	
	This:C1470.j_logos:=New object:C1471()
	
	$cE_ZEN_DASHBOARD:=ds:C1482.ZEN_DASHBOARD.all().first()
	$vJ_biz:=$cE_ZEN_DASHBOARD.j_biz
	$vT_D4corner:=$vJ_biz.t_4Dcorner
	$vT_github:=$vJ_biz.t_github
	This:C1470.t_github:=$vT_github
	$c4Fi_D4corner:=Try(File:C1566($vT_D4corner))
	This:C1470.fi_D4corner:=$c4Fi_D4corner
	
	If ($c4Fi_D4corner#Null:C1517)
		$vT_text:=$c4Fi_D4corner.getText()
		$vC_aj_D4corner:=Try(JSON Parse:C1218($vT_text))
	End if 
	This:C1470.aj_D4corner:=$vC_aj_D4corner
	This:C1470.D4corner_redraw()
	
	$cES_PRODUCTS:=ds:C1482.PRODUCTS.query("isCorner = :1"; True:C214)
	$cES_PRODUCTS:=$cES_PRODUCTS.orderBy("label")
	Form:C1466.lb_selection:=$cES_PRODUCTS
	
	
Function lb_get_logo_icn($cE_PRODUCTS : cs:C1710.PRODUCTSEntity)->$vO_logo : Picture
	var $vL_httpStatus : Integer
	var $vT_label; $vT_path_logo : Text
	var $vJ_logos : Object
	$vT_label:=$cE_PRODUCTS.label
	$vJ_logos:=This:C1470.j_logos
	$vO_logo:=$vJ_logos[$vT_label]
	If ($vO_logo=Null:C1517)
		$vT_path_logo:="https://www.protee.org/images/"+$vT_label+"/"+$vT_label+".png"
		This:C1470.progress_label($vT_label)
		$vL_httpStatus:=HTTP Get:C1157($vT_path_logo; $vO_logo)
		If ($vL_httpStatus=200)
			$vJ_logos[$vT_label]:=$vO_logo
		End if 
	End if 
	
	
Function progress_label($vT_label : Text)
	var $vT_progress_uuid : Text
	$vT_progress_uuid:=This:C1470.progress_new()
	If ($vT_progress_uuid#"")
		//waz_progress_subtitle($vT_progress_uuid; $vT_label)
		waz_progress_title($vT_progress_uuid; "Loading logos"; $vT_label)
	End if 
	
Function progress_new()->$vT_progress_uuid : Text
	var $vT_label : Text
	$vT_progress_uuid:=This:C1470.t_progress_uuid
	If ($vT_progress_uuid="")
		$vT_progress_uuid:=waz_progress_new()
		This:C1470.t_progress_uuid:=$vT_progress_uuid
		SET TIMER:C645(30)
	End if 
	
Function progress_close()
	var $vT_progress_uuid : Text
	$vT_progress_uuid:=This:C1470.t_progress_uuid
	If ($vT_progress_uuid#"")
		waz_progress_quit($vT_progress_uuid)
		This:C1470.t_progress_uuid:=""
		SET TIMER:C645(0)
	End if 
	
	
Function lb_get_state_icn($cE_PRODUCTS : cs:C1710.PRODUCTSEntity)->$vO_state : Picture
	var $isOk : Boolean
	var $vC_aj_D4corner; $vC_aj_result : Collection
	var $vL_color : Integer
	$vC_aj_D4corner:=This:C1470.aj_D4corner
	$vC_aj_result:=$vC_aj_D4corner.query("repository = :1"; "@"+$cE_PRODUCTS.label)
	$isOk:=$vC_aj_result.length=0
	$vL_color:=$isOk ? 0x0A000021 : 0x0A00003E
	$vO_state:=woc_sp_color_get_icns($vL_color)
	// *
	// *****
	
	
Function D4corner_resize()
	var $vJ_wox_D4corner : Object
	$vJ_wox_D4corner:=OBJECT Get value:C1743("wox_D4corner")
	$vJ_wox_D4corner.resize()
	$vJ_wox_D4corner.redraw()
	
	
Function D4corner_redraw()
	var $vJ_4Dcorner; $vJ_wox_D4corner : Object
	var $vC_aj_D4corner : Collection
	$vC_aj_D4corner:=This:C1470.aj_D4corner
	If ($vC_aj_D4corner#Null:C1517)
		$vJ_4Dcorner:=New object:C1471()
		$vJ_4Dcorner.aj_D4corner:=$vC_aj_D4corner
		$vJ_wox_D4corner:=OBJECT Get value:C1743("wox_D4corner")
		$vJ_wox_D4corner.j_value:=$vJ_4Dcorner
		$vJ_wox_D4corner.redraw()
	End if 
	
	
Function _do_add()
	var $isOk : Boolean
	var $vC_aj_D4corner; $vC_aj_result : Collection
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	var $cES_PRODUCTS_in; $cES_PRODUCTS : cs:C1710.PRODUCTSSelection
	var $vJ_D4corner : Object
	var $vT_github; $vT_label : Text
	$cES_PRODUCTS_in:=Form:C1466.lb_selection
	$cES_PRODUCTS:=Form:C1466.lb_selected
	$cES_PRODUCTS:=zen_choice_selection($cES_PRODUCTS_in; $cES_PRODUCTS)
	If ($cES_PRODUCTS#Null:C1517)
		$vC_aj_D4corner:=This:C1470.aj_D4corner
		$vT_github:=This:C1470.t_github
		For each ($cE_PRODUCTS; $cES_PRODUCTS)
			$vC_aj_result:=$vC_aj_D4corner.query("repository = :1"; "@"+$cE_PRODUCTS.label)
			$isOk:=$vC_aj_result.length=0
			If ($isOk)
				$vJ_D4corner:=New object:C1471()
				$vC_aj_D4corner.push($vJ_D4corner)
			Else 
				$vJ_D4corner:=$vC_aj_result[0]
			End if 
			
			$vT_label:=$cE_PRODUCTS.label
			$vJ_D4corner.title:=$cE_PRODUCTS.title
			$vJ_D4corner.repository:=$vT_github+$vT_label
			$vJ_D4corner.path_logo:="https://www.protee.org/images/"+$vT_label+"/"+$vT_label+".png"
		End for each 
		This:C1470.D4corner_redraw()
		Form:C1466.lb_selection:=Form:C1466.lb_selection
	End if 
	
	
Function _do_save()
	var $c4Fi_D4corner : 4D:C1709.File
	var $vC_aj_D4corner : Collection
	$c4Fi_D4corner:=This:C1470.fi_D4corner
	If ($c4Fi_D4corner#Null:C1517)
		If (waz_io_confirm_popup("Save file "+$c4Fi_D4corner.name+"?"))
			//$vT_filename:=$c4Fi_D4corner.name+"1"+$c4Fi_D4corner.extension
			//$c4Fi_D4corner:=$c4Fi_D4corner.parent.file($vT_filename)
			$vC_aj_D4corner:=This:C1470.aj_D4corner
			$c4Fi_D4corner.setText(JSON Stringify:C1217($vC_aj_D4corner; *))
		End if 
	Else 
		cs:C1710.wox.SOUNDS.me.play_error()
	End if 
	
	