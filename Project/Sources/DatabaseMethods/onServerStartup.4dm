
// *****
// *
SET DATABASE PARAMETER:C642(4D Server log recording:K37:28; 0)  //Starts or stops the recording of standard requests received by 4D Server (excluding Web requests).
SET DATABASE PARAMETER:C642(Debug log recording:K37:34; 0)  // Starts or stops the sequential recording of events occurring at the 4D programming level in the 4DDebugLog
SET DATABASE PARAMETER:C642(Remote connection sleep timeout:K37:106; 3600)  // if the client is inactive for more than 1 hour it will be kicked out

// ***** TO DO ONCE, AT STARTUP, IN THIS ORDER
// *
SET DATABASE LOCALIZATION:C1104("EN")
app_initRegister_ogt()  // Register & initialize ogTools Suite
app_initialize_waz()  // User waz widgets tuning
app_initRegister()  // Before zen to have a good .j_prefs
app_initialize_zen()  // Host zen_Nucleus initialisations


zen_dashboard_init_upd(True:C214)  // Be sure there is a proper ZEN_DASHBOARD record
zen_profiles_init_upd(True:C214)  // Be sure there is proper ZEN_POPUPS records
zen_users_init_upd(True:C214)  // Be sure we have at list SUPER_USER and SUPER_GROUP, and profile upd
// *
// *****


//If (Not(Is compiled mode))
// ***** Import from RSC folder flat all files with correct name's format
// * copy to "lists_json", if not already exists in it and delete source files.
//zen_lists_IMPORT()

// ***** Import from RSC folder flat all files with correct name's format
// * copy to "menus_json", if not already exists in it and delete source files.
//zen_menus_IMPORT()

// ***** Take from RSC folder "menus_json" and "lists_json"
// * copy to a folder near data named "zen_json" with those subfolders
//zen_listsMenus_IMPORT()
//End if

app_initialize_CRONs()  // CRONs definition on server
zen_CRONs_launcher()  // Launch CRONs processes

