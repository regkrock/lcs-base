Class {
	#name : #LcsGlobalDomainClassClassesBuilderJobTest,
	#superclass : #LcsCodeJobBuilderTest,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #tests }
LcsGlobalDomainClassClassesBuilderJobTest >> testCreationOfNewDomainClassAndItsGlobalCollectionInstalledInAModule [
	self codeJobBuilder:
		(LcsGlobalDomainClassClassesBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Sample';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installGlobalCollectionSlotInModuleClass: LxxPrototypeSystem;
			buildJobSteps;
			yourself).
	self codeJobBuilder execute
]
