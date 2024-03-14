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

{ #category : #configuration }
LcsSlotDefinition >> addSlotType: aClass [ 
	self slotTypes add: aClass
]

{ #category : #configuration }
LcsSlotDefinition >> beOptional [
	self required: false
]

{ #category : #configuration }
LcsSlotDefinition >> beRequired [
	self required: true
]

{ #category : #model }
LcsSlotDefinition >> getValueIn: aDomainObject [

	^ (self currentSystem currentUnitOfWork changedSlotRecordFor: aDomainObject slotNamed: self slotName)
		ifNil: [ aDomainObject instVarNamed: self slotName asString ]
		ifNotNil: [ :changedSlotRecord | changedSlotRecord newValue ]
]

{ #category : #initialization }
LcsSlotDefinition >> initialize [
	super initialize.
	self initializeSlotTypes
]

{ #category : #model }
LcsSlotDefinition >> initializeModel: aDomainObject [
	self setValueTo: self newSlotValue in: aDomainObject
]

{ #category : #initialization }
LcsSlotDefinition >> initializeSlotTypes [
	self slotTypes: OrderedCollection new
]

{ #category : #testing }
LcsSlotDefinition >> isOptional [
	^ self required ~~ true
]

{ #category : #testing }
LcsSlotDefinition >> isRequired [
	^ self required: true.
]

{ #category : #model }
LcsSlotDefinition >> newSlotValue [
	^ self slotTypes any new
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

{ #category : #model }
LcsSlotDefinition >> setValueTo: anObject in: aDomainObject [
	LcsSystemManager currentUnitOfWork setValueTo: anObject in: aDomainObject forSlot: self

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

{ #category : #validation }
LcsSlotDefinition >> validateConfiguration [
	self parent halt.
]

{ #category : #accessing }
LcsSlotDefinition >> validator [
	^ validator
]

{ #category : #accessing }
LcsSlotDefinition >> validator: anObject [
	validator := anObject
]
