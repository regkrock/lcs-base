Class {
	#name : #LcsModuleTest,
	#superclass : #LcsPrototypeSystemRunningTestCase,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #tests }
LcsModuleTest >> testAddingAModule [
	| existingNumberOfModules |
	self assert: self currentSystem notNil.
	existingNumberOfModules := self currentSystem modules collectionSize.
	self currentSystem installModule: LxxDemonstrationModule.
	self assert: self currentSystem modules collectionSize equals: existingNumberOfModules + 1.
	self assert: (( self currentSystem moduleNamed: LxxDemonstrationModule defaultModuleName) isKindOf: LxxDemonstrationModule) 
]
