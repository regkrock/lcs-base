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

{ #category : #'slot definitions' }
LxxBarebonesSystem class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlotDefinition newOn: LxxBarebonesSystemConfiguration
]

{ #category : #modules }
LxxBarebonesSystem class >> moduleClasses [
	"This System has no modules"
	^ super moduleClasses
]

{ #category : #'slot definitions' }
LxxBarebonesSystem class >> personsSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionSlotDefinition new
		slotName: 'persons';
		beIdentitySetCollection;
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

{ #category : #initialization }
LxxBarebonesSystem >> systemDomainClasses [
	^OrderedCollection new
		add: LcsDomainObject;
		add: LcsBaseSystem;
		add: LcsModule;
		add: LxxBarebonesSystem;
		add: LxxBarebonesPerson;
		add: LxxBarebonesSystemConfiguration;
		yourself
]
