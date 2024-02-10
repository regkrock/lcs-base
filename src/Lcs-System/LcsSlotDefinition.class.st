Class {
	#name : #LcsSlotDefinition,
	#superclass : #LcsObject,
	#instVars : [
		'slotName',
		'parent',
		'slotTypes'
	],
	#category : #'Lcs-System'
}

{ #category : #accessing }
LcsSlotDefinition >> addSlotType: aClass [ 
	self slotTypes add: aClass
]

{ #category : #initialize }
LcsSlotDefinition >> initialize [
	super initialize.
	self slotTypes: OrderedCollection new
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
