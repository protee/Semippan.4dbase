//%attributes = {"lang":"en","preemptive":"incapable"}

var $vC_aj_TablesClass; $vC_afu_4dpop : Collection
var $vJ_prefs; $vJ_profile; $vJ_handlers; $vJ_relate_many_dup : Object
var $vT_localID : Text
$vJ_prefs:=zen__storage_prefs()

Use ($vJ_prefs)
	$vJ_prefs.j_app:=app__storage_prefs()  // Host app to get rsc and more
	$vJ_prefs.is_pretty:=True:C214  // json's files  formatting
	
	//If (False)
	//var $vJ_connectTo; $vJ_ds : Object
	//var $vT_localID : Text
	//$vT_localID:="DS_ED"
	//$vJ_connectTo:=New object
	//$vJ_connectTo.type:="4D Server"
	//$vJ_connectTo.hostname:="192.168.0.220:1080"
	//$vJ_connectTo.user:="rest_read"
	//$vJ_connectTo.password:="1234"
	//$vJ_connectTo.idleTimeout:=70
	//$vJ_connectTo.tls:=False
	//$vJ_ds:=Open datastore($vJ_connectTo; $vT_localID)
	//Else
	$vT_localID:=""
	//$vJ_ds:=ds
	//End if
	$vJ_prefs.t_ds:=$vT_localID  // Empty for local, or given to open datastore
	
	// ***** Profile, ready for later affectation, see "zenh_set_profile"
	// *
	$vJ_profile:=New shared object:C1526
	$vJ_prefs.j_profile:=$vJ_profile
	
	
	// ***** Handlers
	// *
	$vJ_handlers:=New shared object:C1526
	$vJ_prefs.j_handlers:=$vJ_handlers
	
	// HOST CONTEXT METHODS
	$vJ_handlers.fu_cs:=Formula:C1597(cs:C1710)  // Get cs from host
	//$vJ_handlers.fu_DIALOG_FORM:=Formula(zenh_DIALOG_FORM)
	$vJ_handlers.fu_SET_MENU_ITEM_ICON:=Formula:C1597(zenh_SET_MENU_ITEM_ICON)
	$vJ_handlers.fu_FORM_GET_PROPERTIES:=Formula:C1597(zenh_FORM_GET_PROPERTIES)
	$vJ_handlers.fu_localized:=Formula:C1597(zenh_localized)  // Get localized string from host
	
	// Views and Records
	$vJ_handlers.fu_list_filter:=Formula:C1597(zenh__list_filter)
	//$vJ_handlers.fu_list_headings:=Formula(zenh_list_headings)
	$vJ_handlers.fu_record_add:=Formula:C1597(zenh_record_add)
	$vJ_handlers.fu_record_newRead:=Formula:C1597(zenh_record_newRead)
	$vJ_handlers.fu_record_newRead_P:=Formula:C1597(zenh_record_newRead_P)
	$vJ_handlers.fu_record_quickview:=Formula:C1597(zenh_record_quickview)
	$vJ_handlers.fu_records_delete:=Formula:C1597(zenh_records_delete)
	
	// Userdata Load & Save
	$vJ_handlers.fu_userData_load:=Formula:C1597(zenh_list_userData_load)
	$vJ_handlers.fu_userData_save:=Formula:C1597(zenh_list_userData_save)
	
	//// ZEN_SCHEMAS export
	//$vJ_handlers.fu_schema:=Formula(zenh_schema_export)
	
	
	// ***** TablesClass Locals — for now TRANSLATIONS
	// *
	zen__localTables_attach($vJ_prefs)
	// *
	// ***** TablesClass
	// *
	$vC_aj_TablesClass:=app_TablesClass_easy()
	zen_TablesClass_relates($vC_aj_TablesClass)  // Add relations fields in tables
	// *
	// ***** At end after all modifications - because of copy()
	$vJ_prefs.aj_TablesClass:=$vC_aj_TablesClass.copy(ck shared:K85:29; $vJ_prefs)
	
	
	// ***** Relations desciption for tree duplicate
	// *
	$vJ_relate_many_dup:=New shared object:C1526()
	$vJ_prefs.j_dup_related_many:=$vJ_relate_many_dup
	zen__add_tree_duplicate($vJ_relate_many_dup; "PRODUCTS"; "PATHS")
	zen__add_tree_duplicate($vJ_relate_many_dup; "PACKS"; "PATHS"; "TEMPLATES"; "BANKS")
	zen__add_tree_duplicate($vJ_relate_many_dup; "BANKS"; "SETS"; "MEDIA")
	zen__add_tree_duplicate($vJ_relate_many_dup; "CATEGORIES"; "PICTURES")  // But not MEDIA
	zen__add_tree_duplicate($vJ_relate_many_dup; "KAVIYAM"; "SLOKAS")  // But not MEDIA
	
	// ***** Catalog parse for duplicate
	// *
	zen__catalog_parse(True:C214; $vJ_prefs)  // Always reload and store
	
	
	// ***** All menuBtns
	// *
	app_initialize_menuBtns($vJ_prefs)  // Attach at .j_menuBtns
	
	
	// *****
	// *
	$vC_afu_4dpop:=New collection:C1472
	$vC_afu_4dpop.push(Formula:C1597(__start))  //; Formula(zzzz_progress))
	$vJ_prefs.afu_4dpop:=$vC_afu_4dpop.copy(ck shared:K85:29; $vJ_prefs)
	// *
	// *****
	
	//$vJ_prefs.t_doc_categories:="doc_categories"
	
End use 

