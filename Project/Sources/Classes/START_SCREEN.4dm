Class constructor
	
	
Function form_events($vL_event_code : Integer)
	var $vJ_formEvent; $vJ_palette : Object
	$vJ_formEvent:=FORM Event:C1606  // Récupère le numéro de l'évènement, le nom de l'objet (et plus si listbox)
	
	var $vT_objectName : Text
	var $isOk : Boolean
	var $cs_ZENH_PALETTE : cs:C1710.ZENH_PALETTE
	$vT_objectName:=FORM Event:C1606.objectName
	
	Case of 
		: ($vL_event_code=On Close Box:K2:21)
			CANCEL:C270
			
		: ($vL_event_code=On Unload:K2:2)
			KILL WORKER:C1390(Current process:C322)
			
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
					
				: ($vT_objectName="btn_product")
					$cs_ZENH_PALETTE:=cs:C1710.ZENH_PALETTE.new()
					$isOk:=$cs_ZENH_PALETTE.palette_do()
					
					
				: ($vT_objectName="btn_shortcut")
					This:C1470.btn_menu()
					
			End case 
			
			//: ($vL_event_code=On Mouse Enter)
			//Case of 
			
			//: ($vT_objectName="btn_product")
			//$cs_ZENH_PALETTE:=cs.ZENH_PALETTE.new()
			//$isOk:=$cs_ZENH_PALETTE.palette_do()
			//End case 
			
	End case 
	
	
Function btn_zen()
	var $is_edit : Boolean
	var $vJ_prefs; $vJ_wox : Object
	var $vT_version_last : Text
	If (Shift down:C543 || Right click:C712) || True:C214
		zen_4DPop()
	Else 
		$vJ_prefs:=zen__storage_prefs()
		$vJ_wox:=wox__storage_prefs
		$vJ_wox.fu_release_notes($vJ_prefs; $is_edit; $vT_version_last)
	End if 
	
	
	
Function btn_menu()
	var $c4Fu_label : 4D:C1709.Function
	var $c4DC_table : 4D:C1709.DataClass
	var $c4E_entity : 4D:C1709.Entity
	var $c4ES_table : 4D:C1709.EntitySelection
	var $vC_at_tables; $vC_es_table; $vC_answer; $vC_fu_tables : Collection
	var $is_all; $isOk : Boolean
	var $idx; $vL_indice : Integer
	var $vJ_this : Object
	var $vT_refMenu; $vT_table; $vT_answer : Text
	var $vV_UID : Variant
	
	$is_all:=Shift down:C543 || Right click:C712
	$vT_refMenu:=Create menu:C408()
	$vC_at_tables:=New collection:C1472()
	//$vC_at_tables.push("PRODUCTS"; "PACKS"; "KAVIYAM")
	$vC_at_tables.push("KAVIYAM")
	$vJ_this:=This:C1470
	$vC_fu_tables:=New collection:C1472()
	$vC_fu_tables.push(Formula:C1597(This:C1470.label); Formula:C1597(This:C1470.label); Formula:C1597(This:C1470.label))
	
	$vC_es_table:=New collection:C1472()
	$idx:=0
	For each ($vT_table; $vC_at_tables)
		$c4DC_table:=ds:C1482[$vT_table]
		$c4Fu_label:=$vC_fu_tables[$idx]
		$c4ES_table:=$is_all ? $c4DC_table.all() : $c4DC_table.query("isActive = :1"; True:C214)
		//$c4ES_table:=$c4ES_table.orderBy("label")
		$c4ES_table:=$c4ES_table.orderByFormula($c4Fu_label)
		$vC_es_table.push($c4ES_table)
		x_choice_record_menu($vT_table; $vT_table; $vT_table; $c4ES_table; $c4Fu_label; -1; $is_all; $vT_refMenu)
		$idx+=1
	End for each 
	
	$vT_answer:=Dynamic pop up menu:C1006($vT_refMenu)
	RELEASE MENU:C978($vT_refMenu)
	$isOk:=$vT_answer#""
	If ($isOk)
		$vC_answer:=Split string:C1554($vT_answer; ".")
		$vT_table:=$vC_answer[0]
		$idx:=$vC_at_tables.indexOf($vT_table)
		$c4ES_table:=$vC_es_table[$idx]
		$vL_indice:=Num:C11($vC_answer[1])
		$c4E_entity:=$c4ES_table[$vL_indice]
		$vV_UID:=$c4E_entity.UID
		zen_record_open($vT_table; ""; $vV_UID; $c4ES_table)
	End if 
	
	