Class {
	#name : #LcsBaseModuleTest,
	#superclass : #LcsDomainTestCase,
	#category : #'Lcs-Tests'
}

{ #category : #tests }
LcsBaseModuleTest >> testAddingAModule [
	| module |
	module := LcsBaseModule new.
	self assert: module hasNoModules.
	module buildModule: LcsDemonstrationModule.
	self assert: module hasModules.
	self assert: ((module moduleNamed: LcsDemonstrationModule moduleName) isKindOf: LcsDemonstrationModule) 
]

{ #category : #tests }
LcsBaseModuleTest >> testCreation [
	| module |
	module := LcsBaseModule new.
	self assert: module parent isNil.
	self assert: module modules class equals: LcsModules.
	self assert: module hasNoModules.
	self assert: module parent isNil
]
