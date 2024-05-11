Class {
	#name : #LcsMemberOfSlot,
	#superclass : #LcsSlotDefintion,
	#instVars : [
		'collectionSourceBlock',
		'collectionSlotName',
		'moduleName'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'application environment' }
LcsMemberOfSlot >> collectionModule [
	^ self currentSystem moduleNamed: self moduleName
]

{ #category : #accessing }
LcsMemberOfSlot >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #accessing }
LcsMemberOfSlot >> collectionSlotName: aString [ 
	collectionSlotName := aString
]

{ #category : #accessing }
LcsMemberOfSlot >> defaultInstance [
	^ ((self currentSystem moduleNamed: self moduleName)
		perform: self collectionSlotName asSymbol) defaultInstance
]

{ #category : #initialize }
LcsMemberOfSlot >> initialize [
	super initialize.
	self beRequired.
	self initialValueBlock: [ self defaultInstance ]
]

{ #category : #accessing }
LcsMemberOfSlot >> moduleName [
	^ moduleName
]

{ #category : #accessing }
LcsMemberOfSlot >> moduleName: aString [ 
	moduleName := aString
]
