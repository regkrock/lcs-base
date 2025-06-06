Class {
	#name : #LcsSingletonValueObjectClassesBuilderJobTest,
	#superclass : #LcsCodeJobBuilderTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsSingletonValueObjectClassesBuilderJobTest >> testCreationOfSingletonClasses [
	| person |
	self currentCodeBuilderJob:
		(LcsSingletonValueObjectClassesBuilderJob new
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
