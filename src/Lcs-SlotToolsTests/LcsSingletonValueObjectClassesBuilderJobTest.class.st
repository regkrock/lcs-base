Class {
	#name : 'LcsSingletonValueObjectClassesBuilderJobTest',
	#superclass : 'LcsCodeJobBuilderTest',
	#category : 'Lcs-SlotToolsTests-Tests',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsSingletonValueObjectClassesBuilderJobTest >> testCreationOfSingletonClasses [
	| person |
	self currentCodeBuilderJob:
		(LcsSingletonValueObjectClassesBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Gender';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installCollectionSlotInClass: LxxPersonsModule;
			addValueObjectSubclassWithRootNamed: 'Male';
			addValueObjectSubclassWithRootNamed: 'Female';
			addValueObjectSubclassWithRootNamed: 'UnknownGender'
				with: [ :classBuilder | classBuilder beDefaultInstance ];
			targetModuleClass: LxxPrototypeSystem;
			installMemberSlotInDomainClass: LxxBasePerson;
			yourself).
	self currentCodeBuilderJob buildJobSteps.
	self currentCodeBuilderJob execute.

	person := LxxPerson new.
	self assert: person gender identicalTo: (self currentSystem moduleNamed: 'Persons Module') genders defaultInstance
]
