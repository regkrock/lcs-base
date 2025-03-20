"
This is a system with no modules, etc. It is used for basic testing of the system logic
"
Class {
	#name : #LxxPrototypeSystem,
	#superclass : #LcsSystem,
	#instVars : [
		'persons',
		'organization'
	],
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #'slot definitions' }
LxxPrototypeSystem class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: LxxPrototypeSystemConfiguration
]

{ #category : #configuration }
LxxPrototypeSystem class >> moduleName [
	^ 'Prototype System'
]

{ #category : #'slot definitions' }
LxxPrototypeSystem class >> organizationSlotDefinition [
	<slotDefinition>
	^ LcsDomainClassSlot new
		slotName: 'organization';
		addSlotType: LxxPrototypeOrganization;
		yourself
]

{ #category : #'slot definitions' }
LxxPrototypeSystem class >> personsSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionSlot new
		slotName: 'persons';
		addSlotType: LxxPrototypePersons;
		addCollectionMemberType: LxxPrototypePerson;
		yourself
]

{ #category : #testing }
LxxPrototypeSystem >> isInActiveStatus [
	self hasSlotModel ifFalse: [ ^ false ].
	^ self status isInActiveStatus
]

{ #category : #testing }
LxxPrototypeSystem >> isInSuspendedStatus [
	self hasSlotModel ifFalse: [ ^ true ].
	^ self status isInSuspendedStatus
]

{ #category : #testing }
LxxPrototypeSystem >> isPrototypeSystem [
	^ true
]

{ #category : #accessing }
LxxPrototypeSystem >> organization [
	^ self slotVarNamed: 'organization'
]

{ #category : #accessing }
LxxPrototypeSystem >> organization: anObject [
	self slotVarNamed: 'organization' put: anObject
]

{ #category : #accessing }
LxxPrototypeSystem >> persons [
	^ self slotVarNamed: 'persons'
]

{ #category : #accessing }
LxxPrototypeSystem >> persons: anObject [
	self slotVarNamed: 'presons' put: anObject
]

{ #category : #initialize }
LxxPrototypeSystem >> systemDomainClasses [
	| collection |
	collection := super systemDomainClasses.
	"self addClasses: self class package classes to: collection.
	collection
		add: #LxxCompositeStateMachine asClass;
		add: #LxxSubStateMachine asClass."
	^ collection
		add: LxxPrototype2Submodule;
		add: LxxPrototypeOrganization;
		add: LxxPrototypePerson;
		add: LxxPrototypePersons;
		add: LxxPrototypeSystemConfiguration;
		addAll: LxxPrototypeSystem allSubmoduleClasses;
		yourself
]
