
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	Super:C1706.record_load_upd()
	This:C1470.activate_btns()
	This:C1470.lb_comps_load()
	
	
Function record_checkout()->$isOk : Boolean
	var $c4E_entity : 4D:C1709.Entity
	$c4E_entity:=Form:C1466.c4E
	var $vJ_okValidate : Object
	$vJ_okValidate:=zen_okValidate_init
	zen_okValidate_check($vJ_okValidate; ($c4E_entity.label=""); True:C214; "Fill in label!")
	$isOk:=zen_okValidate_checkout($vJ_okValidate)
	
	
Function record_touched($c4E_record : 4D:C1709.Entity)->$is_touched : Boolean
	$is_touched:=Form:C1466.is_touched
	If (Not:C34($is_touched))
		$is_touched:=$c4E_record.touched()
	End if 
	
	
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
				: ($vT_objectName="bt_pitch")
					This:C1470.pitch_export()
					
				: ($vT_objectName="field_isMyPath")
					This:C1470.activate_btns()
					
				: ($vT_objectName="btn_pathExist")
					This:C1470.pathExist()
					
				: ($vT_objectName="bt_show")
					This:C1470.show()
					
				: ($vT_objectName="bt_gnanam")
					This:C1470.gnanam()
					
				: ($vT_objectName="bt_ogBoxes")
					This:C1470.ogBoxes()
					
				: ($vT_objectName="field_logo")
					If (Right click:C712) && (Form:C1466.is_editing)
						This:C1470._field_logo()
					End if 
					
				: ($vT_objectName="bt_copy")
					This:C1470.do_copy()
					
				: ($vT_objectName="bt_copy1")
					This:C1470.do_copy1()
					
				: ($vT_objectName="bt_copy2")
					This:C1470.do_copy2()
					
				: ($vT_objectName="bt_build")
					This:C1470.do_build()
					
				: ($vT_objectName="bt_app_wox")
					This:C1470.do_app_wox()
					
				: ($vT_objectName="bt_signed")
					This:C1470.is_signed()
					
					
				: ($vT_objectName="bt_comp_signed")
					This:C1470.comp_is_signed()
					
				: ($vT_objectName="bt_comp_find")
					This:C1470.comp_find()
					
			End case 
			
			//: ($vL_event_code=On Double Clicked)
			//Case of 
			//: ($vT_objectName="oO_svg")
			//This._copy_PP($vT_objectName)
			
			//: ($vT_objectName="oO_svg1")
			//This._copy_PP($vT_objectName)
			//End case 
			
			
			//: ($vL_event_code=On Timer)
			//This.timer()
			
			
			
			//: ($vL_event_code=On Double Clicked)
			
			//: ($vL_event_code=On Data Change)
			
			//: ($vL_event_code=On Double Clicked)
			
	End case 
	// *
	// *****
	
	
	
