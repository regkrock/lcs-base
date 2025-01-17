Class {
	#name : #LcsModuleTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #accessing }
LcsModuleTest >> setupSunitSystem [
	^ LxxPrototypeSystem new
]

{ #category : #tests }
LcsModuleTest >> testAddingAModule [
	| existingNumberOfModules |
	self assert: self currentSystem notNil.
	existingNumberOfModules := self currentSystem modules size.
	self currentSystem installModule: LxxDemonstrationModule.
	self assert: self currentSystem modules size equals: existingNumberOfModules + 1.
	self assert: (( self currentSystem moduleNamed: LxxDemonstrationModule moduleName) isKindOf: LxxDemonstrationModule) 
]
