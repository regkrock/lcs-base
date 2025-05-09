Class {
	#name : #LxxPersonsModule,
	#superclass : #LcsModule,
	#instVars : [
		'persons'
	],
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #configuration }
LxxPersonsModule class >> defaultModuleName [
	^ 'Persons Module'
]

{ #category : #configuration }
LxxPersonsModule class >> owningModules [
	<owningModule: 'LxxPrototypeSystem'>
]

{ #category : #'slot definitions' }
LxxPersonsModule class >> personsSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'persons';
		addSlotType: LxxPersons;
		addCollectionMemberType: LxxPerson;
		yourself
]

{ #category : #accessing }
LxxPersonsModule >> persons [
	^ self slotVarNamed: 'persons'
]

{ #category : #accessing }
LxxPersonsModule >> persons: aCollection [
	^ self slotVarNamed: 'persons' put: aCollection
]
