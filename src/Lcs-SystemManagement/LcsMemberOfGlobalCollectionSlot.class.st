"
This defines a slot where the content of the slot is a member of a collection.

The slot is responsible for:
1) defining the location of the collection - module and slot name
2) the defualt instance used to initialize the slot to when it is created.

Note: Currently this is defined to look up a value in a global collection.
"
Class {
	#name : #LcsMemberOfGlobalCollectionSlot,
	#superclass : #LcsMemberOfCollectionSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'gt views' }
LcsMemberOfGlobalCollectionSlot >> addOtherSlotDefinitionDetailsTo: collection [
	super addOtherSlotDefinitionDetailsTo: collection.
	collection
		add: '' -> '';
		add: '------Source Collection Info------' -> ''.
	collection add: 'source collection' ->self targetCollection.
	collection add: 'source module' -> self collectionModule
]

{ #category : #'slot model' }
LcsMemberOfGlobalCollectionSlot >> collectionModule [
	^ self currentSystem moduleNamed: self collectionSlotModuleName
]

{ #category : #properties }
LcsMemberOfGlobalCollectionSlot >> collectionSlotModuleName [
	^ self propertyAt: 'collectionSlotModuleName' ifAbsent: [ ]
]

{ #category : #properties }
LcsMemberOfGlobalCollectionSlot >> collectionSlotModuleName: aString [ 
	self propertyAt: 'collectionSlotModuleName' put: aString
]

{ #category : #properties }
LcsMemberOfGlobalCollectionSlot >> collectionSlotName [
	^ self propertyAt: 'collectionSlotName' ifAbsent: []
]

{ #category : #properties }
LcsMemberOfGlobalCollectionSlot >> collectionSlotName: aString [ 
	self propertyAt: 'collectionSlotName' put: aString
]

{ #category : #message }
LcsMemberOfGlobalCollectionSlot >> sourceCollectionNotPopulatedMessage [
	^'Source collection in module: ''<1s>'', slot: ''<2s>'' not initialized' 
			expandMacrosWith: self collectionSlotModuleName 
			with: self collectionSlotName
]

{ #category : #'slot model' }
LcsMemberOfGlobalCollectionSlot >> targetCollection [
	^ self collectionModule perform: self collectionSlotName asSymbol
]
