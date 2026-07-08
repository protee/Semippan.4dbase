//%attributes = {"lang":"en"}

var $vL_appType : Integer
var $vJ_profile : Object
var $vT_startup_screen : Text
var $is_developer : Boolean
var $cE_zen_users : cs:C1710.ZEN_USERSEntity

// ***** TO DO ONCE, AT STARTUP, IN THIS ORDER ‼️‼️
// *
SET DATABASE LOCALIZATION:C1104("EN")
app_initRegister_ogt()  // Register & initialize ogTools Suite
app_initialize_waz()  // User waz widgets tuning
app_initRegister()  // Before zen to have a good .j_prefs
app_initialize_zen()  // Host zen_Nucleus initialisations
app_initRegister_after()  // DEV components

zen_dashboard_init_upd(True:C214)  // Be sure there is a proper ZEN_DASHBOARD record
zen_profiles_init_upd(True:C214)  // Be sure there is proper ZEN_POPUPS records
zen_users_init_upd()  // Be sure we have at list SUPER_USER and SUPER_GROUP


// ***** CRON process launcher
// *
app_initialize_CRONs()  // Even in client, needed for the CRON_mng
$vL_appType:=Application type:C494
If ($vL_appType#4D Remote mode:K5:5)  // in monoposte, launch CRONs, else done on server startup
	zen_CRONs_launcher()  // Launch CRONs processes
End if 



// ***** LOGIN
// *
$cE_zen_users:=zen_login()  // Autologin if One user, with "" password
If ($cE_zen_users#Null:C1517)
	zen_profile_update($cE_zen_users)
	
	$vJ_profile:=zen__storage_profile()
	$is_developer:=$vJ_profile.is_developer
	If (Not:C34($is_developer))
		SET ABOUT:C316(zen_get_localized(k_rsct_menu; "about"); "Z_about")
	End if 
	$vT_startup_screen:=zen__storage_prefs().t_startup_screen
	CALL WORKER:C1389($vT_startup_screen; "zenh__worker")
	
Else 
	If (Is compiled mode:C492(*))  // Host compiled ? Quit
		QUIT 4D:C291
		
	Else   // For dev only
		$vT_startup_screen:=zen__storage_prefs().t_startup_screen
		CALL WORKER:C1389($vT_startup_screen; "zenh__worker")
		waz_io_alert_popup("Login: not connected!")
	End if 
End if 
// *
// *****

