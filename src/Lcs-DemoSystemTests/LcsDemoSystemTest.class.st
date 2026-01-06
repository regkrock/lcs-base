Class {
	#name : 'LcsDemoSystemTest',
	#superclass : 'LcsAbstractSystemTest',
	#category : 'Lcs-DemoSystemTests',
	#package : 'Lcs-DemoSystemTests'
}

{ #category : 'assertions' }
LcsDemoSystemTest >> assertGeographyModuleIsConfigured [
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

{ #category : 'assertions' }
LcsDemoSystemTest >> assertLegalEntitiesModuleIsConfigured [
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

{ #category : 'tests' }
LcsDemoSystemTest >> testCreation [

	self subject: LcsDemoSystem new.
	self assertCurrentSystemSetTo: LcsDemoSystem.
	self assertModuleConfigured: LcsSecurityModule.
	self assertModuleConfigured: LcsGeographyModule.
	self assertModuleConfigured: LcsLegalEntitiesModule.
	self assertModuleConfigured: LcsCalendarModule.
	
	self assertGeographyModuleIsConfigured.
	self assertLegalEntitiesModuleIsConfigured.
	
]
