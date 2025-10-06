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
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'gt views' }
LcsMemberOfSlot >> addOtherSlotDefinitionDetailsTo: collection [
	super addOtherSlotDefinitionDetailsTo: collection.
	collection
		add: '' -> '';
		add: '------Source Collection Info------' -> ''.
	collection add: 'source collection' ->self targetCollection.
	collection add: 'source module' -> self collectionModule
]

{ #category : #'slot model' }
LcsMemberOfSlot >> assignParent: aDomainObject to: newValue [
	"Parent has already been assigned"
]

{ #category : #'application environment' }
LcsMemberOfSlot >> collectionModule [
	^ self currentSystem moduleNamed: self collectionSlotModuleName
]

{ #category : #properties }
LcsMemberOfSlot >> collectionSlotModuleName [
	^ self propertyAt: 'collectionSlotModuleName' ifAbsent: [ ]
]

{ #category : #properties }
LcsMemberOfSlot >> collectionSlotModuleName: aString [ 
	self propertyAt: 'collectionSlotModuleName' put: aString
]

{ #category : #properties }
LcsMemberOfSlot >> collectionSlotName [
	^ self propertyAt: 'collectionSlotName' ifAbsent: []
]

{ #category : #properties }
LcsMemberOfSlot >> collectionSlotName: aString [ 
	self propertyAt: 'collectionSlotName' put: aString
]

{ #category : #'slot model' }
LcsMemberOfSlot >> defaultInstance [
	^ self targetCollection 
		ifNil: [ LcsMemberOfSlotSourceCollectionNotInitialized signalWithContext: self ] 
		ifNotNil: [ :collection | collection defaultInstance ]
]

{ #category : #initialize }
LcsMemberOfSlot >> initialize [
	super initialize.
	self beRequired.
	self initialValueBlock: [:domainParent | self defaultInstance ]
]

{ #category : #message }
LcsMemberOfSlot >> sourceCollectionNotPopulatedMessage [
	^'Source collection in module: ''<1s>'', slot: ''<2s>'' not initialized' 
			expandMacrosWith: self collectionSlotModuleName 
			with: self collectionSlotName
]

{ #category : #'slot model' }
LcsMemberOfSlot >> targetCollection [
	^ self collectionModule perform: self collectionSlotName asSymbol
]
