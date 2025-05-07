Class {
	#name : #LcsStandardCodeClassesBuilderJobTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'codeJobBuilder'
	],
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #accessing }
LcsStandardCodeClassesBuilderJobTest >> codeJobBuilder [
	^ codeJobBuilder
]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJobTest >> codeJobBuilder: anObject [
	codeJobBuilder := anObject
]

{ #category : #'as yet unclassified' }
LcsStandardCodeClassesBuilderJobTest >> tearDown [
	self codeJobBuilder ifNotNil: [ :builder | builder uninstall].
	super tearDown.
	self codeJobBuilder ifNotNil: [ :builder | builder verifyUninstall]
]

{ #category : #tests }
LcsStandardCodeClassesBuilderJobTest >> testCreationOfSingletonClasses [
	| person |
	self codeJobBuilder:
		(LcsStandardCodeClassesBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Title';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installGlobalCollectionSlotInModuleClass: LxxPersonsModule;
			createProtoCodesFromLabels: #('Mr' 'Ms' '');
			targetModuleClass: LxxPrototypeSystem;
			installMemberSlotInDomainClass: LxxBasePerson;
			buildJobSteps;
			yourself).
	self codeJobBuilder execute.

	person := LxxPerson new.
	self assert: person title identicalTo: (self currentSystem moduleNamed: 'Persons Module') titles defaultInstance
]
