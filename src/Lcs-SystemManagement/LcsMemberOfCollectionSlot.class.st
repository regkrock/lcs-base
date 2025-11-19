Class {
	#name : 'LcsMemberOfCollectionSlot',
	#superclass : 'LcsDomainObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'gt views' }
LcsMemberOfCollectionSlot >> addOtherSlotDefinitionDetailsTo: collection [
	super addOtherSlotDefinitionDetailsTo: collection
]

{ #category : 'slot model' }
LcsMemberOfCollectionSlot >> assignParent: aDomainObject to: newValue [
	"Parent has already been assigned"
]

{ #category : 'defaults' }
LcsMemberOfCollectionSlot >> defaultInitialValueBlock [
	^ [:parentDomainObject :slot | slot defaultInstance ]
]

{ #category : 'slot model' }
LcsMemberOfCollectionSlot >> defaultInstance [
	^ self targetCollection 
		ifNil: [ LcsMemberOfSlotSourceCollectionNotInitialized signalWithContext: self ] 
		ifNotNil: [ :collection | collection defaultInstance ]
]

{ #category : 'defaults' }
LcsMemberOfCollectionSlot >> initialize [
	super initialize.
	self beRequired
]

{ #category : 'message' }
LcsMemberOfCollectionSlot >> sourceCollectionNotPopulatedMessage [
	^'Source collection in module: ''<1s>'', slot: ''<2s>'' not initialized' 
			expandMacrosWith: self collectionSlotModuleName 
			with: self collectionSlotName
]

{ #category : 'slot model' }
LcsMemberOfCollectionSlot >> targetCollection [
	^ self collectionModule perform: self collectionSlotName asSymbol
]
