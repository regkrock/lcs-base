Class {
	#name : 'LcsSmalltalkObjectSlot',
	#superclass : 'LcsAccessorSlot',
	#instVars : [
		'inputComponentClassName'
	],
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'testing' }
LcsSmalltalkObjectSlot class >> isAbstract [
	^ self name = #LcsSmalltalkObjectSlot
]

{ #category : 'object initialization' }
LcsSmalltalkObjectSlot >> _initialValueFor: aDomainObject [
	^ self initialValueBlock cull: aDomainObject cull: self cull: nil
]

{ #category : 'gtviews' }
LcsSmalltalkObjectSlot >> addAssociationsToUmlModel: aUmlModel [
	super addAssociationsToUmlModel: aUmlModel.
	aUmlModel
		addAssociation: self slotName
			from: self domainClass
			to: self slotTypes first
]

{ #category : 'gtviews' }
LcsSmalltalkObjectSlot >> addClassesToUmlModel: umlModel [ 
	super addClassesToUmlModel: umlModel.
	umlModel addClassNamed: self slotTypes first
]

{ #category : 'initialize' }
LcsSmalltalkObjectSlot >> addDefaultSlotType [
	self addSlotType: self typeClass
]

{ #category : 'defaults' }
LcsSmalltalkObjectSlot >> defaultInitialValueBlock [
	self subclassResponsibility
]

{ #category : 'defaults' }
LcsSmalltalkObjectSlot >> defaultInputComponentClassName [
	^ #'NeedsToBeDefined'
	"self subclassResponsibility"
]

{ #category : 'initialize' }
LcsSmalltalkObjectSlot >> initialize [
	super initialize.
	self addDefaultSlotType.
	self inputComponentClassName: self defaultInputComponentClassName
]

{ #category : 'accessing' }
LcsSmalltalkObjectSlot >> inputComponentClass [
	^ self inputComponentClassName asClass
]

{ #category : 'accessing' }
LcsSmalltalkObjectSlot >> inputComponentClassName [
	^ inputComponentClassName
]

{ #category : 'accessing' }
LcsSmalltalkObjectSlot >> inputComponentClassName: anObject [
	inputComponentClassName := anObject
]

{ #category : 'configuration' }
LcsSmalltalkObjectSlot >> typeClass [
	self subclassResponsibility
]
