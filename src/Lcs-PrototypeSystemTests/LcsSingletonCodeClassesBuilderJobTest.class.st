Class {
	#name : #LcsSingletonCodeClassesBuilderJobTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'codeJobBuilder'
	],
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #accessing }
LcsSingletonCodeClassesBuilderJobTest >> codeJobBuilder [
	^ codeJobBuilder
]

{ #category : #accessing }
LcsSingletonCodeClassesBuilderJobTest >> codeJobBuilder: anObject [
	codeJobBuilder := anObject
]

{ #category : #'as yet unclassified' }
LcsSingletonCodeClassesBuilderJobTest >> tearDown [
	self codeJobBuilder ifNotNil: [ :builder | builder uninstall].
	super tearDown.
	self codeJobBuilder ifNotNil: [ :builder | builder verifyUninstall]
]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testCreationOfSingletonClasses [
	| person |
	self codeJobBuilder:
		(LcsSingletonCodeClassesBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Gender';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installGlobalCollectionSlotInModuleClass: LxxPersonsModule;
			addCodeSubclassWithRootNamed: 'Male';
			addCodeSubclassWithRootNamed: 'Female';
			addCodeSubclassWithRootNamed: 'UnknownGender'
				with: [ :classBuilder | classBuilder beDefaultInstance ];
			targetModuleClass: LxxPrototypeSystem;
			installMemberSlotInDomainClass: LxxBasePerson;
			buildJobSteps;
			yourself).
	self codeJobBuilder execute.

	person := LxxPerson new.
	self assert: person gender identicalTo: (self currentSystem moduleNamed: 'Persons Module') genders defaultInstance
]
