Class {
	#name : #LcsPrimitiveSlot,
	#superclass : #LcsSlotDefinition,
	#instVars : [
		'inputComponentClassName'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #defaults }
LcsPrimitiveSlot >> defaultInputComponentClassName [
	^ #'NeedsToBeDefined'
	"self subclassResponsibility"
]

{ #category : #'gt view' }
LcsPrimitiveSlot >> gtSlotDefinitionAttributes [
	^ super gtSlotDefinitionAttributes
		add: 'initialValueBlock' -> self initialValueBlock;
		add: 'initialValue' -> initialValueBlock value;
		yourself
]

{ #category : #accessing }
LcsPrimitiveSlot >> initialValueFor: aDomainObject [
	^ self initialValueBlock cull: aDomainObject class
]

{ #category : #initialization }
LcsPrimitiveSlot >> initialize [
	super initialize.
	self addSlotType: self typeClass.
	self inputComponentClassName: self defaultInputComponentClassName
]

{ #category : #accessing }
LcsPrimitiveSlot >> inputComponentClass [
	^ self inputComponentClassName asClass
]

{ #category : #accessing }
LcsPrimitiveSlot >> inputComponentClassName [
	^ inputComponentClassName
]

{ #category : #accessing }
LcsPrimitiveSlot >> inputComponentClassName: anObject [
	inputComponentClassName := anObject
]

{ #category : #configuration }
LcsPrimitiveSlot >> typeClass [
	self subclassResponsibility
]
