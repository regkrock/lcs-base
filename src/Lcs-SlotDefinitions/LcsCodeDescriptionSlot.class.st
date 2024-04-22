Class {
	#name : #LcsCodeDescriptionSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsCodeDescriptionSlot >> initialize [
	super initialize.
	self slotName: 'codeDescription'
]
