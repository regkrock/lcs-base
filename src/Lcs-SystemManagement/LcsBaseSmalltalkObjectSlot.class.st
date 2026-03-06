Class {
	#name : 'LcsBaseSmalltalkObjectSlot',
	#superclass : 'LcsAccessorSlot',
	#instVars : [
		'inputComponentClassName'
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

{ #category : 'defaults' }
LcsBaseSmalltalkObjectSlot >> defaultInputComponentClassName [
	^ #'NeedsToBeDefined'
	"self subclassResponsibility"
]

{ #category : 'initialize' }
LcsBaseSmalltalkObjectSlot >> initialize [
	super initialize.
	self addDefaultSlotType.
	self inputComponentClassName: self defaultInputComponentClassName
]

{ #category : 'accessing' }
LcsBaseSmalltalkObjectSlot >> inputComponentClass [
	^ self inputComponentClassName asClass
]

{ #category : 'accessing' }
LcsBaseSmalltalkObjectSlot >> inputComponentClassName [
	^ inputComponentClassName
]

{ #category : 'accessing' }
LcsBaseSmalltalkObjectSlot >> inputComponentClassName: anObject [
	inputComponentClassName := anObject
]

{ #category : 'configuration' }
LcsBaseSmalltalkObjectSlot >> typeClass [
	self subclassResponsibility
]
