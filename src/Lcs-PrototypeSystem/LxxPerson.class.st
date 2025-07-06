Class {
	#name : #LxxPerson,
	#superclass : #LxxBasePerson,
	#instVars : [
		'age',
		'balance'
	],
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #'slot definitions' }
LxxPerson class >> ageSlotDefinition [
	<slotDefinition>
	^ LcsNumberSlot new
		slotName: 'age';
		slotTypes: (OrderedCollection with: Number);
		yourself
]

{ #category : #'slot definitions' }
LxxPerson class >> balanceSlotDefinition [
	<slotDefinition>
	^ LcsScaledDecimalSlot new
		slotName: 'balance';
		yourself
]

{ #category : #'slot definitions' }
LxxPerson class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LxxPrototypeSystem defaultModuleName;
		addSlotType: LxxPersons;
		collectionSlotName: 'persons';
		yourself
]

{ #category : #accessing }
LxxPerson >> age [
	^ self slotVarNamed: 'age'
]

{ #category : #accessing }
LxxPerson >> age: anObject [
	self slotVarNamed: 'age' put: anObject
]

{ #category : #accessing }
LxxPerson >> balance [
	^ self slotVarNamed: 'balance'
]

{ #category : #accessing }
LxxPerson >> balance: anObject [
	self slotVarNamed: 'balance' put: anObject
]
