Class {
	#name : 'LcsDomainObjectTest',
	#superclass : 'LcsPrototypeSystemRunningTest',
	#category : 'Lcs-PrototypeSystemTests-Tests',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsDomainObjectTest >> testCreatingNewDomainObject [
	| domainObject |
	
	self assert: self currentUnitOfWork hasNoChanges.

	domainObject := LcsDomainObject new.

	self assert: self currentUnitOfWork addedObjects size equals: 1.
	self assert: self currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentUnitOfWork changedObjects isEmpty.
	self assert: (self currentUnitOfWork addedObjects any isKindOf: LcsAddedObjectRecord).
	self assert: (self currentUnitOfWork addedObjects keys includes:  domainObject)
]

{ #category : 'tests' }
LcsDomainObjectTest >> testHistoryCreationWithNewDomainObject [
	| domainObject |
		
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

{ #category : 'tests' }
LcsDomainObjectTest >> testRemoveDomainSlot [
	LxxPrototypeSystem removeDomainSlotNamed: 'dummy'.
	self assert: (LxxPrototypeSystem instVarNames includes: #dummy) not.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy: ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem class compiledMethodAt: #dummySlotDefinition ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem hasSlotDefinitionNamed: 'dummy') not

]

{ #category : 'tests' }
LcsDomainObjectTest >> testRemoveDomainSlotDefinitionIsDefined [

	LxxPrototypeSystem compile: 'dummySlotDefinition'.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummySlotDefinition ifAbsent: [ nil ]) notNil.

	LxxPrototypeSystem removeDomainSlotNamed: 'dummy'.
	self assert: (LxxPrototypeSystem instVarNames includes: #dummy) not.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy: ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem class compiledMethodAt: #dummySlotDefinition ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem hasSlotDefinitionNamed: 'dummy') not

]

{ #category : 'tests' }
LcsDomainObjectTest >> testRemoveDomainSlotWhereOnlyGetterIsDefined [

	LxxPrototypeSystem compile: 'dummy'.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy ifAbsent: [ nil ]) notNil.

	LxxPrototypeSystem removeDomainSlotNamed: 'dummy'.
	self assert: (LxxPrototypeSystem instVarNames includes: #dummy) not.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy: ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem class compiledMethodAt: #dummySlotDefinition ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem hasSlotDefinitionNamed: 'dummy') not

]

{ #category : 'tests' }
LcsDomainObjectTest >> testRemoveDomainSlotWhereOnlyInstanceVariableIsDefined [

	LxxPrototypeSystem addInstVarNamed: #dummy.
	self assert: (LxxPrototypeSystem instVarNames includes: #dummy).

	LxxPrototypeSystem removeDomainSlotNamed: 'dummy'.
	self assert: (LxxPrototypeSystem instVarNames includes: #dummy) not.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy: ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem class compiledMethodAt: #dummySlotDefinition ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem hasSlotDefinitionNamed: 'dummy') not

]

{ #category : 'tests' }
LcsDomainObjectTest >> testRemoveDomainSlotWhereOnlySetterIsDefined [

	LxxPrototypeSystem compile: 'dummy: anObject'.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy: ifAbsent: [ nil ]) notNil.

	LxxPrototypeSystem removeDomainSlotNamed: 'dummy'.
	self assert: (LxxPrototypeSystem instVarNames includes: #dummy) not.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem compiledMethodAt: #dummy: ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem class compiledMethodAt: #dummySlotDefinition ifAbsent: [ nil ]) isNil.
	self assert: (LxxPrototypeSystem hasSlotDefinitionNamed: 'dummy') not

]
