Class {
	#name : #LxxPrototypeSystem,
	#superclass : #LcsBaseSystem,
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #'slot definitions' }
LxxPrototypeSystem class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlotDefinition newOn: LxxPrototypeSystemConfiguration
]

{ #category : #modules }
LxxPrototypeSystem class >> moduleClasses [
	^ OrderedCollection new
		add: LxxPrototype1Module;
		add: LxxPrototype2Module;
		yourself
]

{ #category : #initialize }
LxxPrototypeSystem >> systemDomainClasses [
	^ OrderedCollection new
		add: LcsDomainObject;
		add: LcsBaseSystem;
		add: LcsModule;
		add: LcsBaseModule;
		addAll: self allModuleClasses;
		add: LxxPrototypePerson;
		yourself
]
