Class {
	#name : 'LcsMemberOfLocalCollectionSlotBuilderExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> genderMemberOfGlobalCollectionSlotBuilder [
	<gtExample>
	| builder umlModel |
	builder := self newMemberOfGlobalCollectionSlotBuilder
				targetClassName: 'LxxPerson';
				slotName: 'gender';
				collectionSlotName: 'genders';
				collectionSlotModuleName: LxxPersonsModule defaultModuleName;
				addSlotType: 'LxxGender';
				yourself.
	builder buildJobSteps.
	umlModel := builder umlModel.
	self assert: umlModel collection size = 3.
	self assert: (umlModel classModelForClassname: 'LxxPerson') notNil.
	"self assert: (classesModel classModelForClassname: 'LxxGenders') notNil."
	self assert: (umlModel classModelForClassname: 'LxxPerson') associations size = 1.
	"self assert: (classesModel classModelForClassname: 'LxxGenders') associations isEmpty."
	self assert: (umlModel classModelForClassname: 'LxxPerson') associations first associationName = 'gender'.
	"self assert: (classesModel classModelForClassname: 'LxxPerson') associations first toClassModel = ((classesModel classModelForClassname: 'LxxGenders'))."
	^ builder
]

{ #category : 'support' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> installGenderClassesWithoutAddingMemberOfToPerson [
	<gtExample>
	| builderJob |
	builderJob :=
		LcsSingletonValueObjectClassesBuilderJobExamples new genderSingletonPatternBuilderJob.
	builderJob execute.
	builderJob verifyCodeInstallation.
	^ builderJob
]

{ #category : 'tests' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> installGendersBuilderJob [
	| genderBuilderJob |
	genderBuilderJob :=self installGenderClassesWithoutAddingMemberOfToPerson.
	self subject: self genderMemberOfGlobalCollectionSlotBuilder.
	self subject execute.
	self assert: ('LxxPerson' asClass new gender isKindOf: 'LxxUnknownGender' asClass).
	
]

{ #category : 'support' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> installLxxInvoiceAndLxxInvoices [
	| invoiceBuilderJob invoiceItemBuilderJob |
	invoiceBuilderJob := self invoiceAndInvoicesBuilderJob.
	invoiceBuilderJob execute.
	invoiceBuilderJob verifyCodeInstallation.
	
	invoiceItemBuilderJob := self invoiceItemAndInvoiceItemsBuilderJob.
	invoiceItemBuilderJob execute.
	invoiceItemBuilderJob verifyCodeInstallation
]

{ #category : 'support' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> invoiceAndInvoicesBuilderJob [
	^ LcsDomainClassAndGlobalCollectionClassBuilderJobExamples new invoiceAndInvoicesBuilderJob
]

{ #category : 'support' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> invoiceItemAndInvoiceItemsBuilderJob [
	^ LcsDomainClassAndLocalCollectionClassBuilderJobExamples new invoiceItemAndLocalInvoiceItemsCreationJob
]

{ #category : 'examples' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> invoiceItemMemberOfGlobalCollectionSlotBuilder [
	<gtExample>
	| builder umlModel |
	builder := self newMemberOfGlobalCollectionSlotBuilder
						targetClassName: 'LxxPerson';
						slotName: 'invoiceItem';
						collectionSlotName: 'invoiceItems';
						collectionSourceClassName: 'LxxInvoiceItems';
						addSlotType: 'LxxInvoiceItem';
						yourself.
	builder buildJobSteps.
	umlModel := builder umlModel.
	self assert: umlModel collection size = 3.
	self assert: (umlModel classModelForClassname: 'LxxPerson') notNil.
	"self assert: (classesModel classModelForClassname: 'LxxInvoiceItems') notNil."
	"self assert: (umlModel classModelForClassname: 'LxxPerson') associations size = 1."
	"self assert: (classesModel classModelForClassname: 'LxxInvoiceItems') associations isEmpty."
	"self 
		assert: (umlModel classModelForClassname: 'LxxPerson') associations first associationName 
		equals:  'invoiceItem'."	
	"self 
		assert: (classesModel classModelForClassname: 'LxxPerson') associations first toClassModel 
		equals: ((classesModel classModelForClassname: 'LxxInvoiceItems'))."

	^ builder
]

{ #category : 'examples' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> newMemberOfGlobalCollectionSlotBuilder [
	<gtExample>
	| builder |
	builder := LcsMemberOfGlobalCollectionSlotBuilder new.
	^ builder
]

{ #category : 'tests' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> testAddingMemberOfRelationshipFromDomainObjectToLocalCollection [
	<TODO: 'The commented out assertion fails. The cause is that LcsMemberOfSlotDefinition is not properly wired for a local member of situation. Especially for initialization.'>
	| invoiceBuilderJob invoiceItemBuilder |
	invoiceBuilderJob := self installLxxInvoiceAndLxxInvoices.
	invoiceItemBuilder := self invoiceItemMemberOfGlobalCollectionSlotBuilder.
	self subject execute.	
	"self assert: ('LxxPerson' asClass new invoiceItem isNil )."
]

{ #category : 'tests' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> testCreateGenderClassesWithoutAddingMemberOfToPerson [
	self installGenderClassesWithoutAddingMemberOfToPerson
]
