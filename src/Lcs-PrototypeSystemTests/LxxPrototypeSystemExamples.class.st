"
This is testing with no system setup in the setup. 


Use this to test creating a prototype system.

To see the application environment click on: {{gtClass:LcsApplicationEnvironment}}


"
Class {
	#name : 'LxxPrototypeSystemExamples',
	#superclass : 'LcsBaseSystemExamples',
	#category : 'Lcs-PrototypeSystemTests-Examples',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Examples'
}

{ #category : 'private' }
LxxPrototypeSystemExamples >> newPrototypeSystem [
	<gtExample>
	| system |
	system := LxxPrototypeSystem new.
	self assert: self currentSystem identicalTo: system.
	self assert: self currentUnitOfWork == system unitOfWork.
	self assert: self currentUnitOfWork hasNoChanges.
	self assert: system status isInActiveStatus.
	self assert: system status parent identicalTo: system.
	self assert: LcsBaseDomainObject isSlotModelReleased not.
	self assert: (system systemSlotModel hasSlotModelFor: system).
	self assert: (self unitsOfWorkManager unitOfWorkFor: system) system identicalTo: system.

	self assert: (self currentSystem slotDefinitionNamed: 'persons') notNil.
	self assert: self currentSystem persons class identicalTo: LxxPersons.
	self assert: self currentSystem persons collection class identicalTo: LcsSmalltalkConfiguration identitySetClass.
		
	self assert: LxxPerson slotModel hasSlotDefinitions.
	self assert: self currentSystem configuration class name equals: #LxxPrototypeSystemConfiguration.

	self assert: LcsBaseDomainObject isSlotModelReleased not.
	self assert: system moduleName equals: LxxPrototypeSystem defaultModuleName.

	self assert: self currentSystem identicalTo: system.
	self assert: (system moduleNamed: LxxPersonsModule defaultModuleName) class name equals: #LxxPersonsModule.
	self assert: (system moduleNamed: LxxPrototype2Module defaultModuleName) class equals: LxxPrototype2Module.
	self assert: system numberOfChildModules equals: 3. 
	self assert: (system moduleNamed: LxxPersonsModule defaultModuleName) numberOfChildModules equals: 0.
	self assert: (system moduleNamed: LxxPrototype2Module defaultModuleName) numberOfChildModules equals: 1.
	self assert: (system moduleNamed: LxxPrototype2Submodule defaultModuleName) numberOfChildModules equals: 0.
	
	^ system
]

{ #category : 'private' }
LxxPrototypeSystemExamples >> newPrototypeSystemWCreatedWhenNoCurrentSystem [
	<gtExample>
	| numberOfSystems numberOfUnitsOfWork system |
	self ensureNoCurrentSystem.
	numberOfSystems := self systemsManager numberOfSystems.
	numberOfUnitsOfWork := self unitsOfWorkManager numberOfUnitsOfWork.

	system := self newPrototypeSystem.

	self assert: self systemsManager numberOfSystems equals: numberOfSystems + 1.
	self assert: self unitsOfWorkManager numberOfUnitsOfWork equals: numberOfUnitsOfWork + 1.

	^ system
]

{ #category : 'tests' }
LxxPrototypeSystemExamples >> newSystemAfterItHasBeenSuspendedAndRestoredWhenAnotherSystemAvailableForSwapping [
	<gtExample>
	| secondSystem firstSystem |
	firstSystem := self newPrototypeSystemWCreatedWhenNoCurrentSystem.
	secondSystem := self newPrototypeSystem.
	self assert: firstSystem isInSuspendedStatus.
	self assert: secondSystem isInActiveStatus.
	self assert: self currentSystem identicalTo: secondSystem.
	
	secondSystem suspendSystem.
	self assert: firstSystem isInSuspendedStatus.
	self assert: secondSystem isInSuspendedStatus.
	self assert: self currentSystem isNil.

	secondSystem restoreSystem.
	self assert: firstSystem isInSuspendedStatus.
	self assert: secondSystem isInActiveStatus.
	self assert: self currentSystem identicalTo: secondSystem.
	
	firstSystem restoreSystem.
	self assert: firstSystem isInActiveStatus.
	self assert: secondSystem isInSuspendedStatus.
	self assert: self currentSystem identicalTo: firstSystem.
	
	secondSystem removeSystem.
	
	^ firstSystem
]

{ #category : 'tests' }
LxxPrototypeSystemExamples >> removedSystem [
	<gtExample>
	| system |
	system := self newPrototypeSystem.
	self assert: system isInActiveStatus.
	self assert: self currentSystem identicalTo: system.
	LcsApplicationEnvironment removeCurrentSystem.
	self assert: system isInSuspendedStatus.
	self assert: self systemsManager hasNoCurrentSystem.
	self assert: (self systemsManager systems includes: system) not.
	^ system
]

{ #category : 'tests' }
LxxPrototypeSystemExamples >> restoredSuspendedSystem [
	<gtExample>
	| system |
	system := self suspendedCurrentSystem.	
	system restoreSystem.
	self assert: self currentSystem == system.
	self assert: system isInActiveStatus.
	^ self subject
]

{ #category : 'tests' }
LxxPrototypeSystemExamples >> suspendedCurrentSystem [
	<gtExample>
	| system |
	system := self newPrototypeSystem.
	system suspendSystem.
	self assert: system isInSuspendedStatus.
	self assert: self currentSystem isNil.
	^ system
]
