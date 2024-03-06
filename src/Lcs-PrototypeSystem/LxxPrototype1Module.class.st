Class {
	#name : #LxxPrototype1Module,
	#superclass : #LcsModule,
	#instVars : [
		'persons'
	],
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #accessing }
LxxPrototype1Module class >> moduleName [
	^'Prototype 1 Module'
]

{ #category : #accessing }
LxxPrototype1Module >> personsSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionSlotDefinition new
		slotName: 'persons';
		beIdentitySetCollection;
		yourself
]
