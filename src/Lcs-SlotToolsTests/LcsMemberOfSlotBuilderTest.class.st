Class {
	#name : #LcsMemberOfSlotBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #support }
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

{ #category : #support }
LcsMemberOfSlotBuilderTest >> createLxxInvoiceAndLxxInvoices [
	self currentCodeBuilderJob:
		(LcsDomainClassAndGlobalCollectionClassBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Invoice';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installCollectionSlotInClass: LxxPrototypeSystem;
			buildJobSteps;
			yourself).
	self currentCodeBuilderJob execute.
	self assert: self currentSystem invoices notNil.
	self assert: (self currentSystem invoices isKindOf: #LxxInvoices asClass).

	self currentCodeBuilderJob:
		(LcsDomainClassAndLocalCollectionClassBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'InvoiceItem';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installCollectionSlotInClass: #LxxInvoice asClass;
			buildJobSteps;
			yourself).
	self currentCodeBuilderJob execute.
]

{ #category : #tests }
LcsMemberOfSlotBuilderTest >> testAddingMemberOfRelationshipFromDomainObjectToGlobalCollection [
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
LcsMemberOfSlotBuilderTest >> testAddingMemberOfRelationshipFromDomainObjectToLocalCollection [
	<TODO: 'The commented out assertion fails. The cause is that LcsMemberOfSlotDefinition is not properly wired for a local member of situation. Especially for initialization.' >
	| classesModel |
	self createLxxInvoiceAndLxxInvoices.
	self subject: (
		LcsMemberOfSlotBuilder new
			targetClassName: 'LxxPerson';
			slotName: 'invoiceItem';
			collectionSlotName: 'invoiceItems';
			collectionSourceClassName: 'LxxInvoiceItems';
			addSlotType: 'LxxInvoiceItem';
			yourself).
	classesModel := self subject classesModel.
	self assert: classesModel collection size = 2.
	self assert: (classesModel classModelForClassname: 'LxxPerson') notNil.
	self assert: (classesModel classModelForClassname: 'LxxInvoiceItems') notNil.
	self assert: (classesModel classModelForClassname: 'LxxPerson') associations size = 1.
	self assert: (classesModel classModelForClassname: 'LxxInvoiceItems') associations isEmpty.
	self assert: (classesModel classModelForClassname: 'LxxPerson') associations first associationName = 'invoiceItem'.
	self assert: (classesModel classModelForClassname: 'LxxPerson') associations first toClassModel = ((classesModel classModelForClassname: 'LxxInvoiceItems')).
	self subject buildJobSteps.
	self subject execute.
	
	"self assert: ('LxxPerson' asClass new invoiceItem isNil )."
	
]

{ #category : #tests }
LcsMemberOfSlotBuilderTest >> testCreation [
	<TODO: 'need to add test for creation of slot definition method'>
	self assert: LcsMemberOfSlotBuilder slotDefinitionClass equals: LcsMemberOfSlot
]
