Class {
	#name : #LcsModuleTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-Tests'
}

{ #category : #accessing }
LcsModuleTest >> setupSunitSystem [
	'LxxBarebonesSystem' asClass new
]

{ #category : #tests }
LcsModuleTest >> testAddingAModule [
	self assert: self currentSystem notNil.
	self assert: self currentSystem hasNoModules.
	self currentSystem installModule: LxxDemonstrationModule.
	self assert: self currentSystem hasModules.
	self assert: (( self currentSystem moduleNamed: LxxDemonstrationModule moduleName) isKindOf: LxxDemonstrationModule) 
]
