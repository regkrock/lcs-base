Class {
	#name : 'LcsModuleExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-PrototypeSystemTests-Examples',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsModuleExamples >> newDemonstrationModule [
	<gtExample>
	| existingNumberOfModules newModule |
	self ensureCurrentSystemIsPrototypeSystem.
	self assert: self currentSystem notNil.
	existingNumberOfModules := self currentSystem modules collectionSize.
	newModule := self currentSystem installModule: LxxDemonstrationModule.
	self assert: self currentSystem modules collectionSize equals: existingNumberOfModules + 1.
	self assert: (( self currentSystem moduleNamed: LxxDemonstrationModule defaultModuleName) isKindOf: LxxDemonstrationModule).
	^ newModule 
]
