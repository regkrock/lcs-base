Class {
	#name : #LcsStandardCodeWithUnknownClassClassesBuilderJobTest,
	#superclass : #LcsCodeJobBuilderTest,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> testCreationOfSingletonClasses [
	| person |
	self codeJobBuilder:
		(LcsStandardCodeWithUnknownClassClassesBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Title';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installGlobalCollectionSlotInModuleClass: LxxPersonsModule;
			createProtoCodesFromLabels: #('Mr' 'Ms' '');
			targetModuleClass: LxxPrototypeSystem;
			installMemberSlotInDomainClass: LxxBasePerson;
			buildUnknownClass: true;
			yourself).
	self codeJobBuilder buildJobSteps.
	self codeJobBuilder execute.

	person := LxxPerson new.
	self assert: person title identicalTo: (self currentSystem moduleNamed: 'Persons Module') titles defaultInstance
]
