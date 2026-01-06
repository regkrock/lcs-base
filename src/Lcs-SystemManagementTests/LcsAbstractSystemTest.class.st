Class {
	#name : 'LcsAbstractSystemTest',
	#superclass : 'LcsTestWithNoTestSystemSetupForTest',
	#category : 'Lcs-SystemManagementTests-Tests',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsAbstractSystemTest >> assertConfigurationSlotDefinition: aModuleClass [
	| aConfigurationClass |
	aConfigurationClass := (aModuleClass name , 'Configuration') asClass.
	self assert: aModuleClass moduleConfigurationClass equals: aConfigurationClass.
	self assert: (aModuleClass accessorSlotDefinitionPragmas
										detect: [ :each | each methodSelector = #configurationSlotDefinition ] 
										ifNone: [ nil] )
								notNil.
	self assert: aModuleClass configurationSlotDefinition slotTypes size equals: 1.
	self assert: (aModuleClass configurationSlotDefinition slotTypes includes: aConfigurationClass)
]

{ #category : 'assertions' }
LcsAbstractSystemTest >> assertCurrentSystemSetTo: aSystemClass [
	| currentUnitOfWork |
	self assert: self currentSystem notNil.
	self assert: self subject == self currentSystem.
	self assert: self subject class identicalTo: aSystemClass.
	self assert: self currentSystem identicalTo: self subject.
	currentUnitOfWork := self currentSystem currentUnitOfWork.
	self assert: LcsApplicationEnvironment unitsOfWorkManager hasUnitsOfWork.
	self assert: currentUnitOfWork notNil.
	self assert: currentUnitOfWork system identicalTo: self currentSystem.
	self assertModuleConfigured: aSystemClass
]

{ #category : 'assertions' }
LcsAbstractSystemTest >> assertModuleConfigured: aModuleClass [
	| aModule |
	self assert: aModuleClass moduleConfigurationClass name equals: aModuleClass name , 'Configuration'.
	aModule := self currentSystem moduleNamed: aModuleClass defaultModuleName.
	self assert: aModule notNil.
	self assert: aModule configuration parent identicalTo: aModule.
	self assertConfigurationSlotDefinition: aModuleClass.
]
