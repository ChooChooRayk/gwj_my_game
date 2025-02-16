extends Node

#signal EvidenceCleaningStarted(item:CrimeEvidenceItem)
#signal EvidenceCleaningStopped()
signal EvidenceCleaned(item:CrimeEvidenceItem)

signal FrozePlayerRequested(is_frozen:bool)

signal EvidenceHidden(item:CrimeEvidenceItem)
