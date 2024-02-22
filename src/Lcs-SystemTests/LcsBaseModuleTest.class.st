Class {
	#name : #LcsBaseModuleTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SystemTests'
}

{ #category : #accessing }
LcsBaseModuleTest >> testAddingAModule [
	| module |
	module := LcsBaseModule new.
	self assert: module hasNoModules.
	module buildModule: LcsDemonstrationModule.
	self assert: module hasModules.
	self assert: ((module moduleNamed: LcsDemonstrationModule moduleName) isKindOf: LcsDemonstrationModule) 
]

{ #category : #accessing }
LcsBaseModuleTest >> testCreation [
	| module |
	module := LcsBaseModule new.
	self assert: module parent isNil.
	self assert: module modules class = LcsModules.
	self assert: module hasNoModules.
	self assert: module parent isNil
]
