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
	"<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: LcsSystemConfiguration"
]

{ #category : #'slot model' }
LcsMainSystem >> bootstrapDomainClasses [
	<todo: 'Refactor to make this mor efficient'>
	| domainClasses |
	domainClasses := self prebootstrapDomainClasses copy.
	domainClasses addAll: super bootstrapDomainClasses.
	^ super bootstrapDomainClasses
		addAll: (
			LcsDomainObject withAllSubclasses
				reject: [ :eachDomainClass | 
					(eachDomainClass name beginsWith: 'Lxx')
						or: [ domainClasses includes: eachDomainClass ] ]);
		yourself
]
