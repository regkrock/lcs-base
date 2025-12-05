Class {
	#name : 'LcsDomainClassAndGlobalCollectionClassBuilderJobTest',
	#superclass : 'LcsCodeJobBuilderTest',
	#category : 'Lcs-SlotToolsTests-Tests',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsDomainClassAndGlobalCollectionClassBuilderJobTest >> testCreationClassesModel [
	| modelClasses |
	self currentCodeBuilderJob:
		(LcsDomainClassAndGlobalCollectionClassBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Sample';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installCollectionSlotInClass: LxxPrototypeSystem;
			buildUnknownClass: true;
			buildJobSteps;
			yourself).
	modelClasses := self currentCodeBuilderJob umlModel.
	self assert: modelClasses collection notEmpty.
	self assert: modelClasses collection size = 11.
	self assert: (modelClasses allClassModelsFor: 'LxxSample') size = 1.
	self assert: (modelClasses allClassModelsFor: 'LxxUnknownSample') size = 1.
	self assert: (modelClasses allClassModelsFor: 'LcsDomainObject') size = 1.
	self assert: (modelClasses allClassModelsFor: 'LcsDomainCollection') size = 1.
	self assert: (modelClasses allClassModelsFor: 'LxxSamples') size = 1.
	self assert: (modelClasses allClassModelsFor: 'LxxPrototypeSystem') size = 1.
	self assert: (modelClasses allClassModelsFor: 'LcsObjectsLoader') size = 1.
	self assert: (modelClasses allClassModelsFor: 'LxxSamplesLoader') size = 1.
	self assert: (modelClasses allClassModelsFor: 'LcsGlobalCollectionSlot') size = 1.
	self assert: (modelClasses allClassModelsFor: 'LcsDomainObjectSlot') size = 1.
]

{ #category : 'tests' }
LcsDomainClassAndGlobalCollectionClassBuilderJobTest >> testCreationOfNewDomainClassAndItsGlobalCollectionClassInstalledInAModule [
	self currentCodeBuilderJob:
		(LcsDomainClassAndGlobalCollectionClassBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Sample';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installCollectionSlotInClass: LxxPrototypeSystem;
			buildJobSteps;
			yourself).
	self currentCodeBuilderJob execute
]

{ #category : 'tests' }
LcsDomainClassAndGlobalCollectionClassBuilderJobTest >> testCreationOfNewDomainClassWithUnknownClassAndItsGlobalCollectionInstalledInAModule [
	self currentCodeBuilderJob:
		(LcsDomainClassAndGlobalCollectionClassBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Sample';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installCollectionSlotInClass: LxxPrototypeSystem;
			buildUnknownClass: true;
			buildJobSteps;
			yourself).
	self currentCodeBuilderJob execute
]
