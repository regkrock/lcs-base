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

{ #category : #initialize }
LxxPrototypeSystem >> bootstrapDomainClasses [
	^super bootstrapDomainClasses
		"add: LxxPrototypeSystem;"
		add: LxxPrototypeOrganization;
		add: LxxPrototypePerson;
		add: LxxPrototypePersons;
		add: LxxPrototypeSystemConfiguration;
		addAll: LxxPrototypeSystem submoduleClasses;
		yourself
]

{ #category : #testing }
LxxPrototypeSystem >> isInActiveStatus [
	self isSlotModelDefined ifFalse: [ ^ false ].
	^ self status isInActiveStatus
]

{ #category : #testing }
LxxPrototypeSystem >> isInSuspendedStatus [
	self isSlotModelDefined ifFalse: [ ^ true ].
	^ self status isInSuspendedStatus
]

{ #category : #'as yet unclassified' }
LxxPrototypeSystem >> isPrototypeSystem [
	^ true
]

{ #category : #testing }
LxxPrototypeSystem >> isSlotModelDefined [
	^ self class isSlotModelDefined
]

{ #category : #accessing }
LxxPrototypeSystem >> organization [
	^ self getValueOfSlotNamed: 'organization'
]

{ #category : #accessing }
LxxPrototypeSystem >> organization: anObject [
	self setValueOfSlotNamed: 'organization' to: anObject
]

{ #category : #accessing }
LxxPrototypeSystem >> persons [
	^ self getValueOfSlotNamed: 'persons'
]

{ #category : #accessing }
LxxPrototypeSystem >> persons: anObject [
	self setValueOfSlotNamed: 'presons' to: anObject
]
