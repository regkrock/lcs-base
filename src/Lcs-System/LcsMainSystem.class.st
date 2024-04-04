Class {
	#name : #LcsMainSystem,
	#superclass : #LcsBaseSystem,
	#classVars : [
		'Singleton'
	],
	#category : #'Lcs-System'
}

{ #category : #'slot definitions' }
LcsMainSystem class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlotDefinition newOn: LcsSystemConfiguration
]

{ #category : #'modules ' }
LcsMainSystem class >> moduleClasses [
	^ OrderedCollection new
		add: LcsGeographyModule;
		add: LcsLegalEntitiesModule;
		yourself
]

{ #category : #'ui \t' }
LcsMainSystem >> gtUnitOfWorkOn: aView [
	<gtView>
	^ aView forward
		title: 'Unit Of Work' translated;
		priority: 5;
		object: [ self relatedUnitOfWork ];
		view: #gtUnitOfWorkFor:
		yourself
]

{ #category : #initialization }
LcsMainSystem >> systemDomainClasses [
	^ (LcsDomainObject withAllSubclasses) reject: [ :each | each name beginsWith: 'Lxx' ]
]
