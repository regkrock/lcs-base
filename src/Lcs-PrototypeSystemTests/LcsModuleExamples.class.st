Class {
	#name : 'LcsModuleExamples',
	#superclass : 'LcsExamples',
	#traits : 'LtApplicationEnvironmntExamplesManagement',
	#classTraits : 'LtApplicationEnvironmntExamplesManagement classTrait',
	#category : 'Lcs-PrototypeSystemTests-Examples',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsModuleExamples >> moduleNotFoundError [
	<gtExample>
	<noTest>
	self ensureCurrentSystemIsPrototypeSystem.
	self assert: self currentSystem notNil.
	self should: [ self currentSystem moduleNamed: 'xxxx' ] raise: LcsModuleNotFoundError.
	^ self currentSystem moduleNamed: 'xxxx'
]

{ #category : 'tests' }
LcsModuleExamples >> newDemonstrationModule [
	<gtExample>
	<after: #restoreSuspendedApplicationEnvironment>
	| existingNumberOfModules newModule environment |
	environment := self newApplicationEnvironmentWithNoSystems.
	LxxPrototypeSystem new.
	existingNumberOfModules := self currentSystem modules collectionSize.
	self
		should: [ self currentSystem moduleNamed: LxxDemonstrationModule defaultModuleName ]
		raise: LcsModuleNotFoundError.
	newModule := self currentSystem installModule: LxxDemonstrationModule.
	self
		assert: self currentSystem modules collectionSize
		equals: existingNumberOfModules + 1.
	self
		assert: ((self currentSystem moduleNamed: LxxDemonstrationModule defaultModuleName)
				isKindOf: LxxDemonstrationModule).
	^ newModule
]
