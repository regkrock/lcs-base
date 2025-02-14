Class {
	#name : #LcsCode,
	#superclass : #LcsDomainObject,
	#instVars : [
		'codeName',
		'shortName',
		'codeDescription',
		'isDefaultInstance'
	],
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #'slot definitions' }
LcsCode class >> codeDescriptionSlotDefinition [
	<slotDefinition>
	^ LcsCodeDescriptionSlot new
]

{ #category : #'slot definitions' }
LcsCode class >> codeNameSlotDefinition [
	<slotDefinition>
	^ LcsCodeNameSlot new
]

{ #category : #'slot definitions' }
LcsCode class >> isDefaultInstanceSlotDefinition [
	<slotDefinition>
	^ LcsBooleanSlot new
		slotName: 'isDefaultInstance';
		yourself
]

{ #category : #'slot definitions' }
LcsCode class >> shortNameSlotDefinition [
	<slotDefinition>
	^ LcsShortNameSlot new
]

{ #category : #accessing }
LcsCode >> codeDescription [
	^ self slotVarNamed: 'codeDescription' 
]

{ #category : #accessing }
LcsCode >> codeDescription: anObject [
	self slotVarNamed: 'codeDescription' put: anObject 
]

{ #category : #accessing }
LcsCode >> codeName [
	^ self slotVarNamed: 'codeName' 
]

{ #category : #accessing }
LcsCode >> codeName: anObject [
	self slotVarNamed: 'codeName' put: anObject 
]

{ #category : #accessing }
LcsCode >> isDefaultInstance [
	^ self slotVarNamed: 'isDefaultInstance' 
]

{ #category : #accessing }
LcsCode >> isDefaultInstance: anObject [
	self slotVarNamed: 'isDefaultInstance' put: anObject 
]

{ #category : #search }
LcsCode >> key [
	^ self codeName
]

{ #category : #accessing }
LcsCode >> shortName [
	^ self slotVarNamed: 'shortName' 
]

{ #category : #accessing }
LcsCode >> shortName: anObject [
	self slotVarNamed: 'shortName' put: anObject 
]
