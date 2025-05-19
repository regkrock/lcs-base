Class {
	#name : #LcsGlobalDomainClassClassesBuilderJobTest,
	#superclass : #LcsCodeJobBuilderTest,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #tests }
LcsGlobalDomainClassClassesBuilderJobTest >> testCreationOfNewDomainClassAndItsGlobalCollectionClassInstalledInAModule [
	self codeJobBuilder:
		(LcsDomainClassAndGlobalCollectionClassBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Sample';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installGlobalCollectionSlotInModuleClass: LxxPrototypeSystem;
			buildJobSteps;
			yourself).
	self codeJobBuilder execute
]

{ #category : #tests }
LcsGlobalDomainClassClassesBuilderJobTest >> testCreationOfNewDomainClassWithUnknownClassAndItsGlobalCollectionInstalledInAModule [
	self codeJobBuilder:
		(LcsDomainClassAndGlobalCollectionClassBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Sample';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installGlobalCollectionSlotInModuleClass: LxxPrototypeSystem;
			buildUnknownClass: true;
			buildJobSteps;
			yourself).
	self codeJobBuilder execute
]
