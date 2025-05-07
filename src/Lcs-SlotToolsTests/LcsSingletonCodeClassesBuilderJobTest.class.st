Class {
	#name : #LcsSingletonCodeClassesBuilderJobTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'builder'
	],
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #accessing }
LcsSingletonCodeClassesBuilderJobTest >> builder [
	^ builder
]

{ #category : #accessing }
LcsSingletonCodeClassesBuilderJobTest >> builder: anObject [
	builder := anObject
]

{ #category : #accessing }
LcsSingletonCodeClassesBuilderJobTest >> codeJobBuilder [
	^ codeJobBuilder
]

{ #category : #accessing }
LcsSingletonCodeClassesBuilderJobTest >> codeJobBuilder: anObject [
	codeJobBuilder := anObject
]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> jobBuilder [
	^ LcsSingletonCodeClassesBuilderJob new
		classPrefix: 'Lxx';
		installNewClassesInPackageNamed: 'Lcs-Temp';
		createForRootName: 'Gender';
		addCodeSubclassWithRootNamed: 'Male';
		addCodeSubclassWithRootNamed: 'Female';
		addCodeSubclassWithRootNamed: 'UnknownGender'
			with: [ :classBuilder | classBuilder beDefaultInstance ];
		installGlobalCollectionSlotInModuleClass: LxxPrototypeSystem;
		installMemberSlotInDomainClass: LxxPrototypePerson;
		yourself
]

{ #category : #running }
LcsSingletonCodeClassesBuilderJobTest >> removeAllArtifacts [
	LxxPrototypeSystem removeDomainSlotNamed: 'genders'.
	LxxPrototypePerson removeDomainSlotNamed: 'gender'.
	self removeClassesNamed: #('LxxUnknownGender' 'LxxFemale' 'LxxMale' 'LxxGender' 'LxxGenders').
	LxxPrototypePerson verifyClassHasNoDomainSlotNamed: 'gender'.
	LxxPrototypeSystem verifyClassHasNoDomainSlotNamed: 'genders'.

]

{ #category : #running }
LcsSingletonCodeClassesBuilderJobTest >> tearDown [
	self removeAllArtifacts.
	super tearDown
]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testCreatingJobToAddGenderCodesAndInstallGenderSlotInPerson_Phase1_BuildJob [
	| codeSubclassBuilder |

	builder := self jobBuilder.

	self assert: builder classPrefix equals: 'Lxx'.
	self assert: builder targetPackageName equals: 'Lcs-Temp'.
	self assert: builder completedRefactorings isEmpty.
	self assert: builder classRootName equals: 'Gender'.
	self assert: builder jobSteps hasNoJobSteps.

	self assert: builder domainInstanceSlotName equals: 'gender'.
	self assert: builder globalCollectionSlotName equals: 'genders'.
	self assert: builder newDomainClassName equals: 'LxxGender'.
	self assert: builder newGlobalCollectionClassName equals: 'LxxGenders'.
	self assert: builder globalCollectionModuleClass equals: LxxPrototypeSystem.

	self assert: builder codeSubclassBuilders size equals: 3.
	
	codeSubclassBuilder := builder codeSubclassBuilders at: 1.
	self assert: codeSubclassBuilder targetSuperclassName equals: 'LxxGender'.
	self assert: codeSubclassBuilder newClassName equals: 'LxxMale'.
	self assert: codeSubclassBuilder targetPackageName equals: 'Lcs-Temp'.
	self assert: codeSubclassBuilder shortName equals: 'Male'. 
	self assert: codeSubclassBuilder codeDescription equals: 'Male'. 
	self assert: codeSubclassBuilder codeName equals: 'male'. 
	self deny: codeSubclassBuilder isDefaultInstance.

	codeSubclassBuilder := builder codeSubclassBuilders at: 2.
	self assert: codeSubclassBuilder targetSuperclassName equals: 'LxxGender'.
	self assert: codeSubclassBuilder newClassName equals: 'LxxFemale'.
	self assert: codeSubclassBuilder targetPackageName equals: 'Lcs-Temp'.
	self assert: codeSubclassBuilder shortName equals: 'Female'. 
	self assert: codeSubclassBuilder codeDescription equals: 'Female'. 
	self assert: codeSubclassBuilder codeName equals: 'female'. 
	self deny: codeSubclassBuilder isDefaultInstance.

	codeSubclassBuilder := builder codeSubclassBuilders at: 3.
	self assert: codeSubclassBuilder targetSuperclassName equals: 'LxxGender'.
	self assert: codeSubclassBuilder newClassName equals: 'LxxUnknownGender'.
	self assert: codeSubclassBuilder targetPackageName equals: 'Lcs-Temp'.
	self assert: codeSubclassBuilder shortName equals: 'UnknownGender'. 
	self assert: codeSubclassBuilder codeDescription equals: 'UnknownGender'. 
	self assert: codeSubclassBuilder codeName equals: 'unknownGender'. 
	self assert: codeSubclassBuilder isDefaultInstance.

	"self assert: builder codeCollectionClassBuilder superclassName = 'LcsCodes'.
	self assert: builder codeCollectionClassBuilder newClassName equals: 'LxxGenders'.
	self assert: builder codeCollectionClassBuilder codePackageName equals: 'Lcs-PrototypeSystem'.

	self assert: builder codeSuperClassParentSlotDefinitionStep slotName equals: 'parent'.
	self assert: builder codeSuperClassParentSlotDefinitionStep moduleName equals: LxxPrototypeSystem moduleName.
	self assert: builder codeSuperClassParentSlotDefinitionStep collectionSlotName equals: 'genders'.

	self assert: builder globalCollectionSlotBuilder slotName equals: 'genders'.
	self assert: builder globalCollectionSlotBuilder moduleName equals: LxxPrototypeSystem moduleName.
	self assert: builder globalCollectionSlotBuilder targetClassName equals: 'LxxPrototypeSystem'.
	self assert: builder globalCollectionSlotBuilder target equals: LxxBarebonesSystem.
	self assert: builder globalCollectionSlotBuilder slotClassName equals: 'LxxGenders'.

	self assert: builder memberOfSlotInDomainClassBuilder slotName equals: 'gender'.
	self assert: builder memberOfSlotInDomainClassBuilder collectionSlotName equals: 'genders'.
	self assert: builder memberOfSlotInDomainClassBuilder moduleName equals: LxxPrototypeSystem moduleName	"
	
	"self assert: (builder memberOfSlotBuilder slotTypes includes: 'LxxGender' asClass)"
]

{ #category : #private }
LcsSingletonCodeClassesBuilderJobTest >> testCreatingJobToAddGenderCodesAndInstallGenderSlotInPerson_Phase2_BuildJobSteps [
	"self assert: builderJobStep globalCollectionModuleClass identicalTo: LxxPrototypeSystem."
	"self assert: builderJobStep globalCollectionModuleClass identicalTo: LxxPrototypeSystem."
	"builderJobStep  globalCollectionModuleClass moduleName equals: 'Prototype System'."
	builder := self jobBuilder.
	builder buildJobSteps.
	self assert: builder jobSteps collection size equals: 8.
	self validateStep1.
	self validateStep2.
	self validateStep3.
	self validateStep4.
	self validateStep5.
	self validateStep6.
	self validateStep7.
	self validateStep8
]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testCreatingJobToAddGenderCodesAndInstallGenderSlotInPerson_Phase3_InstallCode [

	LxxPerson verifyClassHasNoDomainSlotNamed: 'gender'.
	LxxPrototypeSystem verifyClassHasNoDomainSlotNamed: 'genders'.

	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation.
	
	"The code has been created but the model is not initialized"
	
	self should: [ self currentSystem slotDefinitionNamed: 'genders' ] raise: LcsSlotDoesNotExistInSlotModelError.
	self assert: (self currentSystem respondsTo: #genders).
	
	self should: [ LxxPerson slotDefinitionNamed: 'gender' ] raise: LcsSlotDoesNotExistInSlotModelError.
	self assert: (LxxPerson canUnderstand: #gender).
]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testCreatingJobToAddGenderCodesAndInstallGenderSlotInPerson_Phase4_UpdateSlotModel [

	self removeAllArtifacts.
	
	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation.

	builder updateSlotModel.
	builder verifySlotModelUpdatesMadeByBuilder.
]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testCreatingJobToAddGenderCodesAndInstallGenderSlotInPerson_Phase5_Populate [
	| person |
	
	self removeAllArtifacts.
	
	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation.

	builder updateSlotModel.
	builder verifySlotModelUpdatesMadeByBuilder.
	
	self currentSystem currentUnitOfWork applyChanges.

	builder populateSlotModel.
	builder verifyPopulateSlotModel.

	person := 'LxxPerson' asClass new.
	
	self assert: person gender identicalTo: self currentSystem genders defaultInstance

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

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testSlotDefinitionDoesNotExist [

	self should: [ self currentSystem slotDefinitionNamed: 'fooBars' ] raise: LcsSlotDoesNotExistInSlotModelError
]

{ #category : #private }
LcsSingletonCodeClassesBuilderJobTest >> validateStep1 [
	| builderJobStep |
	builderJobStep := builder jobSteps jobStepAt: 1.
	self assert: builderJobStep class identicalTo: LcsCodeSuperClassBuilder.
	self assert: builderJobStep targetSuperclassName equals: 'LcsSingletonCode'.
	self assert: builderJobStep newClassName equals: 'LxxGender'.
	self assert: builderJobStep targetPackageName equals: builder targetPackageName.
	^ builderJobStep
]

{ #category : #private }
LcsSingletonCodeClassesBuilderJobTest >> validateStep2 [
	| builderJobStep |
	builderJobStep := builder jobSteps jobStepAt: 2.
	self assert: builderJobStep class identicalTo: LcsSingletonCodeClassBuilder.
	self assert: builderJobStep targetSuperclassName equals: 'LxxGender'.
	self assert: builderJobStep newClassName equals: 'LxxMale'.
	self assert: builderJobStep targetPackageName equals: builder targetPackageName.
	^ builderJobStep
]

{ #category : #private }
LcsSingletonCodeClassesBuilderJobTest >> validateStep3 [
	| builderJobStep |
	builderJobStep := builder jobSteps jobStepAt: 3.
	self assert: builderJobStep class identicalTo: LcsSingletonCodeClassBuilder.
	self assert: builderJobStep targetSuperclassName equals: 'LxxGender'.
	self assert: builderJobStep newClassName equals: 'LxxFemale'.
	self assert: builderJobStep targetPackageName equals: builder targetPackageName.
	^ builderJobStep
]

{ #category : #private }
LcsSingletonCodeClassesBuilderJobTest >> validateStep4 [
	| builderJobStep |
	builderJobStep := builder jobSteps jobStepAt: 4.
	self assert: builderJobStep class identicalTo: LcsSingletonCodeClassBuilder.
	self assert: builderJobStep targetSuperclassName equals: 'LxxGender'.
	self assert: builderJobStep newClassName equals: 'LxxUnknownGender'.
	self assert: builderJobStep targetPackageName equals: builder targetPackageName.
	^ builderJobStep
]

{ #category : #private }
LcsSingletonCodeClassesBuilderJobTest >> validateStep5 [
	| builderJobStep |
	builderJobStep := builder jobSteps jobStepAt: 5.
	self assert: builderJobStep class identicalTo: LcsCodeCollectionClassBuilder.
	self assert: builderJobStep targetSuperclassName equals: 'LcsCodes'.
	self assert: builderJobStep newClassName equals: 'LxxGenders'.
	self assert: builderJobStep targetPackageName equals: builder targetPackageName.
	^ builderJobStep
]

{ #category : #private }
LcsSingletonCodeClassesBuilderJobTest >> validateStep6 [
	| builderJobStep |
	builderJobStep := builder jobSteps jobStepAt: 6.
	self
		assert: builderJobStep class
		identicalTo: LcsGlobalCollectionReferenceSlotBuilder.
	self assert: builderJobStep targetClassName equals: 'LxxGender'.
	self assert: builderJobStep collectionSlotName equals: 'genders'.
	"self
		assert: builderJobStep collectionSlotModule class
		identicalTo: LxxPrototypeSystem."
	^ builderJobStep
]

{ #category : #private }
LcsSingletonCodeClassesBuilderJobTest >> validateStep7 [
	| builderJobStep |
	builderJobStep := builder jobSteps jobStepAt: 7.
	self assert: builderJobStep class identicalTo: LcsGlobalSlotDefinitionBuilder.
	self assert: builderJobStep slotTypeClassName equals: 'LxxGenders'.
	self assert: builderJobStep slotName equals: 'genders'.
	^ builderJobStep
]

{ #category : #private }
LcsSingletonCodeClassesBuilderJobTest >> validateStep8 [
	| builderJobStep |
	builderJobStep := builder jobSteps jobStepAt: 8.
	self assert: builderJobStep class identicalTo: LcsMemberOfSlotBuilder.
	self assert: builderJobStep target identicalTo: LxxPrototypePerson.
	self
		assert: builderJobStep collectionSlotModuleName
		equals: LxxPrototypeSystem moduleName.
	self assert: builderJobStep collectionSlotName equals: 'genders'.
	self assert: builderJobStep slotName equals: 'gender'.
	^ builderJobStep
]
