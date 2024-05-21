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

{ #category : #defaults }
LcsCode class >> defaultCodeDescription [
	self subclassResponsibility
]

{ #category : #defaults }
LcsCode class >> defaultCodeName [
	self subclassResponsibility
]

{ #category : #defaults }
LcsCode class >> defaultInstance [
	^ false
]

{ #category : #defaults }
LcsCode class >> defaultShortName [
	self subclassResponsibility
]

{ #category : #'slot definitions' }
LcsCode class >> isDefaultInstanceSlotDefinition [
	<slotDefinition>
	^ LcsBooleanSlot new
		slotName: 'isDefaultInstance';
		initialValueBlock: [ :codeClass | codeClass  defaultInstance ]; 
		yourself
]

{ #category : #'slot definitions' }
LcsCode class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsParentSlot new
]

{ #category : #'slot definitions' }
LcsCode class >> shortNameSlotDefinition [
	<slotDefinition>
	^ LcsShortNameSlot new
]

{ #category : #accessing }
LcsCode >> codeDescription [
	^ self getValueOfSlotNamed: 'codeDescription' 
]

{ #category : #accessing }
LcsCode >> codeDescription: anObject [
	self setValueOfSlotNamed: 'codeDescription' to: anObject 
]

{ #category : #accessing }
LcsCode >> codeName [
	^ self getValueOfSlotNamed: 'codeName' 
]

{ #category : #accessing }
LcsCode >> codeName: anObject [
	self setValueOfSlotNamed: 'codeName' to: anObject 
]

{ #category : #accessing }
LcsCode >> isDefaultInstance [
	^ self getValueOfSlotNamed: 'isDefaultInstance' 
]

{ #category : #accessing }
LcsCode >> isDefaultInstance: anObject [
	self setValueOfSlotNamed: 'isDefaultInstance' to: anObject 
]

{ #category : #search }
LcsCode >> key [
	^ self codeName
]

{ #category : #accessing }
LcsCode >> shortName [
	^ self getValueOfSlotNamed: 'shortName' 
]

{ #category : #accessing }
LcsCode >> shortName: anObject [
	self setValueOfSlotNamed: 'shortName' to: anObject 
]
