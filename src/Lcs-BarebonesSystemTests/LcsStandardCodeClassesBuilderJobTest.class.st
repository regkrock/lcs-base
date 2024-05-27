Class {
	#name : #LcsStandardCodeClassesBuilderJobTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-BarebonesSystemTests'
}

{ #category : #tests }
LcsStandardCodeClassesBuilderJobTest >> jobBuilder [
	^ LcsStandardCodeClassesBuilderJob new
		classPrefix: 'Lxx';
		installNewClassesInPackageNamed: 'Lcs-BarebonesSystem';
		codeRootName: 'Talent';
		createCodeInstances: #('Guitar' 'Saxaphone');
		moduleClass: LxxBarebonesSystem;
		installMemberSlotInDomainClass: LxxBarebonesPerson;
		yourself
]

{ #category : #running }
LcsStandardCodeClassesBuilderJobTest >> removeAllArtifacts [
	LxxBarebonesSystem removeDomainSlotNamed: 'talents'.
	LxxBarebonesPerson removeDomainSlotNamed: 'talent'.
	self
		removeClassesNamed: #('LxxTalent' 'LxxTalents')
]

{ #category : #running }
LcsStandardCodeClassesBuilderJobTest >> setupSunitSystem [
	LxxBarebonesSystem new
]

{ #category : #running }
LcsStandardCodeClassesBuilderJobTest >> tearDown [
	self removeAllArtifacts.
	super tearDown
]

{ #category : #tests }
LcsStandardCodeClassesBuilderJobTest >> testCreatingJobToAddTalentCodeAndInstallTalentSlotInPerson_Phase1_BuildJob [
	| builder |
	builder := self jobBuilder.

	self assert: builder classPrefix equals: 'Lxx'.
	self assert: builder codePackageName equals: 'Lcs-BarebonesSystem'.
	self assert: builder completedRefactorings isEmpty.
	self assert: builder codeClassRootName equals: 'Talent'.
	self assert: builder jobSteps hasNoJobSteps.

	self assert: builder codeSlotName equals: 'talent'.
	self assert: builder codeCollectionSlotName equals: 'talents'.
	self assert: builder codeClassName equals: 'LxxTalent'.
	self assert: builder codeCollectionClassName equals: 'LxxTalents'.
	self assert: builder moduleClass equals: LxxBarebonesSystem.

]

{ #category : #tests }
LcsStandardCodeClassesBuilderJobTest >> testCreatingJobToAddTalentCodeAndInstallTalentSlotInPerson_Phase2_BuildJobSteps [
	| builder builderJobStep |
	builder := self jobBuilder.
	builder buildJobSteps.

	self assert: builder jobSteps collection size equals: 5.

	builderJobStep := builder jobSteps jobStepAt: 1.
	self assert: builderJobStep class identicalTo: LcsCodeSuperClassBuilder.
	self assert: builderJobStep superclassName equals: 'LcsCode'.
	self assert: builderJobStep newClassName equals: 'LxxTalent'.
	self assert: builderJobStep codePackageName equals: builder codePackageName.

	builderJobStep := builder jobSteps jobStepAt: 2.
	self assert: builderJobStep class identicalTo: LcsCodeCollectionClassBuilder.
	self assert: builderJobStep superclassName equals: 'LcsCodes'.
	self assert: builderJobStep newClassName equals: 'LxxTalents'.
	self assert: builderJobStep codePackageName equals: builder codePackageName.
		
	builderJobStep := builder jobSteps jobStepAt: 3.
	self assert: builderJobStep class identicalTo: LcsGlobalCollectionReferenceSlotBuilder.
	self assert: builderJobStep targetClassName equals: 'LxxTalent'.
	self assert: builderJobStep collectionSlotName equals: 'talents'.
	self assert: builderJobStep collectionSlotModule class identicalTo: LxxBarebonesSystem.
	
	builderJobStep := builder jobSteps jobStepAt: 4.
	self assert: builderJobStep class identicalTo: LcsGlobalSlotDefinitionBuilder.
	self assert: builderJobStep moduleClass identicalTo: LxxBarebonesSystem.
	self assert: builderJobStep slotClassName equals: 'LxxTalents'.
	self assert: builderJobStep slotName equals: 'talents'.


	builderJobStep := builder jobSteps jobStepAt: 5.
	self assert: builderJobStep class identicalTo: LcsMemberOfSlotBuilder.
	self assert: builderJobStep target identicalTo: LxxBarebonesPerson.
	self assert: builderJobStep moduleClass identicalTo: LxxBarebonesSystem.
	self assert: builderJobStep collectionSlotName equals: 'talents'.
	self assert: builderJobStep slotName equals: 'talent'.
]

{ #category : #tests }
LcsStandardCodeClassesBuilderJobTest >> testCreatingJobToAddTalentCodeAndInstallTalentSlotInPerson_Phase3_InstallClassesAndSlots [
	| builder |
	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation
]
