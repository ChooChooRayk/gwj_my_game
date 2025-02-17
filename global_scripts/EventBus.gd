extends Node

signal EvidenceCleaned(item:CrimeEvidenceItem)
signal EvidenceHidden(item:CrimeEvidenceItem)

signal FrozePlayerRequested(is_frozen:bool)

signal SuspectDetected(body:BodyMotor)
signal SuspectCaught(body:BodyMotor)

signal ChangeMainUIRequested(ui_key:GlobalSettings.UI_KEYS)
signal ChangeMainSceneRequested(scene_key:GlobalSettings.SCENE_KEYS)

signal PauseMainSceneRequested(to_pause:bool)
