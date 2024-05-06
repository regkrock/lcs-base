"
This is a system with no modules, etc. It is used for basic testing of the system logic
"
Class {
	#name : #LxxBarebonesSystem,
	#superclass : #LcsBaseSystem,
	#instVars : [
		'persons',
		'age'
	],
	#category : #'Lcs-BarebonesSystem'
}

{ #category : #'slot definitions' }
LxxBarebonesSystem class >> ageSlotDefinition [
	<slotDefinition>
	^LcsIntegerSlot new
		slotName: 'age';
		initialValue: 10;
		yourself
]

{ #category : #'slot definitions' }
LxxBarebonesSystem class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: LxxBarebonesSystemConfiguration
]

{ #category : #modules }
LxxBarebonesSystem class >> moduleClasses [
	"This System has no modules"
	^ super moduleClasses
]

{ #category : #configuration }
LxxBarebonesSystem class >> moduleName [
	^ 'Barebones System'
]

{ #category : #'slot definitions' }
LxxBarebonesSystem class >> personsSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionSlot new
		slotName: 'persons';
		addSlotType: LxxBarebonesPersons;
		addCollectionMemberType: LxxBarebonesPerson;
		beIdentitySetCollection;
		yourself
]

{ #category : #accessing }
LxxBarebonesSystem >> age [
	^ self getValueOfSlotNamed: 'age'
]

{ #category : #accessing }
LxxBarebonesSystem >> age: anObject [
	self setValueOfSlotNamed: 'age' to: anObject
]

{ #category : #initialize }
LxxBarebonesSystem >> initialSystemDomainClasses [
	^super initialSystemDomainClasses
		add: LxxBarebonesPerson;
		add: LxxBarebonesSystemConfiguration;
		add: LxxBarebonesPersons;
		add: LcsCode;
		add: LcsCodes;
		yourself
]

{ #category : #accessing }
LxxBarebonesSystem >> persons [
	^ self getValueOfSlotNamed: 'persons'
]

{ #category : #accessing }
LxxBarebonesSystem >> persons: anObject [
	self setValueOfSlotNamed: 'presons' to: anObject
]
