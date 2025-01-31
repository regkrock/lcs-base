Class {
	#name : #LcsMainSystem,
	#superclass : #LcsBaseSystem,
	#classVars : [
		'Singleton'
	],
	#category : #'Lcs-MainSystem'
}

{ #category : #'slot definitions' }
LcsMainSystem class >> configurationSlotDefinition [
	"<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: LcsSystemConfiguration"
]

{ #category : #'slot model' }
LcsMainSystem >> systemDomainClasses [
	<todo: 'Refactor to make this mor efficient'>
	| domainClasses |
	domainClasses := self systemBootstrapDomainClasses copy.
	domainClasses addAll: super systemDomainClasses.
	^ super systemDomainClasses
		addAll: (
			LcsDomainObject withAllSubclasses
				reject: [ :eachDomainClass | 
					(eachDomainClass name beginsWith: 'Lxx')
						or: [ domainClasses includes: eachDomainClass ] ]);
		yourself
]
