Class {
	#name : 'LcsMemberOfGlobalCollectionSlotBuilderExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsMemberOfGlobalCollectionSlotBuilderExamples >> genderMemberOfGlobalCollectionSlotBuilder [
	<gtExample>
	| builder umlModel |
	builder := self newBuilder
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
LcsMemberOfGlobalCollectionSlotBuilderExamples >> gendersBuilderJob [
	^ LcsSingletonValueObjectClassesBuilderJobExamples new genderSingletonPatternBuilderJob
]

{ #category : 'examples' }
LcsMemberOfGlobalCollectionSlotBuilderExamples >> installGenderClassesWithoutAddingMemberOfToPerson [
	<gtExample>
	| builderJob |
	builderJob := self gendersBuilderJob.
	builderJob execute.
	builderJob verifyCodeInstallation.
	^ builderJob
]

{ #category : 'tests' }
LcsMemberOfGlobalCollectionSlotBuilderExamples >> installGendersBuilderJob [
	| genderBuilderJob |
	genderBuilderJob :=self installGenderClassesWithoutAddingMemberOfToPerson.
	self subject: self genderMemberOfGlobalCollectionSlotBuilder.
	self subject execute.
	self assert: ('LxxPerson' asClass new gender isKindOf: 'LxxUnknownGender' asClass).
	
]

{ #category : 'examples' }
LcsMemberOfGlobalCollectionSlotBuilderExamples >> installLxxInvoiceAndLxxInvoices [
	| invoiceBuilderJob invoiceItemBuilderJob |
	invoiceBuilderJob := self invoiceAndInvoicesBuilderJob.
	invoiceBuilderJob execute.
	invoiceBuilderJob verifyCodeInstallation.
	
	invoiceItemBuilderJob := self invoiceItemAndInvoiceItemsBuilderJob.
	invoiceItemBuilderJob execute.
	invoiceItemBuilderJob verifyCodeInstallation
]

{ #category : 'support' }
LcsMemberOfGlobalCollectionSlotBuilderExamples >> invoiceAndInvoicesBuilderJob [
	^ LcsDomainClassAndGlobalCollectionClassBuilderJobExamples new
		invoiceAndInvoicesBuilderJob
]

{ #category : 'support' }
LcsMemberOfGlobalCollectionSlotBuilderExamples >> invoiceItemAndInvoiceItemsBuilderJob [
	^ LcsDomainClassAndLocalCollectionClassBuilderJobExamples new invoiceItemAndLocalInvoiceItemsCreationJob
]

{ #category : 'examples' }
LcsMemberOfGlobalCollectionSlotBuilderExamples >> invoiceItemMemberOfGlobalCollectionSlotBuilder [
	<gtExample>
	| builder umlModel |
	builder := self newBuilder
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
LcsMemberOfGlobalCollectionSlotBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsMemberOfGlobalCollectionSlotBuilder new.
	^ builder
]

{ #category : 'tests' }
LcsMemberOfGlobalCollectionSlotBuilderExamples >> testAddingMemberOfRelationshipFromDomainObjectToLocalCollection [
	<TODO: 'The commented out assertion fails. The cause is that LcsMemberOfSlotDefinition is not properly wired for a local member of situation. Especially for initialization.'>
	| invoiceBuilderJob invoiceItemBuilder |
	invoiceBuilderJob := self installLxxInvoiceAndLxxInvoices.
	invoiceItemBuilder := self invoiceItemMemberOfGlobalCollectionSlotBuilder.
	self subject execute.	
	"self assert: ('LxxPerson' asClass new invoiceItem isNil )."
]

{ #category : 'tests' }
LcsMemberOfGlobalCollectionSlotBuilderExamples >> testCreateGenderClassesWithoutAddingMemberOfToPerson [
	self installGenderClassesWithoutAddingMemberOfToPerson
]
