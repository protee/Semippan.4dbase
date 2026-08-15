
property _j_registered : Object
property cE_SLOKAS : cs:C1710.SLOKASEntity
property _cE_PRODUCTS : cs:C1710.PRODUCTSEntity
property j_pattern : Object

Class extends ZEN__WIDGETS

Class constructor
	Super:C1705("j_sloka")
	This:C1470.cE_SLOKAS:=Null:C1517
	// *
	// *****
	
	
	// *****
	// *
Function _widget_events()
	var $vL_event_code : Integer
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	$vJ_formEvent:=FORM Event:C1606
	$vL_event_code:=$vJ_formEvent.code
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Bound Variable Change:K2:52)
			This:C1470._update_all()
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
				: ($vT_objectName="oo_product")
					This:C1470._do_show_on_disk()
					
			End case 
			
		: ($vL_event_code=On Double Clicked:K2:5)
			Case of 
				: ($vT_objectName="oo_product")
					This:C1470._do_open()
					
			End case 
			
	End case 
	// *
	// *****
	
	
	
	// MARK: - Manager
	
Function _update_all()
	This:C1470._resize()
	This:C1470._redraw()
	
	
	// *****
	// *
Function _resize()
	var $vL_width; $vL_height : Integer
	var $vL_left; $y1; $vL_right; $vL_bottom; $vL_top; $vL_h; $y2 : Integer
	var $vT_ot_description; $vT_oo_home; $vT_woc_card_bkg : Text
	var $vJ_woc_card_bkg : Object
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	
	$vT_woc_card_bkg:="woc_card_bkg"
	OBJECT SET COORDINATES:C1248(*; $vT_woc_card_bkg; 0; 0; $vL_width; $vL_height)
	$vJ_woc_card_bkg:=OBJECT Get value:C1743($vT_woc_card_bkg)
	$vJ_woc_card_bkg.resize()
	
	$vT_ot_description:="ot_description"
	$vT_oo_home:="oo_home"
	OBJECT GET COORDINATES:C663(*; $vT_ot_description; $vL_left; $y1; $vL_right; $vL_bottom)
	OBJECT GET COORDINATES:C663(*; $vT_oo_home; $vL_left; $vL_top; $vL_right; $vL_bottom)
	$vL_h:=$vL_bottom-$vL_top
	$y2:=$vL_height-$vL_h
	OBJECT SET COORDINATES:C1248(*; $vT_ot_description; $vL_left; $y1; $vL_right; $y2)
	OBJECT SET COORDINATES:C1248(*; $vT_oo_home; $vL_left; $y2; $vL_right; $vL_height)
	// *
	// *****
	
	
	// *****
	// *
