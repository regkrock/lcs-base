Class {
	#name : #LxxPrototypePersonsModule,
	#superclass : #LcsModule,
	#instVars : [
		'persons'
	],
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #configuration }
LxxPrototypePersonsModule class >> moduleName [
	^ 'Persons Module'
]

{ #category : #'slot definitions' }
LxxPrototypePersonsModule class >> personsSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'persons';
		addSlotType: LxxPrototypePersons;
		addCollectionMemberType: LxxPrototypePerson;
		beIdentitySetCollection;
		yourself
]
