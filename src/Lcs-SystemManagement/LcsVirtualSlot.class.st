Class {
	#name : 'LcsVirtualSlot',
	#superclass : 'LcsBaseSlot',
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

{ #category : 'slot model' }
LcsVirtualSlot >> currentSlotVarIn: aDomainObject [
	^ self valueAccessBlock cull: aDomainObject cull: self
]

{ #category : 'defaults' }
LcsVirtualSlot >> defaultPragmaSelector [
	^ self class virtualSlotDefinitionName
]

{ #category : 'defaults' }
LcsVirtualSlot >> defaultValueAccessBlock [
		^ [ :parentDomainObject :slot | parentDomainObject perform: slot valueAccessor ]
]

{ #category : 'initialize' }
LcsVirtualSlot >> initialize [
	super initialize.
	self valueAccessBlock: self defaultValueAccessBlock.
	self valueAccessor: ''
]

{ #category : 'slot model' }
LcsVirtualSlot >> slotVarNamed: anObject in: aDomainObject [
	self error: 'This is a read only slot'
]

{ #category : 'slot model' }
LcsVirtualSlot >> slotVarPut: anObject in: aDomainObject [
	self deprecated: 'Need to pass the old value as well'.
	self error: 'This is a read only slot'
]

{ #category : 'accessing' }
LcsVirtualSlot >> valueAccessBlock [
	^ self properties at: 'valueAccessBlock'
]

{ #category : 'accessing' }
LcsVirtualSlot >> valueAccessBlock: aBlock [
	^ self properties at: 'valueAccessBlock' put: aBlock
]

{ #category : 'accessing' }
LcsVirtualSlot >> valueAccessor [
	^ self properties at: 'valueAccessor'
]

{ #category : 'accessing' }
LcsVirtualSlot >> valueAccessor: anObject [
	^ self properties at: 'valueAccessor' put: anObject asSymbol
]
