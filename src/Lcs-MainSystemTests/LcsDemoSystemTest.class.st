Class {
	#name : #LcsDemoSystemTest,
	#superclass : #LcsTestWithNoTestSystemSetupForTest,
	#category : #'Lcs-MainSystemTests'
}

{ #category : #tests }
LcsDemoSystemTest >> testConfigurationSlotDefinition [
	self assert: LcsDemoSystem moduleConfigurationClass equals: LcsDemoSystemConfiguration.
	self assert: (LcsDemoSystem accessorSlotDefinitionPragmas detect: [ :each | each methodSelector = #configurationSlotDefinition ]) notNil.
	self assert: LcsDemoSystem configurationSlotDefinition slotTypes size equals: 1.
	self assert: (LcsDemoSystem configurationSlotDefinition slotTypes includes: LcsDemoSystemConfiguration).
]

{ #category : #tests }
LcsDemoSystemTest >> testCreation [

	| currentUnitOfWork |

	self subject: LcsDemoSystem new.
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
	self assert: (self subject configuration isKindOf: LcsDemoSystem moduleConfigurationClass).
	self assert: self subject configuration parent equals: self subject.
	
	self assert: self subject geographyModule configuration parent equals:  self subject geographyModule.
	self assert: (self subject geographyModule configuration isKindOf: LcsGeographyModule moduleConfigurationClass)
	
	
]

{ #category : #tests }
LcsDemoSystemTest >> testGeographyModuleConfigurationSlotDefinition [
	self assert: LcsGeographyModule moduleConfigurationClass equals: LcsGeographyModuleConfiguration.
	self assert: (LcsGeographyModule accessorSlotDefinitionPragmas detect: [ :each | each methodSelector = #configurationSlotDefinition ]) notNil.
	self assert: LcsGeographyModule configurationSlotDefinition slotTypes size equals: 1.
	self assert: (LcsGeographyModule configurationSlotDefinition slotTypes includes: LcsGeographyModuleConfiguration).
]
