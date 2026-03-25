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

{ #category : 'examples' }
LxxPrototypeSystemExamples >> addOnlyGetterAndThenDeleteTheSlot [
	<gtExample>
	self verifyRemovedDomainSlotNamed: 'dummy'.
	LxxPrototypeSystem compile: 'dummy'.
	self assert: (LxxPrototypeSystem class compiledMethodAt: #dummySlotDefinition ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy ifAbsent: [ nil ]) notNil.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy: ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem instVarNames includes: #dummy) not.
	self removeDomainSlotNamed: 'dummy'.
	^ LxxPrototypeSystem
]

{ #category : 'examples' }
LxxPrototypeSystemExamples >> addOnlyInstVarAndThenDeleteTheSlot [
	<gtExample>
	self verifyRemovedDomainSlotNamed: 'dummy'.
	LxxPrototypeSystem addInstVarNamed: 'dummy'.
	self assert: (LxxPrototypeSystem class compiledMethodAt: #dummySlotDefinition ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy: ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem instVarNames includes: #dummy).
	self removeDomainSlotNamed: 'dummy'.
	^ LxxPrototypeSystem
]

{ #category : 'examples' }
LxxPrototypeSystemExamples >> addOnlySetterAndThenDeleteTheSlot [
	<gtExample>
	self verifyRemovedDomainSlotNamed: 'dummy'.
	LxxPrototypeSystem compile: 'dummy: anObject'.
	self assert: (LxxPrototypeSystem class compiledMethodAt: #dummySlotDefinition ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy: ifAbsent: [ nil ]) notNil.
	self assert: (LxxPrototypeSystem instVarNames includes: #dummy) not.
	self removeDomainSlotNamed: 'dummy'.
	^ LxxPrototypeSystem
]

{ #category : 'examples' }
LxxPrototypeSystemExamples >> addOnlySlotDefintionMethodAndThenDeleteTheSlot [
	<gtExample>
	self verifyRemovedDomainSlotNamed: 'dummy'.
	LxxPrototypeSystem class compile: 'dummySlotDefinition'.
	self assert: (LxxPrototypeSystem class compiledMethodAt: #dummySlotDefinition ifAbsent: [ nil ]) notNil.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy: ifAbsent: [ nil ]) isNil.
	self deny: (LxxPrototypeSystem instVarNames includes: #dummy).

	LxxPrototypeSystem removeDomainSlotNamed: 'dummy'.
	self removeDomainSlotNamed: 'dummy'.
	^ LxxPrototypeSystem
]

{ #category : 'examples' }
LxxPrototypeSystemExamples >> addSlotComponentsAndThenDeleteTheSlot [
	<gtExample>
	self verifyRemovedDomainSlotNamed: 'dummy'.
	LxxPrototypeSystem class compile: 'dummySlotDefinition'.
	LxxPrototypeSystem compile: 'dummy'.
	LxxPrototypeSystem compile: 'dummy: anObject'.
	LxxPrototypeSystem addInstVarNamed: 'dummy'.
	self assert: (LxxPrototypeSystem class compiledMethodAt: #dummySlotDefinition ifAbsent: [ nil ]) notNil.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy ifAbsent: [ nil ]) notNil.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy: ifAbsent: [ nil ]) notNil.
	self assert: (LxxPrototypeSystem instVarNames includes: #dummy).
	self removeDomainSlotNamed: 'dummy'.
	^ LxxPrototypeSystem
]

{ #category : 'examples' }
LxxPrototypeSystemExamples >> historyCreationWithNewDomainObject [
	<gtExample>
	| domainObject |
	self ensureCurrentSystemIsPrototypeSystem.
	self currentSystem clearUnitOfWork.
	domainObject := LcsDomainObject new.

	"Set parent to a 'nonsensical' value so changes can be applied. This is a hack for this test"
	domainObject instVarNamed: 'parent' put: self currentSystem.
	
	self currentSystem applyChanges.
	self assert: domainObject creationDate equals: domainObject history creationTimestamp asDate.
	self assert: domainObject creationDate equals: Date today.
	self assert: domainObject creationTimestamp equals: domainObject history creationTimestamp.
	self assert: domainObject lastUpdatedDate equals: domainObject history creationTimestamp asDate.
	self assert: domainObject lastUpdatedTimestamp equals: domainObject history creationTimestamp.
	self assert: domainObject creator equals: self currentSystem currentUser.
	self assert: domainObject history userUuid isInteger
]

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

{ #category : 'examples' }
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

{ #category : 'private' }
LxxPrototypeSystemExamples >> removeDomainSlotNamed: aString [
	LxxPrototypeSystem removeDomainSlotNamed: aString.
	self verifyRemovedDomainSlotNamed: aString
]

{ #category : 'examples' }
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

{ #category : 'examples' }
LxxPrototypeSystemExamples >> restoredSuspendedSystem [
	<gtExample>
	| system |
	system := self suspendedCurrentSystem.	
	system restoreSystem.
	self assert: self currentSystem == system.
	self assert: system isInActiveStatus.
	^ self subject
]

{ #category : 'examples' }
LxxPrototypeSystemExamples >> suspendedCurrentSystem [
	<gtExample>
	| system |
	system := self newPrototypeSystem.
	system suspendSystem.
	self assert: system isInSuspendedStatus.
	self assert: self currentSystem isNil.
	^ system
]

{ #category : 'examples' }
LxxPrototypeSystemExamples >> unitOfWorkWithNewObject [
	<gtExample>
	| domainObject |
	self ensureCurrentSystemIsBasicSystem.
	self clearUnitOfWork.
	domainObject := LcsDomainObject new.
	self assert: self currentUnitOfWork addedObjects size equals: 1.
	self assert: self currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentUnitOfWork changedObjects isEmpty.
	self assert: (self currentUnitOfWork addedObjects any isKindOf: LcsAddedObjectRecord).
	self assert: (self currentUnitOfWork addedObjects keys includes:  domainObject).
	self clearUnitOfWork
]

{ #category : 'private' }
LxxPrototypeSystemExamples >> verifyRemovedDomainSlotNamed: aString [
	self assert: (LxxPrototypeSystem instVarNames includes: aString asSymbol) not.
	self
		assert: (LxxPrototypeSystem class compiledMethodAt: aString asSymbol ifAbsent: [ nil ])
				isNil.
	self
		assert: (LxxPrototypeSystem compiledMethodAt: (aString , ':') asSymbol ifAbsent: [ nil ])
				isNil.
	self
		assert: (LxxPrototypeSystem class
				compiledMethodAt: (aString , 'SlotDefinition') asSymbol
				ifAbsent: [ nil ]) isNil
]
