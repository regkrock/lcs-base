Class {
	#name : 'LcsMembersOfCollectionSlot',
	#superclass : 'LcsDomainObjectSlot',
	#instVars : [
		'displayStringBlock',
		'optionValueBlock'
	],
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'as yet unclassified' }
LcsMembersOfCollectionSlot >> addCollectionElementsSlotType: aClass [
	self assert: aClass isClass.
	(self collectionElementsSlotTypes includes: aClass) ifFalse: [ self collectionElementsSlotTypes add: aClass ]
]

{ #category : 'slot model' }
LcsMembersOfCollectionSlot >> assignParent: aDomainObject to: newValue [
	"Parent has already been assigned"
]

{ #category : 'as yet unclassified' }
LcsMembersOfCollectionSlot >> collectionElementsSlotTypes [
	^ self propertyAt: #'collectionElementsSlotTypes'
]

{ #category : 'as yet unclassified' }
LcsMembersOfCollectionSlot >> collectionElementsSlotTypes: aCollection [
	^ self propertyAt: #'collectionElementsSlotTypes' put: aCollection
]

{ #category : 'defaults' }
LcsMembersOfCollectionSlot >> defaultDisplayStringlock [
	^ [:object :slot | object displayString ]
]

{ #category : 'defaults' }
LcsMembersOfCollectionSlot >> defaultOptionValueBlock [
	^ [:object :slot | object displayString ]
]

{ #category : 'accessing' }
LcsMembersOfCollectionSlot >> displayStringBlock [
	^ displayStringBlock
]

{ #category : 'accessing' }
LcsMembersOfCollectionSlot >> displayStringBlock: anObject [
	displayStringBlock := anObject
]

{ #category : 'defaults' }
LcsMembersOfCollectionSlot >> initialize [
	super initialize.
	self
		displayStringBlock: self defaultDisplayStringlock;
		optionValueBlock: self defaultOptionValueBlock;
		collectionElementsSlotTypes: OrderedCollection new;
		beRequired
]

{ #category : 'queries' }
LcsMembersOfCollectionSlot >> optionDisplayStringFor: aModel [
	^ self displayStringBlock cull: aModel cull: self
]

{ #category : 'accessing' }
LcsMembersOfCollectionSlot >> optionValueBlock [
	^ optionValueBlock
]

{ #category : 'accessing' }
LcsMembersOfCollectionSlot >> optionValueBlock: anObject [
	optionValueBlock := anObject
]

{ #category : 'queries' }
LcsMembersOfCollectionSlot >> optionValueFor: aModel [
	^ self optionValueBlock cull: aModel cull: self
]

{ #category : 'message' }
LcsMembersOfCollectionSlot >> sourceCollectionNotPopulatedMessage [
	^'Source collection in module: ''<1s>'', slot: ''<2s>'' not initialized' 
			expandMacrosWith: self collectionSlotModuleName 
			with: self collectionSlotName
]
