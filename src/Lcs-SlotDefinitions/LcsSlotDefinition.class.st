"
This class and its subclasses define a slot:

slotName - this is the name of the slot and is the same as the instvarName. 
"
Class {
	#name : #LcsSlotDefinition,
	#superclass : #LcsObject,
	#instVars : [
		'slotName',
		'parent',
		'slotTypes',
		'required',
		'validator'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsSlotDefinition >> addSlotType: aClass [ 
	self slotTypes add: aClass
]

{ #category : #accessing }
LcsSlotDefinition >> beOptional [
	self required: false
]

{ #category : #accessing }
LcsSlotDefinition >> beRequired [
	self required: true
]

{ #category : #accessing }
LcsSlotDefinition >> getValueIn: aDomainObject [

	^ aDomainObject instVarNamed: self slotName asString
]

{ #category : #initialize }
LcsSlotDefinition >> initialize [
	super initialize.
	self slotTypes: OrderedCollection new
]

{ #category : #accessing }
LcsSlotDefinition >> isOptional [
	^self required ~~ true
]

{ #category : #accessing }
LcsSlotDefinition >> isRequired [
	^self required: true.
]

{ #category : #accessing }
LcsSlotDefinition >> parent [
	^ parent
]

{ #category : #accessing }
LcsSlotDefinition >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
LcsSlotDefinition >> required [
	^ required
]

{ #category : #accessing }
LcsSlotDefinition >> required: anObject [
	required := anObject
]

{ #category : #accessing }
LcsSlotDefinition >> setValueTo: anObject in: aDomainObject [
	LcsSystem currentUnitOfWork setValueTo: anObject in: aDomainObject forSlot: self

]

{ #category : #accessing }
LcsSlotDefinition >> slotName [
	^ slotName
]

{ #category : #accessing }
LcsSlotDefinition >> slotName: anObject [
	slotName := anObject
]

{ #category : #accessing }
LcsSlotDefinition >> slotTypes [
	^ slotTypes
]

{ #category : #accessing }
LcsSlotDefinition >> slotTypes: anObject [
	slotTypes := anObject
]

{ #category : #accessing }
LcsSlotDefinition >> validator [
	^ validator
]

{ #category : #accessing }
LcsSlotDefinition >> validator: anObject [
	validator := anObject
]
