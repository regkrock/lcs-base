"
This is a system with no modules, etc. It is used for basic testing of the system logic
"
Class {
	#name : #LxxBarebonesSystem,
	#superclass : #LcsBaseSystem,
	#instVars : [
		'persons'
	],
	#category : #'Lcs-BarebonesSystem'
}

{ #category : #accessing }
LxxBarebonesSystem class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlotDefinition newOn: LxxBarebonesSystemConfiguration
]

{ #category : #'slot definitions' }
LxxBarebonesSystem class >> personsSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionSlotDefinition new
		slotName: 'persons';
		beIdentitySetCollection;
		yourself
]

{ #category : #initialization }
LxxBarebonesSystem >> domainClasses [
	^OrderedCollection new
		add: LcsDomainObject;
		add: LcsBaseSystem;
		add: LcsModule;
		add: LxxBarebonesSystem;
		add: LxxBarebonesPerson;
		add: LxxBarebonesSystemConfiguration;
		yourself
]

{ #category : #modules }
LxxBarebonesSystem >> moduleClasses [
	"This System has no modules"
	^ super moduleClasses
]

{ #category : #accessing }
LxxBarebonesSystem >> persons [
	^ self getValueOfSlotNamed: 'persons'
]

{ #category : #accessing }
LxxBarebonesSystem >> persons: anObject [
	self setValueOfSlotNamed: 'presons' to: anObject
]
