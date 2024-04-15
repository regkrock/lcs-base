"
This is a system with no modules, etc. It is used for basic testing of the system logic
"
Class {
	#name : #LxxBarebonesSystem,
	#superclass : #LcsBaseSystem,
	#instVars : [
		'persons',
		'users'
	],
	#category : #'Lcs-BarebonesSystem'
}

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

{ #category : #'slot definitions' }
LxxBarebonesSystem class >> usersSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'users';
		addSlotType: LxxUsers;
		collectionSlotCollectionClass: IdentitySet;
		addCollectionMemberType: LxxUser;
		beIdentitySetCollection;
		yourself
]

{ #category : #initialize }
LxxBarebonesSystem >> initialSystemDomainClasses [
	^super initialSystemDomainClasses
		add: LxxBarebonesPerson;
		add: LxxBarebonesSystemConfiguration;
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

{ #category : #accessing }
LxxBarebonesSystem >> users [
	^ self getValueOfSlotNamed: 'users'
]

{ #category : #accessing }
LxxBarebonesSystem >> users: anObject [
	self setValueOfSlotNamed: 'users' to: anObject
]
