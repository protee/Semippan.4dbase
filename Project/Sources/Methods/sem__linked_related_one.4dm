//%attributes = {}
// *****
// *
// Method: zen_linked_related_ones
// Olivier Grimbert — Protée sarl — 04/05/2026 15:33:45
//
// Description: Based on DataModel chain in Form : {j_parent, c4E, ...}
// Giving a ordaPath to go through links.
// Will propagate and check at each step if
// j_parent.c4E is same DataClass, with same UID as foreignKey
// if yes, it will use this Entity rather than the one from the link.
// If no, it will be the link till the end.
// This makes you get the real Entities open in the chain and not the one in the database
// You see your edited Entity, and it works for new created Entity even not stored.
// If an Entity is not found (bad link), a Null is returned for this Entity.
//
// Date       | Who | Comment
// 04/05/2026 | OG  | Updated
// *
// *****

#DECLARE($vT_ordaPath : Text)->$vC_c4E_related : Collection
var $c4DC_related; $c4DC_parent : 4D:C1709.DataClass
var $c4E_parent; $c4E_related : 4D:C1709.Entity
var $is_parent; $isOk : Boolean
var $vC_at_ordaPath : Collection
var $idx : Integer
var $vJ_field; $vJ_parent; $vJ_relatedInfo; $vJ_parentInfo; $vJ_form : Object
var $vT_relateOne; $vT_kind; $vT_table; $vT_primaryKey : Text
var $vV_UID_related; $vV_UID_parent : Variant

$vJ_form:=Form:C1466
$c4E_related:=$vJ_form.c4E
$c4DC_related:=$c4E_related.getDataClass()
$vJ_parent:=$vJ_form

$vC_at_ordaPath:=Split string:C1554($vT_ordaPath; ".")
$vC_c4E_related:=New collection:C1472()
$is_parent:=True:C214
$isOk:=False:C215
$idx:=0
For each ($vT_relateOne; $vC_at_ordaPath)
	$vJ_field:=$c4DC_related[$vT_relateOne]
	$isOk:=$vJ_field#Null:C1517
	If ($isOk)
		$vT_kind:=$vJ_field.kind
		$isOk:=$vT_kind="relatedEntity"
		If ($isOk)
			$c4E_related:=$c4E_related[$vT_relateOne]
			If ($c4E_related#Null:C1517)
				$vT_table:=$vJ_field.relatedDataClass
				$c4DC_related:=zen__ds[$vT_table]
				If ($is_parent)
					$vJ_parent:=$vJ_parent.j_parent
					$is_parent:=$vJ_parent#Null:C1517
					If ($is_parent)
						$c4E_parent:=$vJ_parent.c4E
						$is_parent:=$c4E_parent#Null:C1517
						If ($is_parent)
							$c4DC_parent:=$c4E_parent.getDataClass()
							$vJ_relatedInfo:=$c4DC_related.getInfo()
							$vJ_parentInfo:=$c4DC_parent.getInfo()
							$is_parent:=$vJ_relatedInfo.name=$vJ_parentInfo.name
							If ($is_parent)
								$vT_primaryKey:=$vJ_relatedInfo.primaryKey
								If ($is_parent)
									$vV_UID_related:=$c4E_related[$vT_primaryKey]
									$vV_UID_parent:=$c4E_parent[$vT_primaryKey]
									$is_parent:=($vV_UID_related=$vV_UID_parent)
									If ($is_parent)
										$c4E_related:=$c4E_parent
									End if 
								End if 
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
	End if 
	$vC_c4E_related.push($isOk ? $c4E_related : Null:C1517)
	$idx+=1
End for each 
