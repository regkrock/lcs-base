Class {
	#name : #LxxPrototype1Module,
	#superclass : #LcsModule,
	#instVars : [
		'persons'
	],
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #'slot definitions' }
LxxPrototype1Module class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: LcsBaseConfiguration
]

{ #category : #configuration }
LxxPrototype1Module class >> moduleName [
	^ 'Prototype 1 Module'
]

{ #category : #'slot definitions' }
LxxPrototype1Module class >> personsSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'persons';
		beIdentitySetCollection;
		yourself
]
