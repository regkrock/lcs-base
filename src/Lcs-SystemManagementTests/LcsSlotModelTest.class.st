Class {
	#name : 'LcsSlotModelTest',
	#superclass : 'LcsTestWithNoTestSystemSetupForTest',
	#category : 'Lcs-SystemManagementTests-Tests',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Tests'
}

{ #category : 'setUp-tearDown' }
LcsSlotModelTest >> tearDown [
	LcsBaseDomainObject releaseSlotModel.
	self assert: LcsBaseDomainObject slotModel isNil.
	super tearDown.
]

{ #category : 'tests' }
LcsSlotModelTest >> testAddAccessorSlotDefinition [
	| slot |
	slot := LcsParentSlot new.
	self subject: (LcsBaseDomainObject initializeSlotModel) slotModel.
	self deny: (self subject hasSlotDefinitionNamed: 'parent').
	self subject installSlotDefinition: slot.
	self assert: (self subject hasAccessorSlotDefinitionNamed: 'parent').
	self assert: (self subject hasSlotDefinitionNamed: 'parent').
	self assert: (self subject slotDefinitionNamed: 'parent') == slot.
	self assert: slot pragmaSelector equals: LcsBaseSlot accessorSlotDefinitionName
]

{ #category : 'tests' }
LcsSlotModelTest >> testAddCollectionItemSlotDefinition [
	| slot |
	slot := LcsInstanceInLocalCollectionSlot new
			slotName: 'xxx';
			yourself.
	self subject: LcsBaseDomainObject initializeSlotModel slotModel.
	self deny: (self subject hasSlotDefinitionNamed: 'xxx').
	self subject installSlotDefinition: slot.
	self assert: (self subject hasCollectionItemSlotDefinitionNamed: 'xxx').
	self assert: (self subject hasSlotDefinitionNamed: 'xxx').
	self assert: (self subject slotDefinitionNamed: 'xxx') == slot.
	self assert: slot pragmaSelector equals: LcsBaseSlot collectionItemSlotDefinitionName
]

{ #category : 'tests' }
LcsSlotModelTest >> testAddFacadeSlotDefinition [
	| slot |
	slot := LcsFacadeSlot new
			slotName: 'xxx';
			yourself.
	self subject: LcsBaseDomainObject initializeSlotModel slotModel.
	self deny: (self subject hasSlotDefinitionNamed: 'xxx').
	self subject installSlotDefinition: slot.
	self assert: (self subject hasFacadeSlotDefinitionNamed: 'xxx').
	self assert: (self subject hasSlotDefinitionNamed: 'xxx').
	self assert: (self subject slotDefinitionNamed: 'xxx') == slot.
	self assert: slot pragmaSelector equals: LcsBaseSlot facadeSlotDefinitionName
]

{ #category : 'tests' }
LcsSlotModelTest >> testAddVirtualSlotDefinition [
	| slot |
	slot := LcsVirtualSlot new
			slotName: 'xxx';
			yourself.
	self subject: LcsBaseDomainObject initializeSlotModel slotModel.
	self deny: (self subject hasSlotDefinitionNamed: 'xxx').
	self subject installSlotDefinition: slot.
	self assert: (self subject hasVirtualSlotDefinitionNamed: 'xxx').
	self assert: (self subject hasSlotDefinitionNamed: 'xxx').
	self assert: (self subject slotDefinitionNamed: 'xxx') == slot.
	self assert: slot pragmaSelector equals: LcsBaseSlot virtualSlotDefinitionName.
	self assert: (self subject allLocalSlotDefinitions includes: slot).
	self assert: (self subject allLocalSlotDefinitions includes: slot)
]

{ #category : 'tests' }
LcsSlotModelTest >> testAllAccessSlotDefinitions [
	| allSlotDefinitions |
	LcsBaseDomainObject initializeSlotModel.
	LcsDomainObject initializeSlotModel.
	LcsBaseDomainObject slotModel installSlotDefinition: LcsParentSlot new.
	LcsDomainObject slotModel installSlotDefinition: (LcsAccessorSlot new slotName: 'xxx').
	
	allSlotDefinitions := LcsDomainObject slotModel allAccessorSlotDefinitions.
	self assert: (allSlotDefinitions detect: [ :each | each slotName = 'parent'] ifNone: [ nil ]) notNil.
	self assert: (allSlotDefinitions detect: [ :each | each slotName = 'xxx'] ifNone: [ nil ]) notNil.

	allSlotDefinitions := LcsDomainObject slotModel accessorSlotDefinitions values.
	self assert: (allSlotDefinitions detect: [ :each | each slotName = 'parent'] ifNone: [ nil ]) isNil.
	self assert: (allSlotDefinitions detect: [ :each | each slotName = 'xxx'] ifNone: [ nil ]) notNil.
]

{ #category : 'tests' }
LcsSlotModelTest >> testAllCollectionItemSlotDefinitions [
	| allSlotDefinitions |
	LcsBaseDomainObject initializeSlotModel.
	LcsDomainObject initializeSlotModel.
	LcsBaseDomainObject slotModel installSlotDefinition: (LcsInstanceInLocalCollectionSlot new slotName: 'yyy').
	LcsDomainObject slotModel installSlotDefinition: (LcsInstanceInLocalCollectionSlot new slotName: 'xxx').

	allSlotDefinitions := LcsDomainObject slotModel allCollectionItemSlotDefinitions.
	self assert: (allSlotDefinitions detect: [ :each | each slotName = 'zzz'] ifNone: [ nil ]) isNil.
	self assert: (allSlotDefinitions detect: [ :each | each slotName = 'yyy'] ifNone: [ nil ]) notNil.
	self assert: (allSlotDefinitions detect: [ :each | each slotName = 'xxx'] ifNone: [ nil ]) notNil.

	allSlotDefinitions := LcsDomainObject slotModel collectionItemSlotDefinitions values.
	self assert: (allSlotDefinitions detect: [ :each | each slotName = 'yyy'] ifNone: [ nil ]) isNil.
	self assert: (allSlotDefinitions detect: [ :each | each slotName = 'xxx'] ifNone: [ nil ]) notNil.
]

{ #category : 'tests' }
LcsSlotModelTest >> testAllFacadeSlotDefinitions [
	| allSlotDefinitions |
	LcsBaseDomainObject initializeSlotModel.
	LcsDomainObject initializeSlotModel.
	LcsBaseDomainObject slotModel installSlotDefinition: (LcsFacadeSlot new slotName: 'yyy').
	LcsDomainObject slotModel installSlotDefinition: (LcsFacadeSlot new slotName: 'xxx').

	allSlotDefinitions := LcsDomainObject slotModel allFacadeSlotDefinitions.
	self assert: (allSlotDefinitions detect: [ :each | each slotName = 'yyy'] ifNone: [ nil ]) notNil.
	self assert: (allSlotDefinitions detect: [ :each | each slotName = 'xxx'] ifNone: [ nil ]) notNil.

	allSlotDefinitions := LcsDomainObject slotModel facadeSlotDefinitions values.
	self assert: (allSlotDefinitions detect: [ :each | each slotName = 'yyy'] ifNone: [ nil ]) isNil.
	self assert: (allSlotDefinitions detect: [ :each | each slotName = 'xxx'] ifNone: [ nil ]) notNil.
]

{ #category : 'tests' }
LcsSlotModelTest >> testAllSlotDefinitions [
	| slotDefinitions |
	LcsBaseDomainObject initializeSlotModel.
	LcsDomainObject initializeSlotModel.
	LcsBaseDomainObject slotModel installSlotDefinition: LcsParentSlot new.
	LcsBaseDomainObject slotModel installSlotDefinition: (LcsFacadeSlot new slotName: 'yyy').
	LcsDomainObject slotModel installSlotDefinition: (LcsFacadeSlot new slotName: 'zzz').
	LcsDomainObject slotModel installSlotDefinition: (LcsAccessorSlot new slotName: 'xxx').
	slotDefinitions := LcsDomainObject slotModel allSlotDefinitions.
	self assert: (slotDefinitions detect: [ :each | each slotName = 'parent'] ifNone: [ nil ]) notNil.
	self assert: (slotDefinitions detect: [ :each | each slotName = 'xxx'] ifNone: [ nil ]) notNil.
	self assert: (slotDefinitions detect: [ :each | each slotName = 'zzz'] ifNone: [ nil ]) notNil.
]

{ #category : 'tests' }
LcsSlotModelTest >> testAllVirtualSlotDefinitions [
	| allSlotDefinitions |
	LcsBaseDomainObject initializeSlotModel.
	LcsDomainObject initializeSlotModel.
	LcsBaseDomainObject slotModel installSlotDefinition: (LcsVirtualSlot new slotName: 'yyy').
	LcsDomainObject slotModel installSlotDefinition: (LcsVirtualSlot new slotName: 'xxx').

	allSlotDefinitions := LcsDomainObject slotModel allVirtualSlotDefinitions.
	self assert: (allSlotDefinitions detect: [ :each | each slotName = 'yyy'] ifNone: [ nil ]) notNil.
	self assert: (allSlotDefinitions detect: [ :each | each slotName = 'xxx'] ifNone: [ nil ]) notNil.

	allSlotDefinitions := LcsDomainObject slotModel virtualSlotDefinitions values.
	self assert: (allSlotDefinitions detect: [ :each | each slotName = 'yyy'] ifNone: [ nil ]) isNil.
	self assert: (allSlotDefinitions detect: [ :each | each slotName = 'xxx'] ifNone: [ nil ]) notNil.
]

{ #category : 'tests' }
LcsSlotModelTest >> testAssigningDomainClass [
	self subject: LcsSlotModel new.
	self assert: LcsBaseDomainObject slotModel isNil.
	self subject initializeOn: LcsBaseDomainObject.
	self assert: self subject domainClass equals: LcsBaseDomainObject.
	self assert: LcsBaseDomainObject slotModel isNil.
	LcsBaseDomainObject slotModel: self subject.
	self assert: LcsBaseDomainObject slotModel equals: self subject
]

{ #category : 'tests' }
LcsSlotModelTest >> testCreation [
	self subject: LcsSlotModel new.
	self assert: self subject domainClass isNil.
	self assert: self subject slotDefinitionsCollections size = 4.
	self assert: self subject slotDefinitionsSelectors size = 4.
	self assert: self subject accessorSlotDefinitions isEmpty.
	self assert: self subject collectionItemSlotDefinitions isEmpty.
	self assert: self subject facadeSlotDefinitions isEmpty.
	self assert: self subject virtualSlotDefinitions isEmpty.
	self assert: self subject allAccessorSlotDefinitions isEmpty.
	self assert: self subject allCollectionItemSlotDefinitions isEmpty.
	self assert: self subject allFacadeSlotDefinitions isEmpty.
	self assert: self subject allVirutalSlotDefinitions isEmpty.
	self assert: self subject allSlotDefinitions isEmpty.
	self assert: self subject allLocalSlotDefinitions isEmpty.
	self deny: (self subject hasAccessorSlotDefinitionNamed: 'foo').
	self deny: (self subject hasCollectionItemSlotDefinitionNamed: 'foo').
	self deny: (self subject hasFacadeSlotDefinitionNamed: 'foo').
	self deny: (self subject hasVirtualSlotDefinitionNamed: 'foo').
	self assert: (self subject accessorSlotDefinitionNamed: 'foo')  isNil.
	self assert: (self subject collectionItemSlotDefinitionNamed: 'foo') isNil.
	self assert: (self subject facadeSlotDefinitionNamed: 'foo') isNil.
	self assert: (self subject virtualSlotDefinitionNamed: 'foo') isNil
]

{ #category : 'tests' }
LcsSlotModelTest >> testInitializeSlotModelInDomainClass [
	self assert: LcsBaseDomainObject slotModel isNil.
	LcsBaseDomainObject initializeSlotModel.
	self assert: LcsBaseDomainObject slotModel notNil.
	self
		assert: LcsBaseDomainObject slotModel domainClass
		equals: LcsBaseDomainObject.
	self assert: LcsBaseDomainObject slotModel domainSuperClass == LcsObject
]
