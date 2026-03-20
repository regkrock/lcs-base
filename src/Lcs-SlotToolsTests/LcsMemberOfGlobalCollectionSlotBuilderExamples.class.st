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
	| builder |
	builder := self newBuilder
				targetClassName: 'LxxPerson';
				slotName: 'gender';
				collectionSlotName: 'genders';
				collectionSlotModuleName: LxxPersonsModule defaultModuleName;
				addSlotType: 'LxxGender';
				yourself.
	builder buildJobSteps.
	^ builder
]

{ #category : 'examples' }
LcsMemberOfGlobalCollectionSlotBuilderExamples >> genderMemberOfGlobalCollectionSlotBuilderUmlModel [
	<gtExample>
	| builder umlModel |
	builder := self genderMemberOfGlobalCollectionSlotBuilder.
	umlModel := builder umlModel.
	self assert: umlModel collection size = 3.
	self assert: (umlModel classModelForClassname: 'LxxPerson') notNil.
	"self assert: (classesModel classModelForClassname: 'LxxGenders') notNil."
	"self assert: (umlModel classModelForClassname: 'LxxPerson') associations size = 1."
	"self assert: (classesModel classModelForClassname: 'LxxGenders') associations isEmpty."
	"self assert: (umlModel classModelForClassname: 'LxxPerson') associations first associationName = 'gender'."
	"self assert: (classesModel classModelForClassname: 'LxxPerson') associations first toClassModel = ((classesModel classModelForClassname: 'LxxGenders'))."
	^ umlModel
]

{ #category : 'tests' }
LcsMemberOfGlobalCollectionSlotBuilderExamples >> installGlobalMemberOfInPersonPointingToGenders [
	<gtExample>
	| genderBuilderJob builder |
	self ensureCurrentSystemIsPrototypeSystem.
	self currentSystem clearUnitOfWork.
	genderBuilderJob := LcsSingletonValueObjectClassesBuilderJobExamples new
							genderSingletonPatternBuilderJobWithoutInstallationOfGenderSlotInPerson.
	builder := self genderMemberOfGlobalCollectionSlotBuilder.
	[ genderBuilderJob execute.
	  genderBuilderJob verifyCodeInstallation.
	  builder execute.
	  builder verifyCodeInstallation.
	  self assert: ('LxxPerson' asClass new gender isKindOf: 'LxxUnknownGender' asClass). ]
		ensure: [
			builder uninstall.
			builder verifyUninstall.
			genderBuilderJob uninstall.
			genderBuilderJob verifyUninstall ].
	^ builder
]

{ #category : 'examples' }
LcsMemberOfGlobalCollectionSlotBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsMemberOfGlobalCollectionSlotBuilder new.
	^ builder
]
