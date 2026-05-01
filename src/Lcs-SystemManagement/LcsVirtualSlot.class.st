Class {
	#name : 'LcsVirtualSlot',
	#superclass : 'LcsDomainSlot',
	#instVars : [
		'valueAccessBlock',
		'valueAccessor'
	],
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'testing' }
LcsVirtualSlot class >> isVirtualSlot [
	^ true
]

{ #category : 'gt views' }
LcsVirtualSlot >> addAssociationsToUmlModel: aUmlModel [
	super addAssociationsToUmlModel: aUmlModel.
	aUmlModel
		addAssociation: self slotName 
			from: self domainClass
			to: self slotTypes first
]

{ #category : 'gt views' }
LcsVirtualSlot >> addClassesToUmlModel: umlModel [ 
	super addClassesToUmlModel: umlModel.
	umlModel addClassNamed: self slotTypes first
]

{ #category : 'defaults' }
LcsVirtualSlot >> computedValueAccessor [
	^ self propertyAt: #computedValueAccessor
]

{ #category : 'defaults' }
LcsVirtualSlot >> computedValueAccessor: anObject [
	^ self propertyAt: #computedValueAccessor put: anObject asSymbol
]

{ #category : 'properties' }
LcsVirtualSlot >> computedValueBlock [
	^ self propertyAt: #computedValueBlock
]

{ #category : 'properties' }
LcsVirtualSlot >> computedValueBlock: aBlock [
	^ self properties at: #computedValueBlock put: aBlock
]

{ #category : 'slot model' }
LcsVirtualSlot >> currentSlotVarIn: aDomainObject [
	^ self computedValueBlock cull: aDomainObject cull: self
]

{ #category : 'defaults' }
LcsVirtualSlot >> defaultComputedValueBlock [
		^ [ :parentDomainObject :slot | parentDomainObject perform: slot computedValueAccessor ]
]

{ #category : 'defaults' }
LcsVirtualSlot >> defaultPragmaSelector [
	^ self class virtualSlotDefinitionName
]

{ #category : 'initialize' }
LcsVirtualSlot >> initialize [
	super initialize.
	self computedValueBlock: self defaultComputedValueBlock.
	self computedValueAccessor: ''
]

{ #category : 'slot model' }
LcsVirtualSlot >> slotVarNamed: anObject in: aDomainObject [
	LcsSlotUpdateNotAllowedError signal:  'This is a read only slot'
]

{ #category : 'slot model' }
LcsVirtualSlot >> slotVarPut: anObject in: aDomainObject [
	self deprecated: 'Need to pass the old value as well'.
	self error: 'This is a read only slot'
]
