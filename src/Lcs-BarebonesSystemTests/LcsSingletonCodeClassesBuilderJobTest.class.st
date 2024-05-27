Class {
	#name : #LcsSingletonCodeClassesBuilderJobTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-BarebonesSystemTests'
}

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> jobBuilder [
	^ LcsSingletonCodeClassesBuilderJob new
		classPrefix: 'Lxx';
		installNewClassesInPackageNamed: 'Lcs-BarebonesSystem';
		codeRootName: 'Gender';
		addCodeSubclassWithRootNamed: 'Male';
		addCodeSubclassWithRootNamed: 'Female';
		addCodeSubclassWithRootNamed: 'UnknownGender'
			with: [ :classBuilder | classBuilder beDefaultInstance ];
		moduleClass: LxxBarebonesSystem;
		installMemberSlotInDomainClass: LxxBarebonesPerson;
		yourself
]

{ #category : #running }
LcsSingletonCodeClassesBuilderJobTest >> removeAllArtifacts [
	LxxBarebonesSystem removeDomainSlotNamed: 'genders'.
	LxxBarebonesPerson removeDomainSlotNamed: 'gender'.
	self
		removeClassesNamed: #('LxxUnknownGender' 'LxxFemale' 'LxxMale' 'LxxGender' 'LxxGenders')
]

{ #category : #running }
LcsSingletonCodeClassesBuilderJobTest >> setupSunitSystem [
	LxxBarebonesSystem new
]

{ #category : #running }
LcsSingletonCodeClassesBuilderJobTest >> tearDown [
	self removeAllArtifacts.
	super tearDown
]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testCreatingJobToAddGenderCodesAndInstallGenderSlotInPerson_Phase1_BuildJob [
	| builder codeSubclassBuilder |
	
	builder := self jobBuilder.

	self assert: builder classPrefix equals: 'Lxx'.
	self assert: builder codePackageName equals: 'Lcs-BarebonesSystem'.
	self assert: builder completedRefactorings isEmpty.
	self assert: builder codeClassRootName equals: 'Gender'.
	self assert: builder jobSteps hasNoJobSteps.

	self assert: builder codeSlotName equals: 'gender'.
	self assert: builder codeCollectionSlotName equals: 'genders'.
	self assert: builder codeClassName equals: 'LxxGender'.
	self assert: builder codeCollectionClassName equals: 'LxxGenders'.
	self assert: builder moduleClass equals: LxxBarebonesSystem.

	self assert: builder codeSubclassBuilders size equals: 3.
	
	codeSubclassBuilder := builder codeSubclassBuilders at: 1.
	self assert: codeSubclassBuilder superclassName equals: 'LxxGender'.
	self assert: codeSubclassBuilder newClassName equals: 'LxxMale'.
	self assert: codeSubclassBuilder codePackageName equals: 'Lcs-BarebonesSystem'.
	self assert: codeSubclassBuilder shortName equals: 'Male'. 
	self assert: codeSubclassBuilder codeDescription equals: 'Male'. 
	self assert: codeSubclassBuilder codeName equals: 'male'. 
	self deny: codeSubclassBuilder isDefaultInstance.

	codeSubclassBuilder := builder codeSubclassBuilders at: 2.
	self assert: codeSubclassBuilder superclassName equals: 'LxxGender'.
	self assert: codeSubclassBuilder newClassName equals: 'LxxFemale'.
	self assert: codeSubclassBuilder codePackageName equals: 'Lcs-BarebonesSystem'.
	self assert: codeSubclassBuilder shortName equals: 'Female'. 
	self assert: codeSubclassBuilder codeDescription equals: 'Female'. 
	self assert: codeSubclassBuilder codeName equals: 'female'. 
	self deny: codeSubclassBuilder isDefaultInstance.

	codeSubclassBuilder := builder codeSubclassBuilders at: 3.
	self assert: codeSubclassBuilder superclassName equals: 'LxxGender'.
	self assert: codeSubclassBuilder newClassName equals: 'LxxUnknownGender'.
	self assert: codeSubclassBuilder codePackageName equals: 'Lcs-BarebonesSystem'.
	self assert: codeSubclassBuilder shortName equals: 'UnknownGender'. 
	self assert: codeSubclassBuilder codeDescription equals: 'UnknownGender'. 
	self assert: codeSubclassBuilder codeName equals: 'unknownGender'. 
	self assert: codeSubclassBuilder isDefaultInstance.

	"self assert: builder codeCollectionClassBuilder superclassName = 'LcsCodes'.
	self assert: builder codeCollectionClassBuilder newClassName equals: 'LxxGenders'.
	self assert: builder codeCollectionClassBuilder codePackageName equals: 'Lcs-BarebonesSystem'.

	self assert: builder codeSuperClassParentSlotDefinitionStep slotName equals: 'parent'.
	self assert: builder codeSuperClassParentSlotDefinitionStep moduleName equals: LxxBarebonesSystem moduleName.
	self assert: builder codeSuperClassParentSlotDefinitionStep collectionSlotName equals: 'genders'.

	self assert: builder globalCollectionSlotBuilder slotName equals: 'genders'.
	self assert: builder globalCollectionSlotBuilder moduleName equals: LxxBarebonesSystem moduleName.
	self assert: builder globalCollectionSlotBuilder targetClassName equals: 'LxxBarebonesSystem'.
	self assert: builder globalCollectionSlotBuilder target equals: LxxBarebonesSystem.
	self assert: builder globalCollectionSlotBuilder slotClassName equals: 'LxxGenders'.

	self assert: builder memberOfSlotInDomainClassBuilder slotName equals: 'gender'.
	self assert: builder memberOfSlotInDomainClassBuilder collectionSlotName equals: 'genders'.
	self assert: builder memberOfSlotInDomainClassBuilder moduleName equals: LxxBarebonesSystem moduleName	"
	
	"self assert: (builder memberOfSlotBuilder slotTypes includes: 'LxxGender' asClass)"
]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testCreatingJobToAddGenderCodesAndInstallGenderSlotInPerson_Phase2_BuildJobSteps [
	| builder builderJobStep |
	
	builder := self jobBuilder.
	builder buildJobSteps.

	self assert: builder jobSteps collection size equals: 8.
	
	builderJobStep := builder jobSteps jobStepAt: 1.
	self assert: builderJobStep class identicalTo: LcsCodeSuperClassBuilder.
	self assert: builderJobStep superclassName equals: 'LcsCode'.
	self assert: builderJobStep newClassName equals: 'LxxGender'.
	self assert: builderJobStep codePackageName equals: builder codePackageName.
	
	builderJobStep := builder jobSteps jobStepAt: 2.
	self assert: builderJobStep class identicalTo: LcsSingletonCodeClassBuilder.
	self assert: builderJobStep superclassName equals: 'LxxGender'.
	self assert: builderJobStep newClassName equals: 'LxxMale'.
	self assert: builderJobStep codePackageName equals: builder codePackageName.

	builderJobStep := builder jobSteps jobStepAt: 3.
	self assert: builderJobStep class identicalTo: LcsSingletonCodeClassBuilder.
	self assert: builderJobStep superclassName equals: 'LxxGender'.
	self assert: builderJobStep newClassName equals: 'LxxFemale'.
	self assert: builderJobStep codePackageName equals: builder codePackageName.
	
	builderJobStep := builder jobSteps jobStepAt: 4.
	self assert: builderJobStep class identicalTo: LcsSingletonCodeClassBuilder.
	self assert: builderJobStep superclassName equals: 'LxxGender'.
	self assert: builderJobStep newClassName equals: 'LxxUnknownGender'.
	self assert: builderJobStep codePackageName equals: builder codePackageName.

	builderJobStep := builder jobSteps jobStepAt: 5.
	self assert: builderJobStep class identicalTo: LcsCodeCollectionClassBuilder.
	self assert: builderJobStep superclassName equals: 'LcsCodes'.
	self assert: builderJobStep newClassName equals: 'LxxGenders'.
	self assert: builderJobStep codePackageName equals: builder codePackageName.
		
	builderJobStep := builder jobSteps jobStepAt: 6.
	self assert: builderJobStep class identicalTo: LcsGlobalCollectionReferenceSlotBuilder.
	self assert: builderJobStep targetClassName equals: 'LxxGender'.
	self assert: builderJobStep collectionSlotName equals: 'genders'.
	self assert: builderJobStep collectionSlotModule class identicalTo: LxxBarebonesSystem.
	
	builderJobStep := builder jobSteps jobStepAt: 7.
	self assert: builderJobStep class identicalTo: LcsGlobalSlotDefinitionBuilder.
	self assert: builderJobStep moduleClass identicalTo: LxxBarebonesSystem.
	self assert: builderJobStep slotClassName equals: 'LxxGenders'.
	self assert: builderJobStep slotName equals: 'genders'.


	builderJobStep := builder jobSteps jobStepAt: 8.
	self assert: builderJobStep class identicalTo: LcsMemberOfSlotBuilder.
	self assert: builderJobStep target identicalTo: LxxBarebonesPerson.
	self assert: builderJobStep moduleClass identicalTo: LxxBarebonesSystem.
	self assert: builderJobStep collectionSlotName equals: 'genders'.
	self assert: builderJobStep slotName equals: 'gender'.

]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testCreatingJobToAddGenderCodesAndInstallGenderSlotInPerson_Phase3_InstallClassesAndSlots [
	| builder |

	LxxBarebonesPerson verifyClassHasNoDomainSlotNamed: 'gender'.
	LxxBarebonesSystem verifyClassHasNoDomainSlotNamed: 'genders'.

	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation.
	
	"The code has been created but the model is not initialized"
	
	self should: [ self currentSystem slotDefinitionNamed: 'genders' ] raise: LcsSlotDoesNotExistInSlotModelError.
	self assert: (self currentSystem respondsTo: #genders).
	
	self should: [ LxxBarebonesPerson slotDefinitionNamed: 'gender' ] raise: LcsSlotDoesNotExistInSlotModelError.
	self assert: (LxxBarebonesPerson canUnderstand: #gender).


]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testCreatingJobToAddGenderCodesAndInstallGenderSlotInPerson_Phase4_PopulateGendersCollection [
	| builder person |
	
	self removeAllArtifacts.
	LxxBarebonesPerson verifyClassHasNoDomainSlotNamed: 'gender'.
	LxxBarebonesSystem verifyClassHasNoDomainSlotNamed: 'genders'.
	
	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation.

	builder updateSlotModel.
	builder verifySlotModelUpdates.
	
	builder populateSlotModel.
	
	self currentSystem currentUnitOfWork applyChanges.

	self currentSystem initializeSlotNamed: 'genders'.
	self currentSystem currentUnitOfWork applyChanges.
	self assert: self currentSystem genders class name equals: 'LxxGenders'.
	self assert: self currentSystem genders parent identicalTo: self currentSystem.
	
	self assert: self currentSystem genders hasNoElements.
	'LxxMale' asClass new.
	'LxxFemale' asClass new.
	'LxxUnknownGender' asClass new.

	self currentSystem currentUnitOfWork applyChanges.

	self assert: self currentSystem genders hasElements.

	self assert: (self currentSystem genders findWithKey: 'male') class equals: 'LxxMale' asClass.
	self assert: (self currentSystem genders findWithKey: 'female') class equals: 'LxxFemale' asClass.
	self assert: (self currentSystem genders findWithKey: 'unknownGender') class equals: 'LxxUnknownGender' asClass.


	person := 'LxxBarebonesPerson' asClass new.
	
	self assert: person gender identicalTo: self currentSystem genders defaultInstance

]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testSlotDefinitionDoesNotExist [

	| returnedSignal |
	self should: [ self currentSystem slotDefinitionNamed: 'fooBars' ] raise: LcsSlotDoesNotExistInSlotModelError.
	
	returnedSignal := [ self currentSystem slotDefinitionNamed: 'fooBars' ]
		on: LcsSlotDoesNotExistInSlotModelError
		do: [:signal | signal ].

	self assert: returnedSignal messageText equals: 'Slot ''fooBars'' not defined in slot model'.
]