Function _redraw()
	var $c4Fo_database : 4D:C1709.Folder
	var $is_selected; $is_product; $is_pro_app : Boolean
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	var $cE_SLOKAS : cs:C1710.SLOKASEntity
	var $vL_colors; $vL_font_style; $vL_color_stroke; $vL_color_fill : Integer
	var $vJ_woc_card_bkg; $vJ_registered : Object
	var $vO_product : Picture
	var $vT_ot_product; $vT_oo_product; $vT_ot_description; $vT_woc_card_bkg; $vT_app; $vT_product; $vT_description; $vT_label; $vT_database : Text
	$cE_SLOKAS:=This:C1470.cE_SLOKAS
	$is_selected:=$cE_SLOKAS#Null:C1517
	$vT_woc_card_bkg:="woc_card_bkg"
	$vT_ot_product:="ot_product"
	$vT_oo_product:="oo_product"
	$vT_ot_description:="ot_description"
	OBJECT SET VISIBLE:C603(*; $vT_ot_product; $is_selected)
	OBJECT SET VISIBLE:C603(*; $vT_oo_product; $is_selected)
	OBJECT SET VISIBLE:C603(*; $vT_ot_description; $is_selected)
	OBJECT SET VISIBLE:C603(*; $vT_woc_card_bkg; Not:C34($is_selected))
	If ($is_selected)
		$vL_colors:=$cE_SLOKAS.colors
		$cE_PRODUCTS:=$cE_SLOKAS.SLOKAS_PRODUCTS
		$is_product:=$cE_PRODUCTS#Null:C1517
		If ($is_product)
			$vT_app:=$cE_PRODUCTS.app
			$is_pro_app:=False:C215
			$vT_product:=$is_pro_app ? $vT_app : $cE_PRODUCTS.label
			//$vL_colors:=$cE_PRODUCTS.colors
			$vL_colors:=$vL_colors#0 ? $vL_colors : $cE_PRODUCTS.colors
			$vO_product:=$cE_PRODUCTS.logo
			$vL_font_style:=0
			$vT_description:=x_text_plainToRtf($cE_PRODUCTS.title)
			$vT_description:=Replace string:C233($vT_description; $cE_PRODUCTS.label+" – "; "")
			//ST SET ATTRIBUTES($vT_description; 1; 0; Attribute text color; $vL_color_stroke; Attribute background color; $vL_color_fill)
			ST SET ATTRIBUTES:C1093($vT_description; 1; 0; Attribute text size:K65:6; 24; Attribute bold style:K65:1; 1)
			$vT_description+=Char:C90(Carriage return:K15:38)
			
			$vT_description+=x_text_plainToRtf($cE_PRODUCTS.subtitle)+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)
			$vT_label:="Mantra"
			ST SET ATTRIBUTES:C1093($vT_label; 1; 0; Attribute text size:K65:6; 18; Attribute italic style:K65:2; 1)
			$vT_description+=$vT_label+Char:C90(Carriage return:K15:38)
			$vT_description+=x_text_plainToRtf($cE_PRODUCTS.mantra)+Char:C90(Carriage return:K15:38)
			$vT_label:="Tagline"
			ST SET ATTRIBUTES:C1093($vT_label; 1; 0; Attribute text size:K65:6; 18; Attribute italic style:K65:2; 1)
			$vT_description+=$vT_label+Char:C90(Carriage return:K15:38)
			$vT_description+=x_text_plainToRtf($cE_PRODUCTS.tagline)
			$c4Fo_database:=This:C1470._get_PRODUCT_path($cE_PRODUCTS)
			$vT_database:=$c4Fo_database#Null:C1517 ? $c4Fo_database.platformPath : ""
			
		Else 
			$vT_product:=$cE_SLOKAS.label
			$vO_product:=$cE_SLOKAS.logo
			$vL_font_style:=Bold:K14:2
			$vT_description:=""
		End if 
		woc_sp_colors_to_rgb($vL_colors; ->$vL_color_stroke; ->$vL_color_fill)
		OBJECT SET RGB COLORS:C628(*; $vT_ot_product; $vL_color_stroke; $vL_color_fill)
		OBJECT SET RGB COLORS:C628(*; $vT_ot_description; $vL_color_fill; $vL_color_stroke)
		OBJECT SET VALUE:C1742($vT_oo_product; $vO_product)
		OBJECT SET HELP TIP:C1181(*; $vT_oo_product; $vT_database)
		OBJECT SET VALUE:C1742($vT_ot_product; $vT_product)
		OBJECT SET VALUE:C1742($vT_ot_description; $vT_description)
		
	Else 
		$vJ_woc_card_bkg:=OBJECT Get value:C1743($vT_woc_card_bkg)
		$vJ_woc_card_bkg.j_value:=This:C1470.j_pattern
		$vJ_woc_card_bkg.redraw()
	End if 
	This:C1470._cE_PRODUCTS:=$cE_PRODUCTS
	
	$vJ_registered:=This:C1470._get_j_registered($vT_app)
	This:C1470._j_registered:=$vJ_registered
	This:C1470._app_home_pict($vJ_registered)
	This:C1470._btn_app_upd($vJ_registered)
	// *
	// *****
	
	
	
	// *****
	// *
	
