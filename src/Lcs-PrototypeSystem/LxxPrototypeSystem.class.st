Class {
	#name : #LxxPrototypeSystem,
	#superclass : #LcsBaseSystem,
	#instVars : [
		'organization'
	],
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #'slot definitions' }
LxxPrototypeSystem class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: LxxPrototypeSystemConfiguration
]

{ #category : #modules }
LxxPrototypeSystem class >> moduleClasses [
	^ OrderedCollection new
		add: LxxPrototypePersonsModule;
		add: LxxPrototype2Module;
		yourself
]

{ #category : #'slot definitions' }
LxxPrototypeSystem class >> organizationSlotDefinition [
	<slotDefinition>
	^ LcsDomainClassSlot new
		slotName: 'organization';
		addSlotType: LxxPrototypeOrganization;
		yourself
]

{ #category : #initialize }
LxxPrototypeSystem >> initialSystemDomainClasses [
	^ super initialSystemDomainClasses
		addAll: self allModuleClasses;
		add: LxxPrototypeOrganization;
		add: LxxPrototypePerson;
		add: LxxPrototypePersons;
		add: LxxPrototypeSystemConfiguration;
		yourself
]

{ #category : #accessing }
LxxPrototypeSystem >> organization [
	^ self getValueOfSlotNamed: 'organization'
]

{ #category : #accessing }
LxxPrototypeSystem >> organization: anOrganization [
	^ self setValueOfSlotNamed: 'organization' to: anOrganization
]
