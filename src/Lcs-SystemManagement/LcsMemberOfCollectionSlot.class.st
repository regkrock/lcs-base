Class {
	#name : 'LcsMemberOfCollectionSlot',
	#superclass : 'LcsDomainObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'slot model' }
LcsMemberOfCollectionSlot >> assignParent: aDomainObject to: newValue [
	"Parent has already been assigned"
]

{ #category : 'defaults' }
LcsMemberOfCollectionSlot >> defaultInitialValueBlock [
	^ [:parentDomainObject :slot | slot defaultInstance ]
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
