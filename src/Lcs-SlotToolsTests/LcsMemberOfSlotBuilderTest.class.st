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
	self assert: (LxxPerson hasSlotDefinitionNamed: 'gender') not.
	self assert: (LxxPersonsModule includesSelector: #'genders')
]

{ #category : #tests }
LcsMemberOfSlotBuilderTest >> testAddingMemberOfRelationship [
	| classesModel |
	self createGenderClassesWithoutAddingMemberOfToPerson.
	self subject: (
		LcsMemberOfSlotBuilder new
			targetClassName: 'LxxPerson';
			slotName: 'gender';
			collectionSlotName: 'genders';
			collectionSlotModuleName: LxxPersonsModule defaultModuleName;
			addSlotType: 'LxxGender';
			yourself).
	classesModel := self subject classesModel.
	self assert: classesModel collection size = 2.
	self assert: (classesModel classModelForClassname: 'LxxPerson') notNil.
	self assert: (classesModel classModelForClassname: 'LxxGenders') notNil.
	self assert: (classesModel classModelForClassname: 'LxxPerson') associations size = 1.
	self assert: (classesModel classModelForClassname: 'LxxGenders') associations isEmpty.
	self assert: (classesModel classModelForClassname: 'LxxPerson') associations first associationName = 'gender'.
	self assert: (classesModel classModelForClassname: 'LxxPerson') associations first toClassModel = ((classesModel classModelForClassname: 'LxxGenders')).
	self subject buildJobSteps.
	self subject execute.
	
	self assert: ('LxxPerson' asClass new gender isKindOf: 'LxxUnknownGender' asClass).
	
]

{ #category : #tests }
LcsMemberOfSlotBuilderTest >> testCreation [
	<TODO: 'need to add test for creation of slot definition method'>
	self assert: LcsMemberOfSlotBuilder slotDefinitionClass equals: LcsMemberOfSlot
]
