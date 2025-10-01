Class {
	#name : #LcsMainSystemTest,
	#superclass : #LcsTestWithNoTestSystemSetupForTest,
	#category : #'Lcs-MainSystemTests'
}

{ #category : #tests }
LcsMainSystemTest >> testConfigurationSlotDefinition [
	self assert: LcsMainSystem moduleConfigurationClass equals: LcsMainSystemConfiguration.
	self assert: (LcsMainSystem accessorSlotDefinitionPragmas detect: [ :each | each methodSelector = #configurationSlotDefinition ]) notNil.
	self assert: LcsMainSystem configurationSlotDefinition slotTypes size equals: 1.
	self assert: (LcsMainSystem configurationSlotDefinition slotTypes includes: LcsMainSystemConfiguration).
]

{ #category : #tests }
LcsMainSystemTest >> testCreation [

	| currentUnitOfWork |

	self subject: LcsMainSystem new.
	self assert: self currentSystem notNil.
	self assert: self subject == self currentSystem.
	self assert: LcsGeographyModule moduleConfigurationClass equals: LcsGeographyModuleConfiguration.	
	
	currentUnitOfWork := self currentSystem currentUnitOfWork.
	self assert: LcsApplicationEnvironment unitsOfWorkManager  hasUnitsOfWork. 
	self assert: currentUnitOfWork notNil.
	self assert: currentUnitOfWork system identicalTo: self currentSystem.
	self assert: self currentSystem notNil.
	self assert: (LcsPerson slotDefinitionNamed: #dateOfBirth) slotName equals: #dateOfBirth.
	self assert: (self currentSystem moduleNamed: LcsGeographyModule defaultModuleName) notNil.
	self assert: (self subject configuration isKindOf: LcsMainSystem moduleConfigurationClass).
	self assert: self subject configuration parent equals: self subject.
	
	self assert: self subject geographyModule configuration parent equals:  self subject geographyModule.
	self assert: (self subject geographyModule configuration isKindOf: LcsGeographyModule moduleConfigurationClass)
	
	
]

{ #category : #tests }
LcsMainSystemTest >> testGeographyModuleConfigurationSlotDefinition [
	self assert: LcsGeographyModule moduleConfigurationClass equals: LcsGeographyModuleConfiguration.
	self assert: (LcsGeographyModule accessorSlotDefinitionPragmas detect: [ :each | each methodSelector = #configurationSlotDefinition ]) notNil.
	self assert: LcsGeographyModule configurationSlotDefinition slotTypes size equals: 1.
	self assert: (LcsGeographyModule configurationSlotDefinition slotTypes includes: LcsGeographyModuleConfiguration).
]
