Class {
	#name : #LcsStandardCodeWithUnknownClassClassesBuilderJobTest,
	#superclass : #LcsCodeJobBuilderTest,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #'as yet unclassified' }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> tearDown [
	self codeJobBuilder ifNotNil: [ :builder | builder uninstall].
	super tearDown.
	self codeJobBuilder ifNotNil: [ :builder | builder verifyUninstall]
]

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> testCreationOfSingletonClasses [
	| person |
	self codeJobBuilder:
		(LcsStandardCodeWithUnknownClassClassesBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Title';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installGlobalCollectionSlotInModuleClass: LxxPersonsModule;
			createProtoCodesFromLabels: #('Mr' 'Ms');
			targetModuleClass: LxxPrototypeSystem;
			installMemberSlotInDomainClass: LxxBasePerson;
			buildJobSteps;
			yourself).
	self codeJobBuilder execute.

	person := LxxPerson new.
	self assert: person title identicalTo: (self currentSystem moduleNamed: 'Persons Module') titles defaultInstance
]
