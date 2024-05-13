Class {
	#name : #LxxPersonsModule,
	#superclass : #LcsModule,
	#instVars : [
		'persons'
	],
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #configuration }
LxxPersonsModule class >> moduleName [
	^ 'Persons Module'
]

{ #category : #'slot definitions' }
LxxPersonsModule class >> personsSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'persons';
		addSlotType: LxxPrototypePersons;
		addCollectionMemberType: LxxPrototypePerson;
		beIdentitySetCollection;
		yourself
]
