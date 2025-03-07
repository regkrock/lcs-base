"
This defines a slot where the content of the slot is a member of a collection.

The slot is responsible for:
1) defining the location of the collection - module and slot name
2) the defualt instance used to initialize the slot to when it is created.

Note: Currently this is defined to look up a value in a global collection.
"
Class {
	#name : #LcsMemberOfSlot,
	#superclass : #LcsDomainObjectSlot,
	#instVars : [
		'collectionSourceBlock',
		'collectionSlotName',
		'collectionSlotModuleName'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LcsMemberOfSlot >> assignParent: aDomainObject to: newValue [
	"Parent has already been assigned"
]

{ #category : #'application environment' }
LcsMemberOfSlot >> collectionModule [
	^ self currentSystem moduleNamed: self collectionSlotModuleName
]

{ #category : #accessing }
LcsMemberOfSlot >> collectionSlotModuleName [
	^ collectionSlotModuleName
]

{ #category : #accessing }
LcsMemberOfSlot >> collectionSlotModuleName: aString [ 
	collectionSlotModuleName := aString
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
	^ self targetCollection defaultInstance
]

{ #category : #initialize }
LcsMemberOfSlot >> initialize [
	super initialize.
	self beRequired.
	self initialValueBlock: [:domainParent | self defaultInstance ]
]

{ #category : #accessing }
LcsMemberOfSlot >> targetCollection [
	^ self collectionModule perform: self collectionSlotName asSymbol
]
