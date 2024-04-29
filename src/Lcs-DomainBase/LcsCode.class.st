Class {
	#name : #LcsCode,
	#superclass : #LcsDomainObject,
	#instVars : [
		'codeName',
		'shortName',
		'codeDescription'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #accessing }
LcsCode >> codeDescriptionSlotDefinition [
	<slotDefinition>
	^ LcsCodeDescriptionSlot new
]

{ #category : #accessing }
LcsCode >> codeNameSlotDefinition [
	<slotDefinition>
	^ LcsCodeNameSlot new
]

{ #category : #accessing }
LcsCode >> parentSlotDefinition [
	^ LcsParentSlot new
]

{ #category : #accessing }
LcsCode >> shortNameSlotDefinition [
	<slotDefinition>
	^ LcsShortNameSlot new
]
