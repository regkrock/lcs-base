Class {
	#name : 'LcsSlotModelExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SystemManagementTests-Exampless',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Exampless'
}

{ #category : 'tests' }
LcsSlotModelExamples >> baseDomainObjectWithEmptySlotModel [
	<gtExample>
	| slotModel |
	self ensureNoCurrentSystem.
	LcsBaseDomainObject releaseSlotModel.
	self assert: LcsBaseDomainObject slotModel isNil.
	
	slotModel := LcsBaseDomainObject initializeSlotModel slotModel.
	self assert: slotModel notNil.
	self
		assert: LcsBaseDomainObject slotModel domainClass
		equals: LcsBaseDomainObject.
	self assert: LcsBaseDomainObject slotModel domainSuperClass == LcsObject.
	^ slotModel
]

{ #category : 'tests' }
LcsSlotModelExamples >> baseDomainObjectWithSlotModelWithParentAccessorSlot [
	<gtExample>
	| slot slotModel |
	slotModel := self baseDomainObjectWithEmptySlotModel.
	slot := LcsParentSlot new.
	self deny: (slotModel hasSlotDefinitionNamed: 'parent').

	slotModel installSlotDefinition: slot.

	self assert: (slotModel hasSlotDefinitionNamed: 'parent').
	self deny: (slotModel hasFacadeSlotDefinitionNamed: 'parent').
	self deny: (slotModel hasVirtualSlotDefinitionNamed: 'parent').
	self assert: slotModel hasSlotDefinitions.
	self assert: (slotModel hasAccessorSlotDefinitionNamed: 'parent').
	self assert: (slotModel hasSlotDefinitionNamed: 'parent').
	self assert: (slotModel slotDefinitionNamed: 'parent') == slot.
	self assert: (slotModel accessorSlotDefinitions includes: slot).
	self assert: slotModel facadeSlotDefinitions isEmpty.
	self assert: slotModel virtualSlotDefinitions isEmpty.
	self assert: (slotModel allAccessorSlotDefinitions includes: slot).
	self assert: slotModel allFacadeSlotDefinitions isEmpty.
	self assert: slotModel allVirtualSlotDefinitions isEmpty.
	self assert: (slotModel allLocalSlotDefinitions includes: slot).
	self assert: (slotModel allSlotDefinitions includes: slot).
	self assert: slotModel allCollectionItemSlotDefinitions isEmpty.
	self assert: slotModel domainSuperClass identicalTo: LcsObject.
	self assert: slotModel domainClass = LcsBaseDomainObject.
	self assert: slotModel domainSuperClassSlotModel isNil.
	^ slotModel
]

{ #category : 'tests' }
LcsSlotModelExamples >> domainObjectWithSlotModelAndBaseDomainObjectWithSlotModel [
	<gtExample>
	| slotModel localAccessorSlot localVirtualSlot  localFacadeSlot baseSlotModel baseAccessorSlot baseVirtualSlot baseFacadeSlot |
	
	baseSlotModel := self baseDomainObjectWithEmptySlotModel.
	slotModel := LcsDomainObject initializeSlotModel slotModel.

	"Setup LcsBaseDomainObject slot model"
	baseAccessorSlot := LcsAccessorSlot new slotName: 'baseAccessorSlot'.
	baseVirtualSlot := (LcsVirtualSlot new slotName: 'baseVirtualSlot').
	baseFacadeSlot := (LcsFacadeSlot new slotName: 'baseFacadeSlot').
	baseSlotModel installSlotDefinition: baseAccessorSlot.
	baseSlotModel installSlotDefinition: baseVirtualSlot.
	baseSlotModel installSlotDefinition: baseFacadeSlot.

	"Setup LcsDomainObject slot model"
	localAccessorSlot := LcsDateOfBirthSlot new slotName: 'localAccessorSlot'.
	localVirtualSlot := (LcsVirtualSlot new slotName: 'localVirtualSlot').
	localFacadeSlot := (LcsFacadeSlot new slotName: 'localFacadeSlot').
	slotModel installSlotDefinition: localAccessorSlot.
	slotModel installSlotDefinition: localVirtualSlot.
	slotModel installSlotDefinition: localFacadeSlot.

	self assert: (slotModel hasSlotDefinitionNamed: 'localAccessorSlot').
	self assert: (slotModel hasSlotDefinitionNamed: 'localFacadeSlot').
	self assert: (slotModel hasSlotDefinitionNamed: 'localVirtualSlot').
	self assert: (slotModel hasSlotDefinitionNamed: 'baseAccessorSlot').
	self assert: (slotModel hasSlotDefinitionNamed: 'baseFacadeSlot').
	self assert: (slotModel hasSlotDefinitionNamed: 'baseVirtualSlot').
	
	self assert: (slotModel hasAccessorSlotDefinitionNamed: 'localAccessorSlot').
	self assert: (slotModel hasAccessorSlotDefinitionNamed: 'baseAccessorSlot').
	self assert: (slotModel hasFacadeSlotDefinitionNamed: 'localFacadeSlot').
	self assert: (slotModel hasFacadeSlotDefinitionNamed: 'baseFacadeSlot').
	self assert: (slotModel hasVirtualSlotDefinitionNamed: 'localVirtualSlot').
	self assert: (slotModel hasVirtualSlotDefinitionNamed: 'baseVirtualSlot').
	
	self assert: (slotModel accessorSlotDefinitions includes: localAccessorSlot).
	self deny: (slotModel accessorSlotDefinitions includes: baseAccessorSlot).
	self assert: (slotModel facadeSlotDefinitions includes: localFacadeSlot).
	self deny: (slotModel facadeSlotDefinitions includes: baseFacadeSlot).
	self assert: (slotModel virtualSlotDefinitions includes: localVirtualSlot).
	self deny: (slotModel virtualSlotDefinitions includes: baseVirtualSlot).

	self assert: (slotModel allAccessorSlotDefinitions includes: localAccessorSlot).
	self deny: (slotModel allFacadeSlotDefinitions includes: localAccessorSlot).
	self deny: (slotModel allVirtualSlotDefinitions includes: localAccessorSlot).
	
	self deny: (slotModel allAccessorSlotDefinitions includes: localFacadeSlot).
	self assert: (slotModel allFacadeSlotDefinitions includes: localFacadeSlot).
	self deny: (slotModel allVirtualSlotDefinitions includes: localFacadeSlot).

	self deny: (slotModel allAccessorSlotDefinitions includes: localVirtualSlot).
	self deny: (slotModel allFacadeSlotDefinitions includes: localVirtualSlot).
	self assert: (slotModel allVirtualSlotDefinitions includes: localVirtualSlot).
	
	self assert: (slotModel allAccessorSlotDefinitions includes: baseAccessorSlot).
	self assert: (slotModel allFacadeSlotDefinitions includes: baseFacadeSlot).
	self assert: (slotModel allVirtualSlotDefinitions includes: baseVirtualSlot).

	self assert: (slotModel allLocalSlotDefinitions includes: localAccessorSlot).
	self deny: (slotModel allLocalSlotDefinitions includes: baseAccessorSlot).
	self assert: (slotModel allLocalSlotDefinitions includes: localVirtualSlot).
	self deny: (slotModel allLocalSlotDefinitions includes: baseVirtualSlot).
	self assert: (slotModel allLocalSlotDefinitions includes: localFacadeSlot).
	self deny: (slotModel allLocalSlotDefinitions includes: baseFacadeSlot).

	self assert: slotModel allCollectionItemSlotDefinitions isEmpty.
	
	^ slotModel
]

{ #category : 'examples' }
LcsSlotModelExamples >> newSlotModel [
	<gtExample>
	| slotModel |
	self ensureNoCurrentSystem.
	self assert: self currentSystem isNil.
	slotModel := LcsSlotModel new.
	self assert: slotModel domainClass isNil.
	self assert: slotModel slotDefinitionsCollections size = 4.
	self assert: slotModel slotDefinitionsSelectors size = 4.
	self assert: slotModel accessorSlotDefinitions isEmpty.
	self assert: slotModel collectionItemSlotDefinitions isEmpty.
	self assert: slotModel facadeSlotDefinitions isEmpty.
	self assert: slotModel virtualSlotDefinitions isEmpty.
	self assert: slotModel allAccessorSlotDefinitions isEmpty.
	self assert: slotModel allCollectionItemSlotDefinitions isEmpty.
	self assert: slotModel allFacadeSlotDefinitions isEmpty.
	self assert: slotModel allVirutalSlotDefinitions isEmpty.
	self assert: slotModel allSlotDefinitions isEmpty.
	self assert: slotModel allLocalSlotDefinitions isEmpty.
	self deny: (slotModel hasAccessorSlotDefinitionNamed: 'foo').
	self deny: (slotModel hasCollectionItemSlotDefinitionNamed: 'foo').
	self deny: (slotModel hasFacadeSlotDefinitionNamed: 'foo').
	self deny: (slotModel hasVirtualSlotDefinitionNamed: 'foo').
	self assert: (slotModel accessorSlotDefinitionNamed: 'foo') isNil.
	self assert: (slotModel collectionItemSlotDefinitionNamed: 'foo') isNil.
	self assert: (slotModel facadeSlotDefinitionNamed: 'foo') isNil.
	self assert: (slotModel virtualSlotDefinitionNamed: 'foo') isNil.
	LcsBaseDomainObject slotModel
		ifNotNil: [ LcsBaseDomainObject releaseSlotModel ].
	self assert: LcsBaseDomainObject slotModel isNil.
	self assert: LcsDomainObject slotModel isNil.
	^ slotModel
]

{ #category : 'tests' }
LcsSlotModelExamples >> slotModelWithFacadeSlot [
	<gtExample>
	| slot slotModel |
	slot := LcsFacadeSlot new
			slotName: 'xxx';
			yourself.
	slotModel := self baseDomainObjectWithEmptySlotModel.
	self deny: (slotModel hasSlotDefinitionNamed: 'xxx').
	slotModel installSlotDefinition: slot.
	self assert: (slotModel hasFacadeSlotDefinitionNamed: 'xxx').
	self assert: (slotModel hasSlotDefinitionNamed: 'xxx').
	self assert: (slotModel slotDefinitionNamed: 'xxx') == slot.
	self assert: slot pragmaSelector equals: LcsBaseSlot facadeSlotDefinitionName.
	^ slotModel
]

{ #category : 'tests' }
LcsSlotModelExamples >> slotModelWithInstanceInLocalCollectionSlot [
	<gtExample>
	| slot slotModel |
	slot := LcsInstanceInLocalCollectionSlot new
			slotName: 'xxx';
			yourself.
	slotModel := self baseDomainObjectWithEmptySlotModel.
	self deny: (slotModel hasSlotDefinitionNamed: 'xxx').
	slotModel installSlotDefinition: slot.
	self assert: (slotModel hasCollectionItemSlotDefinitionNamed: 'xxx').
	self assert: (slotModel hasSlotDefinitionNamed: 'xxx').
	self assert: (slotModel slotDefinitionNamed: 'xxx') == slot.
	self
		assert: slot pragmaSelector
		equals: LcsBaseSlot collectionItemSlotDefinitionName.
	^ slot
]

{ #category : 'tests' }
LcsSlotModelExamples >> slotModelWithVirtualSlot [
	<gtExample>
	| slot slotModel |
	slotModel := self baseDomainObjectWithEmptySlotModel.
	slot := LcsVirtualSlot new
			slotName: 'xxx';
			yourself.
	self deny: (slotModel hasSlotDefinitionNamed: 'xxx').
	slotModel installSlotDefinition: slot.
	self assert: (slotModel hasVirtualSlotDefinitionNamed: 'xxx').
	self assert: (slotModel hasSlotDefinitionNamed: 'xxx').
	self assert: (slotModel slotDefinitionNamed: 'xxx') == slot.
	self assert: slot pragmaSelector equals: LcsBaseSlot virtualSlotDefinitionName.
	self assert: (slotModel allLocalSlotDefinitions includes: slot).
	self assert: (slotModel allLocalSlotDefinitions includes: slot).
	^ slotModel
]

{ #category : 'setUp-tearDown' }
LcsSlotModelExamples >> tearDown [
	LcsBaseDomainObject releaseSlotModel.
	self assert: LcsBaseDomainObject slotModel isNil.
	super tearDown.
]
