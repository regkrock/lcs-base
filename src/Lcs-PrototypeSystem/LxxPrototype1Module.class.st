Class {
	#name : #LxxPrototype1Module,
	#superclass : #LcsModule,
	#instVars : [
		'persons'
	],
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #accessing }
LxxPrototype1Module class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlotDefinition newOn: LcsBaseConfiguration
]

{ #category : #accessing }
LxxPrototype1Module class >> moduleName [
	^ 'Prototype 1 Module'
]

{ #category : #'slot definitions' }
LxxPrototype1Module class >> personsSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlotDefinition new
		slotName: 'persons';
		beIdentitySetCollection;
		yourself
]
