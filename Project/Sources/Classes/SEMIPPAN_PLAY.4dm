
Class constructor
	
	
	// ***** PACKS
	// *
Function do_PACK_PLAY($cES_PATHS : cs:C1710.PATHSSelection; $cE_PACKS : cs:C1710.PACKSEntity; $cES_BANKS : cs:C1710.BANKSSelection; $is_delete : Boolean)
	var $c4Fo_root : 4D:C1709.Folder
	var $isOk : Boolean
	var $vC_at_paths_inex : Collection
	var $cE_PATHS : cs:C1710.PATHSEntity
	var $vL_PATHS_tt; $vL_BANKS_tt; $vL_winRef : Integer
	var $vJ_this; $vJ_PACK_alColors : Object
	var $vT_msg; $vT_worker; $vT_icon : Text
	$vL_PATHS_tt:=$cES_PATHS.length
	$vL_BANKS_tt:=$cES_BANKS.length
	$vT_msg:="PATHS ("+String:C10($vL_PATHS_tt)+"), BANKS ("+String:C10($vL_BANKS_tt)+")"
	If ($vL_PATHS_tt=0) || ($vL_BANKS_tt=0)
		waz_io_alert_popup("No selection: "+$vT_msg+" !"; "stop")
	Else 
		$vT_icon:=$is_delete ? "delete" : "accept"
		$isOk:=waz_io_confirm_popup("Play "+$vT_msg+" ?"; $vT_icon)
	End if 
	If ($isOk)
		$vC_at_paths_inex:=New collection:C1472()
		For each ($cE_PATHS; $cES_PATHS)
			$c4Fo_root:=sem_PATHS_path($cE_PATHS)
			If (Not:C34($c4Fo_root.exists))
				$vC_at_paths_inex.push($c4Fo_root.path)
			End if 
		End for each 
		If ($vC_at_paths_inex.length#0)
			$isOk:=waz_io_confirm("Some paths not found, continue (will be created)?"; $vC_at_paths_inex.join(Char:C90(Carriage return:K15:38)))
		End if 
		
		If ($isOk)
			$vL_winRef:=Current form window:C827
			$vJ_PACK_alColors:=$cE_PACKS.j_alColors
			$vT_worker:="do_PACK_PLAY"+String:C10($vL_winRef)
			$vJ_this:=This:C1470
			CALL WORKER:C1389($vT_worker; Formula:C1597($vJ_this._do_PACK_PLAY($1; $2; $3; $4; $5)); $cES_PATHS; $vJ_PACK_alColors; $cES_BANKS; $is_delete; $vL_winRef)
		End if 
	End if 
	
	
Function _do_PACK_PLAY($cES_PATHS : cs:C1710.PATHSSelection; $vJ_PACK_alColors : Object; $cES_BANKS : cs:C1710.BANKSSelection; $is_delete : Boolean; $vL_winRef : Integer)
	var $c4Fi_file : 4D:C1709.File
	var $c4Fo_root; $c4Fo_path : 4D:C1709.Folder
	var $is_PATHS_external; $is_SETS_external : Boolean
	var $cE_BANKS : cs:C1710.BANKSEntity
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	var $cE_PATHS : cs:C1710.PATHSEntity
	var $cE_SETS : cs:C1710.SETSEntity
	var $cES_SETS : cs:C1710.SETSSelection
	var $vL_SETS_tt; $vL_MEDIA_tt : Integer
	var $vL_count_total; $vL_count; $vL_PATHS_tt; $vL_colors_in : Integer
	var $vT_fileName : Text
	var $vO_picture : Picture
	var $cES_MEDIA : cs:C1710.MEDIASelection
	var $vJ_this : Object
	var $vR_coef : Real
	
	$vJ_this:=This:C1470
	$vR_coef:=0
	CALL FORM:C1391($vL_winRef; Formula:C1597($vJ_this.form_progress($1)); $vR_coef)
	// Calculate count total for progress
	$vL_count_total:=0
	$vL_PATHS_tt:=$cES_PATHS.length
	For each ($cE_BANKS; $cES_BANKS)
		$cES_SETS:=$cE_BANKS.BANKS_SETS.query("isActive = true")
		$cES_MEDIA:=$cE_BANKS.BANKS_MEDIA.query("isActive = true")
		$vL_SETS_tt:=$cES_SETS.length
		$vL_MEDIA_tt:=$cES_MEDIA.length
		$vL_count_total+=($vL_SETS_tt*$vL_MEDIA_tt)
	End for each 
	$vL_count_total*=$vL_PATHS_tt
	
	
	$vL_count:=0
	For each ($cE_PATHS; $cES_PATHS)
		$c4Fo_root:=sem_PATHS_path($cE_PATHS)
		$is_PATHS_external:=$cE_PATHS.isExternalPath
		
		For each ($cE_BANKS; $cES_BANKS)
			$cES_MEDIA:=$cE_BANKS.BANKS_MEDIA.query("isActive = true").orderBy("fileName")
			$cES_SETS:=$cE_BANKS.BANKS_SETS.query("isActive = true").orderBy("fileStart")
			$vL_SETS_tt:=$cES_SETS.length
			For each ($cE_SETS; $cES_SETS)
				$is_SETS_external:=$cE_SETS.j_options.isExternalPath
				If ($is_PATHS_external=$is_SETS_external)
					$c4Fo_path:=sem_BANKS_SETS_path($c4Fo_root; $cE_BANKS; $cE_SETS)
					$vL_MEDIA_tt:=$cES_MEDIA.length
					For each ($cE_MEDIA; $cES_MEDIA)
						$vT_fileName:=sem_MEDIA_fileName($cE_BANKS; $cE_SETS; $cE_MEDIA)
						$c4Fi_file:=$c4Fo_path.file($vT_fileName)
						If ($is_delete)
							If ($c4Fi_file.exists)
								$c4Fi_file.delete()
							End if 
						Else 
							$c4Fi_file.parent.create()
							$cE_BANKS:=$cE_SETS.SETS_BANKS
							$vL_colors_in:=woc_sp_colors_from_alColorsIdx($vJ_PACK_alColors; $cE_BANKS.colorsIdx)
							$vO_picture:=sem_media_calculate($cE_SETS; $cE_MEDIA; $vL_colors_in)  // Horizontal concatenation)
							WRITE PICTURE FILE:C680($c4Fi_file.platformPath; $vO_picture)
						End if 
						$vL_count+=1
						$vR_coef:=$vL_count/$vL_count_total
						CALL FORM:C1391($vL_winRef; Formula:C1597($vJ_this.form_progress($1)); $vR_coef)
					End for each 
				End if 
			End for each 
		End for each 
	End for each 
	$vR_coef:=1
	CALL FORM:C1391($vL_winRef; Formula:C1597($vJ_this.form_progress($1)); $vR_coef)
	wox_sounds_play_done()
	// *
	// *****
	
	
	
	
	// ***** BANKS
	// *
Function do_BANK_PLAY($cES_PATHS : cs:C1710.PATHSSelection; $cE_PACKS : cs:C1710.PACKSEntity; $cE_BANKS : cs:C1710.BANKSEntity; $cES_SETS : cs:C1710.SETSSelection; $cES_MEDIA : cs:C1710.MEDIASelection; $is_delete : Boolean)
	var $c4Fo_root : 4D:C1709.Folder
	var $isOk : Boolean
	var $vC_at_paths_inex : Collection
	var $cE_PATHS : cs:C1710.PATHSEntity
	var $vL_PATHS_tt; $vL_SETS_tt; $vL_MEDIA_tt; $vL_winRef : Integer
	var $vT_msg; $vT_worker; $vT_icon : Text
	var $vJ_this; $vJ_PACK_alColors : Object
	var $vV_BANK_UID : Variant
	
	$vL_PATHS_tt:=$cES_PATHS.length
	$vL_SETS_tt:=$cES_SETS.length
	$vL_MEDIA_tt:=$cES_MEDIA.length
	$isOk:=False:C215
	$vT_msg:="PATHS ("+String:C10($vL_PATHS_tt)+"), SETS ("+String:C10($vL_SETS_tt)+"), MEDIA ("+String:C10($vL_MEDIA_tt)+")"
	If ($vL_PATHS_tt=0) || ($vL_SETS_tt=0) || ($vL_MEDIA_tt=0)
		waz_io_alert_popup("No selection: "+$vT_msg+" !"; "stop")
	Else 
		$vT_icon:=$is_delete ? "delete" : "accept"
		$isOk:=waz_io_confirm_popup("Play "+$vT_msg+" ?"; $vT_icon)
	End if 
	
	If ($isOk)
		$vC_at_paths_inex:=New collection:C1472()
		For each ($cE_PATHS; $cES_PATHS)
			$c4Fo_root:=sem_PATHS_path($cE_PATHS)
			If (Not:C34($c4Fo_root.exists))
				$vC_at_paths_inex.push($c4Fo_root.path)
			End if 
		End for each 
		If ($vC_at_paths_inex.length#0)
			$isOk:=waz_io_confirm("Some paths not found, continue (will be created)?"; $vC_at_paths_inex.join(Char:C90(Carriage return:K15:38)))
		End if 
		
		If ($isOk)
			$vL_winRef:=Current form window:C827
			$vT_worker:="do_BANK_PLAY"+String:C10($vL_winRef)
			$vJ_this:=This:C1470
			$vV_BANK_UID:=$cE_BANKS.UID
			$vJ_PACK_alColors:=$cE_PACKS.j_alColors
			CALL WORKER:C1389($vT_worker; Formula:C1597($vJ_this._do_BANK_PLAY($1; $2; $3; $4; $5; $6; $7)); $cES_PATHS; $vJ_PACK_alColors; $vV_BANK_UID; $cES_SETS; $cES_MEDIA; $is_delete; $vL_winRef)
		End if 
	End if 
	
	
Function _do_BANK_PLAY($cES_PATHS : cs:C1710.PATHSSelection; $vJ_PACK_alColors : Object; $vV_BANK_UID : Variant; $cES_SETS : cs:C1710.SETSSelection; $cES_MEDIA : cs:C1710.MEDIASelection; $is_delete : Boolean; $vL_winRef : Integer)
	var $c4Fi_file : 4D:C1709.File
	var $c4Fo_root; $c4Fo_path : 4D:C1709.Folder
	var $is_PATHS_external; $is_SETS_external : Boolean
	var $cE_MEDIA : cs:C1710.MEDIAEntity
	var $cE_PATHS : cs:C1710.PATHSEntity
	var $cE_SETS : cs:C1710.SETSEntity
	var $vL_PATHS_tt; $vL_SETS_tt; $vL_MEDIA_tt; $vL_count_total; $vL_count; $vL_colors_in : Integer
	var $vJ_this : Object
	var $vO_picture : Picture
	var $vR_coef : Real
	var $vT_fileName : Text
	var $cE_BANKS : cs:C1710.BANKSEntity
	
	$vJ_this:=This:C1470
	$vR_coef:=0
	CALL FORM:C1391($vL_winRef; Formula:C1597($vJ_this.form_progress($1)); $vR_coef)
	
	$cE_BANKS:=ds:C1482.BANKS.get($vV_BANK_UID)
	If ($cE_BANKS#Null:C1517)
		$vL_colors_in:=woc_sp_colors_from_alColorsIdx($vJ_PACK_alColors; $cE_BANKS.colorsIdx)
		// Calculate count total for progress
		$vL_PATHS_tt:=$cES_PATHS.length
		$vL_SETS_tt:=$cES_SETS.length
		$vL_MEDIA_tt:=$cES_MEDIA.length
		$vL_count_total:=$vL_PATHS_tt*($vL_SETS_tt*$vL_MEDIA_tt)
		
		For each ($cE_PATHS; $cES_PATHS)
			$c4Fo_root:=sem_PATHS_path($cE_PATHS)
			$is_PATHS_external:=$cE_PATHS.isExternalPath
			
			For each ($cE_SETS; $cES_SETS)
				$is_SETS_external:=$cE_SETS.j_options.isExternalPath
				If ($is_PATHS_external=$is_SETS_external)
					$c4Fo_path:=sem_BANKS_SETS_path($c4Fo_root; $cE_BANKS; $cE_SETS)
					For each ($cE_MEDIA; $cES_MEDIA)
						$vT_fileName:=sem_MEDIA_fileName($cE_BANKS; $cE_SETS; $cE_MEDIA)
						$c4Fi_file:=$c4Fo_path.file($vT_fileName)
						If ($is_delete)
							If ($c4Fi_file.exists)
								$c4Fi_file.delete()
							End if 
						Else 
							$c4Fi_file.parent.create()
							$vO_picture:=sem_media_calculate($cE_SETS; $cE_MEDIA; $vL_colors_in)  // Horizontal concatenation)
							WRITE PICTURE FILE:C680($c4Fi_file.platformPath; $vO_picture)
						End if 
						$vL_count+=1
						$vR_coef:=$vL_count/$vL_count_total
						CALL FORM:C1391($vL_winRef; Formula:C1597($vJ_this.form_progress($1)); $vR_coef)
					End for each 
				End if 
			End for each 
		End for each 
		$vR_coef:=1
		CALL FORM:C1391($vL_winRef; Formula:C1597($vJ_this.form_progress($1)); $vR_coef)
		wox_sounds_play_done()
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function form_progress($vR_coef : Real)
	var $vJ_progress : Object
	$vJ_progress:=OBJECT Get value:C1743("waz_progress")
	$vJ_progress.r_value:=$vR_coef
	$vJ_progress.redraw()
	// *
	// *****
	
	
	// How to set an icon to a io_progress
	//$c4Fo_icons:=Folder(fk resources folder).folder("metier")
	//$c4Fi_PATHS:=$c4Fo_icons.file("icn_progress_paths"+k_png_ext)
	//$c4Fi_BANKS:=$c4Fo_icons.file("icn_progress_banks"+k_png_ext)
	//$c4Fi_SETS:=$c4Fo_icons.file("icn_progress_sets"+k_png_ext)
	//$c4Fi_MEDIA:=$c4Fo_icons.file("icn_progress_media"+k_png_ext)
	//$vT_progress_PATHS_uid:=waz_progress_new("PATHS")
	//waz_progress_setIcon($vT_progress_PATHS_uid; $c4Fi_PATHS)
	//$vT_progress_BANKS_uid:=waz_progress_new("BANKS")
	//waz_progress_setIcon($vT_progress_BANKS_uid; $c4Fi_BANKS)
	//$vT_progress_SETS_uid:=waz_progress_new("SETS")
	//waz_progress_setIcon($vT_progress_SETS_uid; $c4Fi_SETS)
	//$vT_progress_MEDIA_uid:=waz_progress_new("MEDIA")
	//waz_progress_setIcon($vT_progress_MEDIA_uid; $c4Fi_MEDIA)
	
	