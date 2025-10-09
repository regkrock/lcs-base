Class {
	#name : #LcsGeographyModuleTest,
	#superclass : #LcsMainSystemRunningTestCase,
	#category : #'Lcs-MainSystemTests'
}

{ #category : #tests }
LcsGeographyModuleTest >> testCreation [
	| module |
	module := self currentSystem geographyModule.
	self assert: (module isKindOf: LcsGeographyModule).
	self assert: (module slotDefinitionNamed: 'countries') notNil.
	self currentSystem currentUnitOfWork applyChanges.
	self assert: (module countries isKindOf: LcsCountries).
	self assert: (module countries collection isKindOf: LcsSmalltalkConfiguration identitySetClass).
	self assert: module countries collectionSize equals: (LcsCountryLoader new collectionSize + 1).
	self assert: (module countries defaultInstance isKindOf: LcsUnknownCountry).
	module countries collection do: [ :each | self assert: each parent = module countries].
	self assert: LcsGeographyModule moduleConfigurationClass equals: LcsGeographyModuleConfiguration.
	self assert: (self currentSystem geographyModule configuration isKindOf: LcsGeographyModuleConfiguration).
	self assert: self currentSystem geographyModule configuration parent equals: self currentSystem geographyModule.

]
