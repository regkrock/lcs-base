Class {
	#name : #LxxPrototypeSystem,
	#superclass : #LcsBaseSystem,
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
