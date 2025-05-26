Class {
	#name : #LcsSingletonCodeClassesBuilderJobTest,
	#superclass : #LcsCodeJobBuilderTest,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testCreationOfSingletonClasses [
	| person |
	self currentCodeBuilderJob:
		(LcsSingletonCodeClassesBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Gender';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installCollectionSlotInClass: LxxPersonsModule;
			addCodeSubclassWithRootNamed: 'Male';
			addCodeSubclassWithRootNamed: 'Female';
			addCodeSubclassWithRootNamed: 'UnknownGender'
				with: [ :classBuilder | classBuilder beDefaultInstance ];
			targetModuleClass: LxxPrototypeSystem;
			installMemberSlotInDomainClass: LxxBasePerson;
			yourself).
	self currentCodeBuilderJob buildJobSteps.
	self currentCodeBuilderJob execute.

	person := LxxPerson new.
	self assert: person gender identicalTo: (self currentSystem moduleNamed: 'Persons Module') genders defaultInstance
]
