extends Node

#signal EvidenceCleaningStarted(item:CrimeEvidenceItem)
#signal EvidenceCleaningStopped()
signal EvidenceCleaned(item:CrimeEvidenceItem)

signal FrozePlayerRequested(is_frozen:bool)

signal EvidenceHidden(item:CrimeEvidenceItem)

signal SuspectDetected(body:BodyMotor)
signal SuspectCaught(body:BodyMotor)

signal ChangeMainUIRequested(ui_key:GlobalSettings.UI_KEYS)
