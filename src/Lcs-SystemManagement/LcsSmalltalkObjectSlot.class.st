Class {
	#name : #LcsSmalltalkObjectSlot,
	#superclass : #LcsAcessorSlot,
	#instVars : [
		'inputComponentClassName'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsSmalltalkObjectSlot >> defaultInitialValueBlock [
	self subclassResponsibility
]

{ #category : #defaults }
LcsSmalltalkObjectSlot >> defaultInputComponentClassName [
	^ #'NeedsToBeDefined'
	"self subclassResponsibility"
]

{ #category : #accessing }
LcsSmalltalkObjectSlot >> initialValueFor: aDomainObject [
	^ self initialValueBlock cull: aDomainObject
]

{ #category : #initialize }
LcsSmalltalkObjectSlot >> initialize [
	super initialize.
	self addSlotType: self typeClass.
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
