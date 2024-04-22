Class {
	#name : #LcsMemberOfSlotBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#instVars : [
		'collectionSlotName',
		'moduleName',
		'slotTypes'
	],
	#category : #'Lcs-Tools'
}

{ #category : #deafult }
LcsMemberOfSlotBuilder class >> slotDefinitionClass [
	^ LcsMemberOfSlot
]

{ #category : #api }
LcsMemberOfSlotBuilder >> addSlotDefinitionSourceDetailsTo: codeStream [
	self slotTypes do: [ :eachSlotTypeClass |
		codeStream addSetter: 'addSlotType' contents: eachSlotTypeClass name].
	codeStream
		addSetter: 'collectionSlotName' contents: self collectionSlotName printString;
		addSetter: 'moduleName' contents: self moduleName printString
.
	
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> addSlotType: aClass [
	(self slotTypes includes: aClass) ifFalse: [ self slotTypes add: aClass ]
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSlotName: anObject [
	collectionSlotName := anObject
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> initialize [
	super initialize.
	self slotTypes: OrderedCollection new
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> moduleName [
	^ moduleName
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> moduleName: anObject [
	moduleName := anObject
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> slotTypes [
	^ slotTypes
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> slotTypes: anObject [
	slotTypes := anObject
]
