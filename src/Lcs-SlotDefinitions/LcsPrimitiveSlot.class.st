Class {
	#name : #LcsPrimitiveSlot,
	#superclass : #LcsSlotDefintion,
	#instVars : [
		'initialValueBlock'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsPrimitiveSlot >> initialValue [
	^ self initialValueBlock cull: self domainClass
]

{ #category : #accessing }
LcsPrimitiveSlot >> initialValue: anObject [
	self initialValueBlock: [ anObject ]
]

{ #category : #accessing }
LcsPrimitiveSlot >> initialValueBlock [
	^ initialValueBlock
]

{ #category : #accessing }
LcsPrimitiveSlot >> initialValueBlock: aBlock [ 
	initialValueBlock := aBlock
]

{ #category : #initialization }
LcsPrimitiveSlot >> initialize [
	super initialize.
	self addSlotType: self typeClass
]

{ #category : #accessing }
LcsPrimitiveSlot >> initializeSlotValueIn: aDomainObject [
		self
		setValueTo: (self initialValueBlock cull: aDomainObject class)
		in: aDomainObject
]

{ #category : #configuration }
LcsPrimitiveSlot >> typeClass [
	self subclassResponsibility
]
