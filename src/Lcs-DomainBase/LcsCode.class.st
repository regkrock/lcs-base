Class {
	#name : #LcsCode,
	#superclass : #LcsDomainObject,
	#instVars : [
		'codeName',
		'shortName',
		'codeDescription',
		'isDefaultInstance'
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
LcsCode >> isDefaultInstance [
	^ self getValueOfSlotNamed: 'isDefaultInstance' 
]

{ #category : #accessing }
LcsCode >> isDefaultInstance: anObject [
	self setValueOfSlotNamed: 'isDefaultInstance' to: anObject 
]

{ #category : #accessing }
LcsCode >> isDefaultInstanceSlotDefinition [
	<slotDefinition>
	^ LcsBooleanSlot new
		slotName: 'isDefaultInstance';
		yourself
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
