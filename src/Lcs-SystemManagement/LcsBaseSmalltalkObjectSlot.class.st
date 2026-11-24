Class {
	#name : 'LcsBaseSmalltalkObjectSlot',
	#superclass : 'LcsAccessorSlot',
	#instVars : [
		'inputComponentClass'
	],
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'testing' }
LcsBaseSmalltalkObjectSlot class >> isAbstract [
	^ self name = #LcsBaseSmalltalkObjectSlot
]

{ #category : 'object initialization' }
LcsBaseSmalltalkObjectSlot >> _initialValueFor: aDomainObject [
	^ self initialValueBlock cull: aDomainObject cull: self cull: nil
]

{ #category : 'gtviews' }
LcsBaseSmalltalkObjectSlot >> addAssociationsToUmlModel: aUmlModel [
	super addAssociationsToUmlModel: aUmlModel.
	aUmlModel
		addAssociation: self slotName
			from: self domainClass
			to: self slotTypes first
]

{ #category : 'gtviews' }
LcsBaseSmalltalkObjectSlot >> addClassesToUmlModel: umlModel [ 
	super addClassesToUmlModel: umlModel.
	umlModel addClassNamed: self slotTypes first
]

{ #category : 'initialize' }
LcsBaseSmalltalkObjectSlot >> addDefaultSlotType [
	self addSlotType: self typeClass
]

{ #category : 'defaults' }
LcsBaseSmalltalkObjectSlot >> defaultInitialValueBlock [
	self subclassResponsibility
]

{ #category : 'initialize' }
LcsBaseSmalltalkObjectSlot >> initialize [
	super initialize.
	self addDefaultSlotType.
	self inputComponentClass: self defaultInputComponentClass
]

{ #category : 'accessing' }
LcsBaseSmalltalkObjectSlot >> inputComponentClass [
	^ inputComponentClass
]

{ #category : 'accessing' }
LcsBaseSmalltalkObjectSlot >> inputComponentClass: anObject [
	inputComponentClass := anObject
]

{ #category : 'properties' }
LcsBaseSmalltalkObjectSlot >> title [
	^ self propertyAt: 'title' ifAbsent: [ nil ]
]

{ #category : 'properties' }
LcsBaseSmalltalkObjectSlot >> title: aString [ 
	self propertyAt: 'title' put: aString
]

{ #category : 'properties' }
LcsBaseSmalltalkObjectSlot >> tooltip [
	^ self title
]

{ #category : 'properties' }
LcsBaseSmalltalkObjectSlot >> tooltip: aString [
	self title: aString
]

{ #category : 'configuration' }
LcsBaseSmalltalkObjectSlot >> typeClass [
	self subclassResponsibility
]