Function _do_open()
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	var $cES_PRODUCTS : cs:C1710.PRODUCTSSelection
	var $vV_UID : Variant
	$cE_PRODUCTS:=This:C1470._cE_PRODUCTS
	If ($cE_PRODUCTS#Null:C1517)
		$cES_PRODUCTS:=ds:C1482.PRODUCTS.newSelection().add($cE_PRODUCTS)
		$vV_UID:=$cE_PRODUCTS.UID
		zen_record_open("PRODUCTS"; ""; $vV_UID; $cES_PRODUCTS)
	End if 
	
	
Function _do_show_on_disk()
	var $c4Fo_database : 4D:C1709.Folder
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	If (Right click:C712)
		$cE_PRODUCTS:=This:C1470._cE_PRODUCTS
		If ($cE_PRODUCTS#Null:C1517)
			$c4Fo_database:=This:C1470._get_PRODUCT_path($cE_PRODUCTS)
			If ($c4Fo_database#Null:C1517)
				SHOW ON DISK:C922($c4Fo_database.platformPath; *)
			End if 
		End if 
	End if 
	
Function _get_PRODUCT_path($cE_PRODUCTS : cs:C1710.PRODUCTSEntity)->$c4Fo_database : 4D:C1709.Folder
	If ($cE_PRODUCTS#Null:C1517)
		If ($cE_PRODUCTS.isMyPath)
			$c4Fo_database:=Folder:C1567(fk database folder:K87:14)
		Else 
			If ($cE_PRODUCTS.path#"")
				$c4Fo_database:=Folder:C1567($cE_PRODUCTS.path)
			End if 
		End if 
	End if 
	
	
Function _get_j_registered($vT_app : Text)->$vJ_registered : Object
	var $is_app : Boolean
	var $vC_aj_registered : Collection
	$is_app:=$vT_app#""
	If ($is_app)
		$vC_aj_registered:=wok__registered()
		$vJ_registered:=$vC_aj_registered.query("t_app = :1"; $vT_app).first()
	End if 
	
	
Function _app_home_pict($vJ_registered : Object)
	var $c4Fi_home : 4D:C1709.File
	var $c4Fo_rsc; $c4Fo_database : 4D:C1709.Folder
	var $vO_home : Picture
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	If ($vJ_registered#Null:C1517)
		$c4Fo_rsc:=$vJ_registered.fo_rsc  // Host
		
	Else 
		$cE_PRODUCTS:=This:C1470._cE_PRODUCTS
		$c4Fo_database:=This:C1470._get_PRODUCT_path($cE_PRODUCTS)
		$c4Fo_rsc:=$c4Fo_database#Null:C1517 ? $c4Fo_database.folder("Resources") : Null:C1517
	End if 
	If ($c4Fo_rsc#Null:C1517)
		$c4Fi_home:=$c4Fo_rsc.file("pictures/home.png")
		If ($c4Fi_home.exists)
			READ PICTURE FILE:C678($c4Fi_home.platformPath; $vO_home)
		End if 
	End if 
	OBJECT SET VALUE:C1742("oO_home"; $vO_home)
	
Function _btn_app_upd($vJ_registered : Object)
	var $is_app : Boolean
	var $vJ_widget : Object
	var $vT_waz_app : Text
	$is_app:=$vJ_registered#Null:C1517
	$vT_waz_app:="waz_app"
	OBJECT SET VISIBLE:C603(*; "@"+$vT_waz_app; $is_app)
	If ($is_app)
		//$vT_method:=$vT_app+"__storage_prefs"
		//Try(EXECUTE METHOD($vT_method; $vJ_app_prefs))
		//$is_app:=$vJ_app_prefs#Null
		//If ($is_app)
		$vJ_widget:=OBJECT Get value:C1743($vT_waz_app)
		$vJ_widget.fo_rsc:=$vJ_registered.fo_rsc  // Host
		$vJ_widget.t_tip:=$vJ_registered.t_name
		$vJ_widget.t_value:="pictures/btn_product"  // TODO
		$vJ_widget.redraw()
		//End if 
	End if 
	
	
Function _btn_app_clicked()
	var $isOk : Boolean
	var $vC_at_answer : Collection
	var $vJ_registered : Object
	var $vT_prefix; $vT_refMenu; $vT_answerMenu; $vT_action : Text
	$vJ_registered:=This:C1470._j_registered
	$vT_prefix:="ogt.xxx."  //+$vJ_app_prefs.t_app+"." 
	$vT_refMenu:=Create menu:C408()
	wox_4dPop_app_menu($vT_prefix; $vJ_registered; True:C214; $vT_refMenu; True:C214)
	$vT_answerMenu:=Dynamic pop up menu:C1006($vT_refMenu)
	RELEASE MENU:C978($vT_refMenu)
	$isOk:=($vT_answerMenu#"")
	If ($isOk)
		$vC_at_answer:=Split string:C1554($vT_answerMenu; ".")
		$vT_action:=$vC_at_answer.shift()
		If ($vT_action="ogt")  // Security
			wox_4Dpop_execute($vC_at_answer)  // Direct "xxx.@"
		Else 
			cs:C1710.wox.SOUNDS.me.play_glop_no()
		End if 
	End if 
	// *
	// *****
	
	