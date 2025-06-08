Class {
	#name : #LcsMemberOfSlotBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #'as yet unclassified' }
LcsMemberOfSlotBuilderTest >> createGenderClassesWithoutAddingMemberOfToPerson [
	self currentCodeBuilderJob: (
		LcsSingletonValueObjectClassesBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Gender';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installCollectionSlotInClass: LxxPersonsModule;
			addCodeSubclassWithRootNamed: 'Male';
			addCodeSubclassWithRootNamed: 'Female';
			addCodeSubclassWithRootNamed: 'UnknownGender'
				with: [ :classBuilder | classBuilder beDefaultInstance ];
			targetModuleClass: LxxPrototypeSystem;
			"installMemberSlotInDomainClass: LxxBasePerson;"
			yourself).
	self currentCodeBuilderJob buildJobSteps.
	self currentCodeBuilderJob execute.
	self assert: (LxxPerson hasSlotDefinitionNamed: 'gender') not
]

{ #category : #tests }
LcsMemberOfSlotBuilderTest >> testAddingMemberOfRelationship [
	self createGenderClassesWithoutAddingMemberOfToPerson.
]

{ #category : #tests }
LcsMemberOfSlotBuilderTest >> testCreation [
	<TODO: 'need to add test for creation of slot definition method'>
	self assert: LcsMemberOfSlotBuilder slotDefinitionClass equals: LcsMemberOfSlot
]
