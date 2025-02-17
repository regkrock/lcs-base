Class {
	#name : #LcsSmalltalkObjectSlot,
	#superclass : #LcsSlotDefinition,
	#instVars : [
		'inputComponentClassName'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsSmalltalkObjectSlot >> defaultInputComponentClassName [
	^ #'NeedsToBeDefined'
	"self subclassResponsibility"
]

{ #category : #'gt views' }
LcsSmalltalkObjectSlot >> gtSlotDefinitionAttributes [
	^ super gtSlotDefinitionAttributes
		add: 'initialValueBlock' -> self initialValueBlock;
		add: 'initialValue' -> initialValueBlock value;
		yourself
]

{ #category : #accessing }
LcsSmalltalkObjectSlot >> initialValueFor: aDomainObject [
	^ self initialValueBlock cull: aDomainObject class
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
