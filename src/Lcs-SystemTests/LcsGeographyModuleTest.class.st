Class {
	#name : #LcsGeographyModuleTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SystemTests'
}

{ #category : #accessing }
LcsGeographyModuleTest >> testCreation [
	| module |
	module := self currentSystem geographyModule.
	self assert: (module isKindOf: LcsGeographyModule).
	self assert: (module slotDefinitionNamed: 'countries') notNil.
	self currentSystem currentUnitOfWork applyChanges.
	self assert: (module countries isKindOf: LcsSmalltalkConfiguration identitySetClass).
	self assert: module countries isEmpty.
	
]
