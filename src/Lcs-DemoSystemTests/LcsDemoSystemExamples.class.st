Class {
	#name : 'LcsDemoSystemExamples',
	#superclass : 'LcsBaseSystemExamples',
	#category : 'Lcs-DemoSystemTests-Examples',
	#package : 'Lcs-DemoSystemTests',
	#tag : 'Examples'
}

{ #category : 'assertions' }
LcsDemoSystemExamples >> assertGeographyModuleIsConfigured [
	| module |
	module := self currentSystem geographyModule.
	self assert: (module isKindOf: LcsGeographyModule).
	self assert: (module slotDefinitionNamed: 'countries') notNil.
	self assert: (module countries isKindOf: LcsCountries).
	self assert: (module countries collection isKindOf: LcsSmalltalkConfiguration identitySetClass).
	self assert: module countries collectionSize equals: (LcsCountriesLoader new collectionSize + 1).
	self assert: (module countries unknownInstance isKindOf: LcsUnknownCountry).
	self assert: (module countries defaultInstance == module countries unknownInstance).
	self assert: (module countries find: [ :each | each isKindOf: LcsUnknownCountry ]) == module countries unknownInstance.
	module countries collection do: [ :each | self assert: each parent = module countries ].
]

{ #category : 'tests' }
LcsDemoSystemExamples >> demoSystemExample [
	<gtExample>
	self ensureCurrentSystemIsDemoSystem.
	self assertCurrentSystemSetTo: LcsDemoSystem.
	self assertModuleConfigured: LcsSecurityModule.
	self assertModuleConfigured: LcsGeographyModule.
	self assertModuleConfigured: LcsLegalEntitiesModule.
	self assertModuleConfigured: LcsCalendarModule.
	
	self assertGeographyModuleIsConfigured.
	self validateLegalEntitiesModuleIsConfigured.
	^ self currentSystem
]

{ #category : 'assertions' }
LcsDemoSystemExamples >> validateLegalEntitiesModuleIsConfigured [
	| module |
	module := self currentSystem legalEntitiesModule.
	self assert: (module isKindOf: LcsLegalEntitiesModule).
	self assert: (module slotDefinitionNamed: 'contacts') notNil.
	self assert: (module contacts isKindOf: LcsLegalEntities).
	self assert: (module persons isKindOf: LcsPersons).
	self assert: (module organizations isKindOf: LcsOrganizations).
	self assert: (module persons unknownPerson isKindOf: LcsUnknownPerson).
	self assert: (module persons unknownPerson == module persons defaultInstance).
	self assert: (LcsPerson slotDefinitionNamed: #dateOfBirth) slotName equals: #dateOfBirth
]
