Class {
	#name : #LxxPrototypePersonsModule,
	#superclass : #LcsModule,
	#instVars : [
		'persons'
	],
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #configuration }
LxxPrototypePersonsModule class >> defaultModuleName [
	^ 'Persons Module'
]

{ #category : #configuration }
LxxPrototypePersonsModule class >> owningModules [
	<owningModule: 'LxxPrototypeSystem'>
]

{ #category : #'slot definitions' }
LxxPrototypePersonsModule class >> personsSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'persons';
		addSlotType: LxxPrototypePersons;
		addCollectionMemberType: LxxPrototypePerson;
		yourself
]

{ #category : #accessing }
LxxPrototypePersonsModule >> persons [
	^ self slotVarNamed: 'persons'
]

{ #category : #accessing }
LxxPrototypePersonsModule >> persons: aCollection [
	^ self slotVarNamed: 'persons' put: aCollection
]