Function get_path()->$c4Fo_database : 4D:C1709.Folder
	var $c4E : 4D:C1709.Entity
	$c4E:=Form:C1466.c4E
	If ($c4E.isMyPath)
		$c4Fo_database:=Folder:C1567(fk database folder:K87:14)
	Else 
		If ($c4E.path#"")
			$c4Fo_database:=Folder:C1567($c4E.path)
		End if 
	End if 
	
	
Function on_path_drop()->$vL_answer : Integer
	var $c4Fo_root : 4D:C1709.Folder
	var $vL_event_code : Integer
	var $vT_path : Text
	var $c4E : 4D:C1709.Entity
	$vL_event_code:=Form event code:C388
	
	Case of 
		: ($vL_event_code=On Drag Over:K2:13)
			$vL_answer:=Num:C11(Not:C34(Form:C1466.is_editing))
			
		: ($vL_event_code=On Drop:K2:12)
			$vT_path:=Get file from pasteboard:C976(1)
			If ($vT_path#"")
				$c4Fo_root:=Folder:C1567($vT_path; fk platform path:K87:2)
				$c4E:=Form:C1466.c4E
				$c4E.path:=$c4Fo_root.path
				$c4E.isMyPath:=($c4Fo_root.path=Folder:C1567(fk database folder:K87:14).path)
				This:C1470.activate_btns()
			End if 
	End case 
	
	
Function activate_btns()
	var $c4Fo_database : 4D:C1709.Folder
	var $isOk; $is_exists : Boolean
	var $vP_myPath; $vP_btn_exists : Pointer
	var $c4E : 4D:C1709.Entity
	var $vC_at_btn : Collection
	var $vT_btn : Text
	
	$vP_btn_exists:=OBJECT Get pointer:C1124(Object named:K67:5; "btn_pathExist")
	$c4E:=Form:C1466.c4E
	$isOk:=Not:C34($c4E.isMyPath) && Form:C1466.is_editing
	OBJECT SET ENABLED:C1123($vP_btn_exists->; $isOk)
	$vP_myPath:=OBJECT Get pointer:C1124(Object named:K67:5; "myPath")
	OBJECT SET VISIBLE:C603($vP_myPath->; $c4E.isMyPath)
	
	$c4Fo_database:=This:C1470.get_path()
	$is_exists:=$c4Fo_database#Null:C1517
	//OBJECT SET ENABLED(*; "btn_folderCreate"; $is_exists)
	If ($is_exists)
		$is_exists:=$c4Fo_database.exists
		$vP_myPath->:=$c4Fo_database.path
		OBJECT SET ENABLED:C1123(*; "btn_folderCreate"; Not:C34($is_exists))
	End if 
	
	$vC_at_btn:=New collection:C1472("bt_show"; "bt_gnanam"; "bt_ogBoxes")
	For each ($vT_btn; $vC_at_btn)
		OBJECT SET ENABLED:C1123(*; $vT_btn; $is_exists)
	End for each 
	x_btn_toggleSet($vP_btn_exists; Num:C11($is_exists))
	
	
	
Function pathExist()
	var $vT_path : Text
	var $c4Fo_database : 4D:C1709.Folder
	var $c4E : 4D:C1709.Entity
	If (Form:C1466.is_editing)
		$c4Fo_database:=This:C1470.get_path()
		$vT_path:=$c4Fo_database#Null:C1517 ? $vT_path : ""
		$vT_path:=Select folder:C670(Localized string:C991("projectChooseImportPath"); $vT_path; Package open:K24:8)
		If (OK=1)
			$c4E:=Form:C1466.c4E
			$c4E.path:=Folder:C1567($vT_path; fk platform path:K87:2).path
			$c4E.isMyPath:=($c4E.path=(Folder:C1567(fk database folder:K87:14).path))
		End if 
		This:C1470.activate_btns()
		This:C1470.lb_comps_load()
	End if 
	
	
Function folderCreate()
	var $c4Fo_database : 4D:C1709.Folder
	var $c4E : 4D:C1709.Entity
	If (Form:C1466.is_editing)
		$c4E:=Form:C1466.c4E
		If ($c4E.isMyPath)
			wox_sounds_play_beep()
		Else 
			$c4Fo_database:=This:C1470.get_path()
			If ($c4Fo_database#Null:C1517)
				If (waz_io_confirm_popup("Create folder Path ?"))
					$c4Fo_database.create()
					This:C1470.activate_btns()
					This:C1470.lb_comps_load()
				End if 
			End if 
		End if 
	End if 
	
	
	
Function show()
	var $c4Fo_database : 4D:C1709.Folder
	$c4Fo_database:=This:C1470.get_path()
	If ($c4Fo_database#Null:C1517)
		If ($c4Fo_database.exists)
			SHOW ON DISK:C922($c4Fo_database.platformPath)
		End if 
	End if 
	
	
Function gnanam()
	var $c4Fo_database : 4D:C1709.Folder
	var $c4E : 4D:C1709.Entity
	var $vJ_this : Object
	var $vT_worker : Text
	$c4Fo_database:=This:C1470.get_path()
	If ($c4Fo_database#Null:C1517)
		If ($c4Fo_database.exists)
			$c4E:=Form:C1466.c4E
			$vT_worker:="gnanam_"+$c4E.label
			$vJ_this:=This:C1470
			CALL WORKER:C1389($vT_worker; Formula:C1597($vJ_this.gnanam_P($1; $2)); $vT_worker; $c4Fo_database)
		End if 
	End if 
	
	
Function gnanam_P($vT_worker : Text; $c4Fo_database : 4D:C1709.Folder)
	wod_db_explorer($c4Fo_database)
	KILL WORKER:C1390($vT_worker)
	
	
Function ogBoxes()
	var $vJ_widget : Object
	var $c4Fo_database : 4D:C1709.Folder
	var $c4E : 4D:C1709.Entity
	$c4Fo_database:=This:C1470.get_path()
	If ($c4Fo_database#Null:C1517)
		If ($c4Fo_database.exists)
			$c4E:=Form:C1466.c4E
			$vJ_widget:=New object:C1471
			$vJ_widget.t_root_path:=$c4Fo_database.path
			$vJ_widget.t_sub_path:=""
			$vJ_widget.t_root:=""
			$vJ_widget.t_process:="_path_"+String:C10($c4E.UID)
			$vJ_widget.t_pref_name:="Path"
			$vJ_widget.is_editing:=True:C214
			$vJ_widget.t_title:="Path: "+$c4E.label
			wob_open($vJ_widget)
		End if 
	End if 
	
	
	// *****
	// *
Function _field_logo()
	var $c4Fi_avatar : 4D:C1709.File
	var $vO_logo : Picture
	var $c4E_entity : 4D:C1709.Entity
	$c4Fi_avatar:=waz_avatars_choose()
	If ($c4Fi_avatar#Null:C1517)
		READ PICTURE FILE:C678($c4Fi_avatar.platformPath; $vO_logo)
		$c4E_entity:=Form:C1466.c4E
		$c4E_entity.logo:=$vO_logo
	End if 
	// *
	// *****
	
	// *****
	// *
Function do_copy()
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	var $vT_answer : Text
	$vT_answer:=""
	$cE_PRODUCTS:=Form:C1466.c4E
	$vT_answer+=$cE_PRODUCTS.label+" – "+$cE_PRODUCTS.title+Char:C90(Carriage return:K15:38)
	$vT_answer+=$cE_PRODUCTS.subtitle+Char:C90(Carriage return:K15:38)
	$vT_answer+="Mantra: "+$cE_PRODUCTS.mantra+Char:C90(Carriage return:K15:38)
	$vT_answer+="Tagline: "+$cE_PRODUCTS.tagline+Char:C90(Carriage return:K15:38)
	SET TEXT TO PASTEBOARD:C523($vT_answer)
	wox_sounds_play_tick()
	
	
Function do_copy1()
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	var $vT_answer : Text
	$vT_answer:=""
	$cE_PRODUCTS:=Form:C1466.c4E
	$vT_answer:=$cE_PRODUCTS.title
	//$vT_answer:=Replace string($vT_answer; $cE_PRODUCTS.label+" – "; "")
	$vT_answer+=" – "+$cE_PRODUCTS.subtitle+Char:C90(Carriage return:K15:38)
	$vT_answer+=$cE_PRODUCTS.mantra+Char:C90(Carriage return:K15:38)
	$vT_answer+=$cE_PRODUCTS.tagline
	SET TEXT TO PASTEBOARD:C523($vT_answer)
	wox_sounds_play_tick()
	
	
Function do_copy2()
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	var $vT_answer : Text
	$vT_answer:=""
	$cE_PRODUCTS:=Form:C1466.c4E
	$vT_answer:=$cE_PRODUCTS.title
	//$vT_answer:=Replace string($vT_answer; $cE_PRODUCTS.label+" – "; "")
	$vT_answer+=" – "+This:C1470._add_dot($cE_PRODUCTS.subtitle)
	$vT_answer+=This:C1470._add_dot($cE_PRODUCTS.mantra)
	$vT_answer+=This:C1470._add_dot($cE_PRODUCTS.tagline; True:C214)
	SET TEXT TO PASTEBOARD:C523($vT_answer)
	wox_sounds_play_tick()
	
	
Function _add_dot($vT_text : Text; $is_last : Boolean)->$vT_answer : Text
	$vT_answer:=(Substring:C12($vT_text; Length:C16($vT_text); 1)#".") ? $vT_text+"." : $vT_text
	$vT_answer+=$is_last ? "" : " "
	
	
Function do_app_wox()
	var $c4Fo_database; $c4Fo_app_wox : 4D:C1709.Folder
	var $isOk : Boolean
	$c4Fo_database:=This:C1470.get_path()
	$c4Fo_app_wox:=$c4Fo_database.folder("Resources/app_wox")
	
	$isOk:=($c4Fo_app_wox.exists)
	If (Not:C34($isOk))
		$isOk:=waz_io_confirm_popup("Create it ?")
		If ($isOk)
			$c4Fo_app_wox.create()
		End if 
	End if 
	If ($isOk)
		SHOW ON DISK:C922($c4Fo_app_wox.platformPath)
	End if 
	
Function pitch_export()
	var $c4Fi_pitch : 4D:C1709.File
	var $c4Fo_database; $c4Fo_target : 4D:C1709.Folder
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	var $vJ_pitch : Object
	var $vT_app_wox; $vT_subpath; $vT_file; $vT_text : Text
	$cE_PRODUCTS:=Form:C1466.c4E
	$c4Fo_database:=This:C1470.get_path()
	If ($c4Fo_database.exists)
		$vJ_pitch:=New object:C1471()
		$vJ_pitch.t_title:=$cE_PRODUCTS.title
		$vJ_pitch.t_subtitle:=$cE_PRODUCTS.subtitle
		$vJ_pitch.t_mantra:=$cE_PRODUCTS.mantra
		$vJ_pitch.t_tagline:=$cE_PRODUCTS.tagline
		$vT_app_wox:=wox__storage_prefs().t_app_wox
		$vT_subpath:="RESOURCES/"+$vT_app_wox
		$vT_file:="pitch.json"
		$c4Fo_target:=$c4Fo_database.folder($vT_subpath)
		//$vT_text:="Save pitch into \""+$vT_app_wox+"\" of "+$cE_PRODUCTS.label+"?"
		$vT_text:="Save pitch into "+$cE_PRODUCTS.label+$vT_subpath+"/"+$vT_file+"?"
		If (waz_io_confirm_popup($vT_text))
			$c4Fo_target.create()
			$c4Fi_pitch:=$c4Fo_target.file($vT_file)
			$c4Fi_pitch.setText(JSON Stringify:C1217($vJ_pitch))
		End if 
	Else 
		wox_sounds_play_glop_no()
	End if 
	
	
Function do_build()
	var $c4Fo_build : 4D:C1709.Folder
	$c4Fo_build:=This:C1470.get_build_path()
	If ($c4Fo_build.exists)
		SHOW ON DISK:C922($c4Fo_build.platformPath)
	End if 
	
Function get_build_path()->$c4Fo_build : 4D:C1709.Folder
	var $c4Fo_database : 4D:C1709.Folder
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	$c4Fo_database:=This:C1470.get_path()
	If ($c4Fo_database.exists)
		$cE_PRODUCTS:=Form:C1466.c4E
		$c4Fo_build:=$c4Fo_database.parent.folder($cE_PRODUCTS.label+"_Build/Components/")
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function is_signed()
	var $c4Fo_build; $c4Fo_component : 4D:C1709.Folder
	var $c4SW_worker : 4D:C1709.SystemWorker
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	var $vT_path; $vT_cli; $vT_responseError : Text
	var $isOk : Boolean
	$c4Fo_build:=This:C1470.get_build_path()
	$isOk:=($c4Fo_build#Null:C1517) && ($c4Fo_build.exists)
	If ($isOk)
		$cE_PRODUCTS:=Form:C1466.c4E
		$c4Fo_component:=$c4Fo_build.folder($cE_PRODUCTS.label+".4dbase")
		$isOk:=$c4Fo_component.exists
		If ($isOk)
			$vT_path:=$c4Fo_component.path
			$vT_cli:="codesign --verify --deep --strict --verbose=2 "\
				+"   \""+$vT_path+"\""
			$c4SW_worker:=4D:C1709.SystemWorker.new($vT_cli)
			$vT_responseError:=$c4SW_worker.wait(1).responseError  //timeout 1 second
			//$vT_response:=$c4SW_worker.response
			If ($c4SW_worker.exitCode#0)
				If (waz_io_confirm_popup($vT_responseError; "copy"; "Copy?"))
					SET TEXT TO PASTEBOARD:C523($vT_responseError)
				End if 
			Else 
				waz_io_alert_popup($vT_responseError; "dones")
			End if 
		End if 
	End if 
	If (Not:C34($isOk))
		waz_io_alert_popup("Component not found!"; "explore")
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function lb_comps_load()
	var $c4Fo_database; $c4Fo_components : 4D:C1709.Folder
	var $vC_fi_components : Collection
	$c4Fo_database:=This:C1470.get_path()
	If ($c4Fo_database#Null:C1517) && ($c4Fo_database.exists)
		$c4Fo_components:=$c4Fo_database.folder("Components")
		If $c4Fo_components#Null:C1517 && $c4Fo_components.exists
			$vC_fi_components:=$c4Fo_components.files(fk ignore invisible:K87:22)
			$vC_fi_components:=$vC_fi_components.orderBy("name")
			Form:C1466.lb_comps_selection:=$vC_fi_components
		End if 
	End if 
	
Function lb_label($c4Fi_component : 4D:C1709.File)->$vT_answer : Text
	var $is_alias : Boolean
	var $vL_colors; $vL_stroke; $vL_fill; $vL_colorStrokeH2; $vL_colorFillH2 : Integer
	var $vT_subPath : Text
	$vT_answer:=" "+$c4Fi_component.fullName+" "
	$vL_colors:=k_MDcolorsAppPrimary
	woc_sp_colors_to_rgb($vL_colors; ->$vL_stroke; ->$vL_fill)
	woc_sp_colors_to_rgb(k_MDcolorsAppSecondary; ->$vL_colorStrokeH2; ->$vL_colorFillH2)
	ST SET ATTRIBUTES:C1093($vT_answer; 1; 0; Attribute text color:K65:7; $vL_stroke; Attribute background color:K65:8; $vL_fill)
	ST SET ATTRIBUTES:C1093($vT_answer; 1; 0; Attribute text size:K65:6; 12)  //;Attribute bold style;1)
	
	$is_alias:=$c4Fi_component.isAlias
	If ($is_alias)
		$vT_subPath:=$c4Fi_component.original.path
		ST SET ATTRIBUTES:C1093($vT_subPath; 1; 0; Attribute text size:K65:6; 10; Attribute italic style:K65:2; 1)
		ST SET ATTRIBUTES:C1093($vT_subPath; 1; 0; Attribute text color:K65:7; $vL_colorStrokeH2; Attribute background color:K65:8; $vL_colorFillH2)
		$vT_answer:=$vT_answer+Char:C90(Carriage return:K15:38)+$vT_subPath  //+Char(Carriage return)+$txt
	End if 
	
	
Function lb_icn($c4Fi_component : 4D:C1709.File)->$vO_icon : Picture
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	var $vT_name : Text
	$vT_name:=$c4Fi_component.name
	$cE_PRODUCTS:=ds:C1482.PRODUCTS.query("label = :1"; $vT_name).first()
	If ($cE_PRODUCTS#Null:C1517)
		$vO_icon:=$cE_PRODUCTS.logo
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function comp_is_signed()
	var $c4Fi_component; $c4Fi_original : 4D:C1709.File
	var $c4SW_worker : 4D:C1709.SystemWorker
	var $is_alias : Boolean
	var $vT_cli; $vT_path; $vT_response; $vT_responseError : Text
	$c4Fi_component:=Form:C1466.lb_comps_current
	If ($c4Fi_component#Null:C1517)
		$is_alias:=$c4Fi_component.isAlias
		$c4Fi_original:=$is_alias ? $c4Fi_component.original : $c4Fi_component
		$vT_path:=$c4Fi_original.path
		If ($c4Fi_original.isPackage) && ($c4Fi_original.extension=".4dbase")
			$vT_path:=Substring:C12($vT_path; 1; Length:C16($vT_path)-1)
		End if 
		//$vT_cli:="codesign -dv --verbose=4 /path/to/Component.4dbase"
		//$vT_cli:="codesign -dv --verbose=4 \""+$vT_path+"\""
		//find "/Applications/4D og components v20 NEW/zen_Nucleus.4dbase" \
			-type f \( -name "*.4DX" -o -name "*.dylib" -o -perm +111 \) \
			-exec echo "Checking: {}" \; \
			-exec codesign -dv --verbose=4 {} \; 2>&1 | head -20
		//$vT_cli:="find \""+$vT_path+"\" \\"+Char(Carriage return)+\
			"-type f \\( -name \"*.4DX\" -o -name \"*.dylib\" -o -perm +111 \\) \\"+Char(Carriage return)+\
			"-exec echo \"Checking : {}\" \\; \\"+Char(Carriage return)+\
			"-exec codesign -dv --verbose=4 {} \\; 2>&1 | head-20"
		
		$vT_cli:="find \""+$vT_path+"\" -type f '(' -name \"*.4DZ\" -o -name \"*.dylib\" ')' -exec sh -c 'codesign -dv \"$1\" 2>/dev/null && echo \"SIGNED : $1\"' _ {} \";\""
		//SET TEXT TO PASTEBOARD($vT_cli)
		
		$c4SW_worker:=4D:C1709.SystemWorker.new($vT_cli)
		$vT_response:=$c4SW_worker.wait(1).response  //timeout 1 second
		$vT_responseError:=$c4SW_worker.responseError
		If ($vT_responseError#"")
			If (waz_io_confirm_popup($vT_responseError; "copy"; "Copy?"))
				SET TEXT TO PASTEBOARD:C523($vT_responseError)
			End if 
		Else 
			waz_io_alert_popup($vT_response; "dones")
		End if 
	End if 
	// *
	// *****
	
	
	// *****
	// *
	
	// *
	// *****
	
	