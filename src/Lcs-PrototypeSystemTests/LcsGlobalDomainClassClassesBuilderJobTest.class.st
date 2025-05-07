Class {
	#name : #LcsGlobalDomainClassClassesBuilderJobTest,
	#superclass : #LcsCodeJobBuilderTest,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #tests }
LcsGlobalDomainClassClassesBuilderJobTest >> testCreationOfNewDomainClassAndItsGlobalCollectionInstalledInAModule [
	| aSample |
	self codeJobBuilder:
		(LcsGlobalDomainClassClassesBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Sample';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installGlobalCollectionSlotInModuleClass: LxxPrototypeSystem;
			buildJobSteps;
			yourself).
	self codeJobBuilder execute.

	aSample := 'LxxSample' asClass new.
	self assert: aSample class name asString = 'LxxSample'.
	self assert: aSample parent identicalTo: self currentSystem samples.
]
