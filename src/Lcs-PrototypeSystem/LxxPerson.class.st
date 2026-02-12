Class {
	#name : 'LxxPerson',
	#superclass : 'LxxBasePerson',
	#instVars : [
		'balance',
		'weight'
	],
	#category : 'Lcs-PrototypeSystem-Core',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LxxPerson class >> ageSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlot new
		slotName: 'age';
		addSlotType: Integer;
		yourself
]

{ #category : 'slot definitions' }
LxxPerson class >> balanceSlotDefinition [
	<accessorSlotDefinition>
	^ LcsScaledDecimalSlot new
		slotName: 'balance';
		yourself
]

{ #category : 'slot definitions' }
LxxPerson class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LxxPrototypeSystem defaultModuleName;
		addSlotType: LxxPersons;
		collectionSlotName: 'persons';
		yourself
]

{ #category : 'slot definitions' }
LxxPerson class >> weightSlotDefinition [
	<accessorSlotDefinition>
	^ LcsNumberSlot new
		slotName: 'weight';
		yourself
]

{ #category : 'accessing' }
LxxPerson >> age [
	^ self virtualSlotVarNamed: 'age'
]

{ #category : 'accessing' }
LxxPerson >> balance [
	^ self slotVarNamed: 'balance'
]

{ #category : 'accessing' }
LxxPerson >> balance: anObject [
	self slotVarNamed: 'balance' put: anObject
]

{ #category : 'accessing' }
LxxPerson >> weight [
	^ self slotVarNamed: 'weight'
]

{ #category : 'accessing' }
LxxPerson >> weight: anObject [
	self slotVarNamed: 'weight' put: anObject
]
