Class {
	#name : 'LcsMemberOfCollectionSlot',
	#superclass : 'LcsDomainObjectSlot',
	#instVars : [
		'displayStringBlock',
		'optionValueBlock'
	],
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'slot model' }
LcsMemberOfCollectionSlot >> assignParent: aDomainObject to: newValue [
	"Parent has already been assigned"
]

{ #category : 'defaults' }
LcsMemberOfCollectionSlot >> defaultDisplayStringlock [
	^ [:object :slot | object displayString ]
]

{ #category : 'defaults' }
LcsMemberOfCollectionSlot >> defaultInitialValueBlock [
	^ [:parentDomainObject :slot | slot defaultInstance ]
]

{ #category : 'defaults' }
LcsMemberOfCollectionSlot >> defaultOptionValueBlock [
	^ [:object :slot | object displayString ]
]

{ #category : 'accessing' }
LcsMemberOfCollectionSlot >> displayStringBlock [
	^ displayStringBlock
]

{ #category : 'accessing' }
LcsMemberOfCollectionSlot >> displayStringBlock: anObject [
	displayStringBlock := anObject
]

{ #category : 'defaults' }
LcsMemberOfCollectionSlot >> initialize [
	super initialize.
	self
		displayStringBlock: self defaultDisplayStringlock;
		optionValueBlock: self defaultOptionValueBlock;
		beRequired
]

{ #category : 'queries' }
LcsMemberOfCollectionSlot >> optionDisplayStringFor: aModel [
	^ self displayStringBlock cull: aModel cull: self
]

{ #category : 'accessing' }
LcsMemberOfCollectionSlot >> optionValueBlock [
	^ optionValueBlock
]

{ #category : 'accessing' }
LcsMemberOfCollectionSlot >> optionValueBlock: anObject [
	optionValueBlock := anObject
]

{ #category : 'queries' }
LcsMemberOfCollectionSlot >> optionValueFor: aModel [
	^ self optionValueBlock cull: aModel cull: self
]

{ #category : 'message' }
LcsMemberOfCollectionSlot >> sourceCollectionNotPopulatedMessage [
	^'Source collection in module: ''<1s>'', slot: ''<2s>'' not initialized' 
			expandMacrosWith: self collectionSlotModuleName 
			with: self collectionSlotName
]
