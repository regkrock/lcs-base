Class {
	#name : #LcsStandardCodeWithUnknownClassClassesBuilderJobTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-BarebonesSystemTests'
}

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> jobBuilder [
	^ LcsStandardCodeWithUnknownClassClassesBuilderJob new
		classPrefix: 'Lxx';
		installNewClassesInPackageNamed: 'Lcs-BarebonesSystem';
		codeRootName: 'Title';
		createCodeInstances: #('Mr' 'Ms');
		moduleClass: LxxBarebonesSystem;
		installMemberSlotInDomainClass: LxxBarebonesPerson;
		yourself
]

{ #category : #running }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> removeAllArtifacts [
	LxxBarebonesSystem removeDomainSlotNamed: 'titles'.
	LxxBarebonesPerson removeDomainSlotNamed: 'title'.
	self
		removeClassesNamed: #('LxxUnknownTitle' 'LxxTitle' 'LxxTitles')
]

{ #category : #running }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> setupSunitSystem [
	LxxBarebonesSystem new
]

{ #category : #running }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> tearDown [
	self removeAllArtifacts.
	super tearDown
]

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> testCreatingJobToAddTitleCodesAndInstallTitleSlotInPerson_Phase1_BuildJob [
	| builder |
	builder := self jobBuilder.

	self assert: builder classPrefix equals: 'Lxx'.
	self assert: builder codePackageName equals: 'Lcs-BarebonesSystem'.
	self assert: builder completedRefactorings isEmpty.
	self assert: builder codeClassRootName equals: 'Title'.
	self assert: builder jobSteps hasNoJobSteps.

	self assert: builder codeSlotName equals: 'title'.
	self assert: builder codeCollectionSlotName equals: 'titles'.
	self assert: builder codeClassName equals: 'LxxTitle'.
	self assert: builder codeCollectionClassName equals: 'LxxTitles'.
	self assert: builder moduleClass equals: LxxBarebonesSystem.
	self assert:builder undefinedClassName equals: 'LxxUnknownTitle'.
]

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> testCreatingJobToAddTitleCodesAndInstallTitleSlotInPerson_Phase2_BuildJobStep [
	| builder builderJobStep |
	builder := self jobBuilder.
	builder buildJobSteps.

	self assert: builder jobSteps collection size equals: 6.
	
	builderJobStep := builder jobSteps jobStepAt: 1.
	self assert: builderJobStep class identicalTo: LcsCodeSuperClassBuilder.
	self assert: builderJobStep superclassName equals: 'LcsCode'.
	self assert: builderJobStep newClassName equals: 'LxxTitle'.
	self assert: builderJobStep codePackageName equals: builder codePackageName.
	
	builderJobStep := builder jobSteps jobStepAt: 2.
	self assert: builderJobStep class identicalTo: LcsUnknownCodeClassBuilder.
	self assert: builderJobStep superclassName equals: 'LxxTitle'.
	self assert: builderJobStep newClassName equals: 'LxxUnknownTitle'.
	self assert: builderJobStep codePackageName equals: builder codePackageName.

	builderJobStep := builder jobSteps jobStepAt: 3.
	self assert: builderJobStep class identicalTo: LcsCodeCollectionClassBuilder.
	self assert: builderJobStep superclassName equals: 'LcsCodes'.
	self assert: builderJobStep newClassName equals: 'LxxTitles'.
	self assert: builderJobStep codePackageName equals: builder codePackageName.
		
	builderJobStep := builder jobSteps jobStepAt: 4.
	self assert: builderJobStep class identicalTo: LcsGlobalCollectionReferenceSlotBuilder.
	self assert: builderJobStep targetClassName equals: 'LxxTitle'.
	self assert: builderJobStep collectionSlotName equals: 'titles'.
	self assert: builderJobStep collectionSlotModule class identicalTo: LxxBarebonesSystem.
	
	builderJobStep := builder jobSteps jobStepAt: 5.
	self assert: builderJobStep class identicalTo: LcsGlobalSlotDefinitionBuilder.
	self assert: builderJobStep moduleClass identicalTo: LxxBarebonesSystem.
	self assert: builderJobStep slotClassName equals: 'LxxTitles'.
	self assert: builderJobStep slotName equals: 'titles'.


	builderJobStep := builder jobSteps jobStepAt: 6.
	self assert: builderJobStep class identicalTo: LcsMemberOfSlotBuilder.
	self assert: builderJobStep target identicalTo: LxxBarebonesPerson.
	self assert: builderJobStep moduleClass identicalTo: LxxBarebonesSystem.
	self assert: builderJobStep collectionSlotName equals: 'titles'.
	self assert: builderJobStep slotName equals: 'title'.

]

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> testCreatingJobToAddTitleCodesAndInstallTitleSlotInPerson_Phase3_InstallClassesAndSlots [
	| builder |
	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation

]
