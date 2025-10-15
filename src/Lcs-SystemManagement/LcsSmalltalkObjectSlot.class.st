Class {
	#name : #LcsSmalltalkObjectSlot,
	#superclass : #LcsAccessorSlot,
	#instVars : [
		'inputComponentClassName'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #testing }
LcsSmalltalkObjectSlot class >> isAbstract [
	^ self name = #LcsSmalltalkObjectSlot
]

{ #category : #initialize }
LcsSmalltalkObjectSlot >> addDefaultSlotType [
	self addSlotType: self typeClass
]

{ #category : #defaults }
LcsSmalltalkObjectSlot >> defaultInitialValueBlock [
	self subclassResponsibility
]

{ #category : #defaults }
LcsSmalltalkObjectSlot >> defaultInputComponentClassName [
	^ #'NeedsToBeDefined'
	"self subclassResponsibility"
]

{ #category : #'object initialization' }
LcsSmalltalkObjectSlot >> initialValueFor: aDomainObject [
	^ self initialValueBlock cull: aDomainObject cull: self cull: nil
]

{ #category : #initialize }
LcsSmalltalkObjectSlot >> initialize [
	super initialize.
	self addDefaultSlotType.
	self inputComponentClassName: self defaultInputComponentClassName
]

{ #category : #accessing }
LcsSmalltalkObjectSlot >> inputComponentClass [
	^ self inputComponentClassName asClass
]

{ #category : #accessing }
LcsSmalltalkObjectSlot >> inputComponentClassName [
	^ inputComponentClassName
]

{ #category : #accessing }
LcsSmalltalkObjectSlot >> inputComponentClassName: anObject [
	inputComponentClassName := anObject
]

{ #category : #configuration }
LcsSmalltalkObjectSlot >> typeClass [
	self subclassResponsibility
]
