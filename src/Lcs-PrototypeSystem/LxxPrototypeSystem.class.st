Class {
	#name : #LxxPrototypeSystem,
	#superclass : #LcsBaseSystem,
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #accessing }
LxxPrototypeSystem class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlotDefinition newOn: LcsBaseConfiguration
]

{ #category : #intialization }
LxxPrototypeSystem >> domainClasses [
	^ OrderedCollection new
		add: LcsDomainObject;
		add: LcsBaseSystem;
		add: LcsModule;
		add: LcsBaseModule;
		add: self class;
		addAll: self moduleClasses;
		add: LxxPerson;
		yourself
]

{ #category : #modules }
LxxPrototypeSystem >> moduleClasses [
	^ OrderedCollection new
		add: LxxPrototype1Module;
		add: LxxPrototype2Module;
		yourself
]
