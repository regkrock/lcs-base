Class {
	#name : #LcsGlobalDomainClassClassesBuilderJobTest,
	#superclass : #LcsCodeJobBuilderTest,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #tests }
LcsGlobalDomainClassClassesBuilderJobTest >> testCreationOfNewDomainClassAndItsGlobalCollectionInstalledInAModule [
	| country |
	self codeJobBuilder:
		(LcsGlobalDomainClassClassesBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Country';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installGlobalCollectionSlotInModuleClass: LxxPrototypeSystem;
			buildJobSteps;
			yourself).
	self codeJobBuilder execute.

	country := 'LxxCountry' asClass new.
	self assert: country class name asString = 'LxxCountry'.
	self assert: country parent identicalTo: self currentSystem countries.
]
