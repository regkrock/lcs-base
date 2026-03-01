Class {
	#name : 'LcsBaseSystemExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-BaseTests-Examples',
	#package : 'Lcs-BaseTests',
	#tag : 'Examples'
}

{ #category : 'assertions' }
LcsBaseSystemExamples >> assertConfigurationSlotDefinition: aModuleClass [
	| aConfigurationClass |
	aConfigurationClass := (aModuleClass name , 'Configuration') asClass.
	self assert: aModuleClass moduleConfigurationClass equals: aConfigurationClass.
	self assert: (aModuleClass accessorSlotDefinitionPragmas
						detect: [ :each | each methodSelector = #configurationSlotDefinition ] 
						ifNone: [ nil] ) notNil.
	self assert: aModuleClass configurationSlotDefinition slotTypes size equals: 1.
	self assert: (aModuleClass configurationSlotDefinition slotTypes includes: aConfigurationClass)
]

{ #category : 'assertions' }
LcsBaseSystemExamples >> assertCurrentSystemSetTo: aSystemClass [
	| currentUnitOfWork |
	self assert: self currentSystem notNil.
	self assert: self currentSystem identicalTo: self subject.
	self assert: self subject class identicalTo: aSystemClass.
	self assert: (LcsApplicationEnvironment systemsManager hasSystem: self subject).
	currentUnitOfWork := self currentSystem unitOfWork.
	self assert: currentUnitOfWork notNil.
	self assert: LcsApplicationEnvironment unitsOfWorkManager hasUnitsOfWork.
	self assert: (LcsApplicationEnvironment unitsOfWorkManager hasUnitOfWork: currentUnitOfWork).
	self assert: currentUnitOfWork system identicalTo: self currentSystem.

	self assertModuleConfigured: aSystemClass
]

{ #category : 'assertions' }
LcsBaseSystemExamples >> assertModuleConfigured: aModuleClass [
	| aModule |
	self assert: aModuleClass moduleConfigurationClass name equals: aModuleClass name , 'Configuration'.
	aModule := self subject moduleNamed: aModuleClass defaultModuleName.
	self assert: aModule notNil.
	self assert: aModule configuration parent identicalTo: aModule.
	self assertConfigurationSlotDefinition: aModuleClass.
]
