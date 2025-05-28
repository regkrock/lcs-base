Class {
	#name : #LcsDomainClassAndGlobalCollectionClassBuilderJobTest,
	#superclass : #LcsCodeJobBuilderTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
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

{ #category : #tests }
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
