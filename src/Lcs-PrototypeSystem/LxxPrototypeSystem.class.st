"
This is a system with no modules, etc. It is used for basic testing of the system logic
"
Class {
	#name : #LxxPrototypeSystem,
	#superclass : #LcsBaseSystem,
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
LxxPrototypeSystem >> hasSlotModel [
	^ self class hasSlotModel
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

{ #category : #'as yet unclassified' }
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
	^super systemDomainClasses
		add: LxxPrototypeOrganization;
		add: LxxPrototypePerson;
		add: LxxPrototypePersons;
		add: LxxPrototypeSystemConfiguration;
		addAll: LxxPrototypeSystem submoduleClasses;
		yourself
]
