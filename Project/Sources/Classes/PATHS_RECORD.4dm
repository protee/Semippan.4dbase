
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	Super:C1706.record_load_upd()
	This:C1470.l_timer:=1
	//If (Form.is_new)
	//$c4E:=Form.c4E
	//$c4E.isActive:=True
	////This.widgets_upd()
	//End if 
	This:C1470.activate_btns()
	
	
	//Function widgets_upd()
	//var $vC_at_widgets : Collection
	//var $vJ_widget : Object
	//var $vT_widget : Text
	//$vC_at_widgets:=New collection()
	//$vC_at_widgets.push("waz_isActive")  //; "woc_colors")
	//For each ($vT_widget; $vC_at_widgets)
	//$vJ_widget:=OBJECT Get value($vT_widget)
	//$vJ_widget.redraw()
	//End for each 
	
	
Function record_checkout()->$isOk : Boolean
	var $c4E_entity : 4D:C1709.Entity
	var $vJ_okValidate : Object
	$c4E_entity:=Form:C1466.c4E
	$vJ_okValidate:=zen_okValidate_init
	zen_okValidate_check($vJ_okValidate; ($c4E_entity.isExternalPath && ($c4E_entity.label="")); False:C215; "Fill in label!")
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
				: ($vT_objectName="field_isOVW")
					This:C1470.activate_btns()
					
				: ($vT_objectName="field_isMyPath@")
					This:C1470.activate_btns()
					
				: ($vT_objectName="btn_pathExist@")
					This:C1470.pathExist()
					
				: ($vT_objectName="btn_show@")
					This:C1470.show()
					
				: ($vT_objectName="btn_tools@")
					This:C1470.tools()
					
				: ($vT_objectName="btn_ogBoxes@")
					This:C1470.ogBoxes()
					
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
	
	
	
Function get_path($c4E : 4D:C1709.Entity)->$c4Fo_database : 4D:C1709.Folder
	If ($c4E#Null:C1517)
		If ($c4E.isMyPath)
			$c4Fo_database:=Folder:C1567(fk database folder:K87:14)
		Else 
			If ($c4E.path#"")
				$c4Fo_database:=Folder:C1567($c4E.path)
			End if 
		End if 
	End if 
	
	
Function get_path_calculated()->$c4Fo_database : 4D:C1709.Folder
	var $c4E : 4D:C1709.Entity
	var $is_externalPath : Boolean
	$c4E:=Form:C1466.c4E
	$is_externalPath:=$c4E.isExternalPath
	If ($is_externalPath)
		$c4Fo_database:=This:C1470.get_path($c4E)
	Else 
		$c4E:=$c4E.PATHS_PRODUCTS
		$c4Fo_database:=This:C1470.get_path($c4E)
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
	var $isOk; $is_exists; $is_visible : Boolean
	var $vP_myPath; $vP_btn_exists : Pointer
	var $c4E : 4D:C1709.Entity
	
	$c4E:=Form:C1466.c4E
	$is_visible:=$c4E.isExternalPath
	OBJECT SET VISIBLE:C603(*; "@_ovw"; $is_visible)
	If ($is_visible)
		$vP_btn_exists:=OBJECT Get pointer:C1124(Object named:K67:5; "btn_pathExist_ovw")
		$isOk:=Not:C34($c4E.isMyPath) && Form:C1466.is_editing
		OBJECT SET ENABLED:C1123($vP_btn_exists->; $isOk)
		OBJECT SET ENABLED:C1123(*; "btn_repair"; $isOk)
		$vP_myPath:=OBJECT Get pointer:C1124(Object named:K67:5; "myPath_ovw")
		OBJECT SET VISIBLE:C603($vP_myPath->; $c4E.isMyPath)
		
		$c4Fo_database:=This:C1470.get_path_calculated()
		$is_exists:=$c4Fo_database#Null:C1517
		OBJECT SET ENABLED:C1123(*; "btn_folderCreate_ovw"; $is_exists)
		If ($is_exists)
			$is_exists:=$c4Fo_database.exists
			$vP_myPath->:=$c4Fo_database.path
			OBJECT SET ENABLED:C1123(*; "btn_folderCreate_ovw"; Not:C34($is_exists))
		End if 
		x_btn_toggleSet($vP_btn_exists; Num:C11($is_exists))
	End if 
	
	
	
Function pathExist()
	var $vT_path : Text
	var $c4Fo_database : 4D:C1709.Folder
	var $c4E : 4D:C1709.Entity
	If (Form:C1466.is_editing)
		$c4Fo_database:=This:C1470.get_path_calculated()
		$vT_path:=$c4Fo_database#Null:C1517 ? $vT_path : ""
		$vT_path:=Select folder:C670("Choose a project path"; $vT_path; Package open:K24:8)
		If (OK=1)
			$c4E:=Form:C1466.c4E
			$c4E.path:=Folder:C1567($vT_path; fk platform path:K87:2).path
			$c4E.isMyPath:=($c4E.path=(Folder:C1567(fk database folder:K87:14).path))
		End if 
		This:C1470.activate_btns()
	End if 
	
	
Function tools()
	var $c4Fo_database : 4D:C1709.Folder
	var $c4E : 4D:C1709.Entity
	If (Form:C1466.is_editing)
		$c4Fo_database:=This:C1470.get_path_calculated()
		$c4E:=Form:C1466.c4E
		If (Not:C34($c4E.isMyPath) && ($c4Fo_database#Null:C1517))
			If (waz_io_confirm_popup("Try to repair Path ?"))
				//$c4Fo_database:=x_path_root_adjust($c4Fo_database)
				//If ($c4Fo_database#Null)
				//This.activate_btns()
				//End if 
			End if 
		End if 
	End if 
	
Function folderCreate()
	var $c4Fo_database : 4D:C1709.Folder
	var $c4E : 4D:C1709.Entity
	If (Form:C1466.is_editing)
		$c4E:=Form:C1466.c4E
		If ($c4E.isMyPath)
			wox_sounds_play_beep()
		Else 
			$c4Fo_database:=This:C1470.get_path_calculated()
			If ($c4Fo_database#Null:C1517)
				If (waz_io_confirm_popup("Create folder Path ?"))
					$c4Fo_database.create()
					This:C1470.activate_btns()
				End if 
			End if 
		End if 
	End if 
	
	
	
Function show()
	var $c4Fo_database : 4D:C1709.Folder
	$c4Fo_database:=This:C1470.get_path_calculated()
	If ($c4Fo_database#Null:C1517)
		If ($c4Fo_database.exists)
			SHOW ON DISK:C922($c4Fo_database.platformPath)
		End if 
	End if 
	
Function ogBoxes()
	var $vJ_widget : Object
	var $c4Fo_database : 4D:C1709.Folder
	var $c4E : 4D:C1709.Entity
	$c4Fo_database:=This:C1470.get_path_calculated()
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
	
	
	