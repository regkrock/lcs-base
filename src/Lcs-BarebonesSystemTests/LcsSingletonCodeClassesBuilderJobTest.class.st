Class {
	#name : #LcsSingletonCodeClassesBuilderJobTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-BarebonesSystemTests'
}

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> genderBuilder [
	^ LcsSingletonCodeClassesBuilderJob new
		classPrefix: 'Lxx';
		installNewClassesInPackageNamed: 'Lcs-BarebonesSystem';
		codeRootName: 'Gender';
		addCodeSubclassWithRootNamed: 'Male';
		addCodeSubclassWithRootNamed: 'Female';
		addCodeSubclassWithRootNamed: 'UnknownGender'
			with: [ :classBuilder | classBuilder beDefaultInstance ];
		installGlobalCollectionSlotInModule: LxxBarebonesSystem;
		installSlotInDomainClass: LxxBarebonesPerson;
		yourself
]

{ #category : #running }
LcsSingletonCodeClassesBuilderJobTest >> setupSunitSystem [
	LxxBarebonesSystem new
]

{ #category : #running }
LcsSingletonCodeClassesBuilderJobTest >> tearDown [
	LxxBarebonesSystem removeDomainSlotNamed: 'genders'.
	LxxBarebonesPerson removeDomainSlotNamed: 'gender'.
	self removeClassesNamed: #('LxxUnknownGender' 'LxxFemale' 'LxxMale' 'LxxGender' 'LxxGenders').
	super tearDown
]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testCreatingJobToAddGenderCodesAndInstallGenderSlotInPerson [
	| builder |
	
	builder := self genderBuilder.

	self assert: builder classPrefix equals: 'Lxx'.
	self assert: builder codePackageName equals: 'Lcs-BarebonesSystem'.
	self assert: builder completedRefactorings isEmpty.

	self assert: builder codeSuperclassBuilder superclassName equals: 'LcsCode'.
	self assert: builder codeSuperclassBuilder installClassName equals: 'LxxGender'.
	self assert: builder codeSuperclassBuilder codePackageName equals: 'Lcs-BarebonesSystem'.

	self assert: builder codeSubclassesBuilderJobSteps collection size equals: 3.
	self assert: (builder codeSubclassesBuilderJobSteps collection at: 1) superclassName equals: 'LxxGender'.
	self assert: (builder codeSubclassesBuilderJobSteps collection at: 1) installClassName equals: 'LxxMale'.
	self assert: (builder codeSubclassesBuilderJobSteps collection at: 1) codePackageName equals: 'Lcs-BarebonesSystem'.
	self deny: (builder codeSubclassesBuilderJobSteps collection at: 1) isDefaultInstance.

	self assert: (builder codeSubclassesBuilderJobSteps collection at: 2) superclassName equals: 'LxxGender'.
	self assert: (builder codeSubclassesBuilderJobSteps collection at: 2) installClassName equals: 'LxxFemale'.
	self assert: (builder codeSubclassesBuilderJobSteps collection at: 2) codePackageName equals: 'Lcs-BarebonesSystem'.
	self deny: (builder codeSubclassesBuilderJobSteps collection at: 2) isDefaultInstance.

	self assert: (builder codeSubclassesBuilderJobSteps collection at: 3) superclassName equals: 'LxxGender'.
	self assert: (builder codeSubclassesBuilderJobSteps collection at: 3) installClassName equals: 'LxxUnknownGender'.
	self assert: (builder codeSubclassesBuilderJobSteps collection at: 3) codePackageName equals: 'Lcs-BarebonesSystem'.
	self assert: (builder codeSubclassesBuilderJobSteps collection at: 3) isDefaultInstance.

	self assert: builder codeCollectionClassBuilder superclassName = 'LcsCodes'.
	self assert: builder codeCollectionClassBuilder installClassName equals: 'LxxGenders'.
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
	self assert: builder memberOfSlotInDomainClassBuilder moduleName equals: LxxBarebonesSystem moduleName	
	
	"self assert: (builder memberOfSlotBuilder slotTypes includes: 'LxxGender' asClass)"
]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testInstallingGenderCodesAndGenderSlotInPerson [
	| builder genderClass femaleClass maleClass unknownGenderClass gendersClass |
	LxxBarebonesPerson verifyClassHasNoDomainSlotNamed: 'gender'.
	LxxBarebonesSystem verifyClassHasNoDomainSlotNamed: 'genders'.

	builder := self genderBuilder.
	builder install.

	genderClass := self classNamed: 'LxxGender'.
	femaleClass := self classNamed: 'LxxFemale'.
	maleClass := self classNamed: 'LxxMale'.
	unknownGenderClass := self classNamed: 'LxxUnknownGender'.
	gendersClass := self classNamed: 'LxxGenders'.

	self assert: genderClass notNil.
	self assert: maleClass notNil.
	self assert: femaleClass notNil.
	self assert: unknownGenderClass notNil.

	self assert: genderClass superclass equals: LcsCode.
	self assert: maleClass superclass equals: genderClass.
	self assert: femaleClass superclass equals: genderClass.
	self assert: unknownGenderClass superclass equals: genderClass.

	self assert: gendersClass superclass equals: LcsCodes.

	LxxBarebonesPerson verifyClassHasDomainSlotNamed: 'gender'.
	LxxBarebonesSystem verifyClassHasDomainSlotNamed: 'genders'
]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testLoadCollectionClass [
	| builder person |
	
	LxxBarebonesPerson verifyClassHasNoDomainSlotNamed: 'gender'.
	LxxBarebonesSystem verifyClassHasNoDomainSlotNamed: 'genders'.
	
	builder := 
		LcsSingletonCodeClassesBuilderJob new
			classPrefix: 'Lxx';
			installNewClassesInPackageNamed: 'Lcs-BarebonesSystem';
			codeRootName: 'Gender';
			addCodeSubclassWithRootNamed: 'Male';
			addCodeSubclassWithRootNamed: 'Female';
			addCodeSubclassWithRootNamed: 'UnknownGender' with: [ :classBuilder | classBuilder beDefaultInstance ];
			installGlobalCollectionSlotInModule: LxxBarebonesSystem ;
			installSlotInDomainClass: LxxBarebonesPerson;
			yourself.

	builder install.

	self deny: (self currentSystem hasSlotModelFor: 'LxxGender' asClass).
	self deny: (self currentSystem hasSlotModelFor: 'LxxMale' asClass).
	self deny: (self currentSystem hasSlotModelFor: 'LxxFemale' asClass).
	self deny: (self currentSystem hasSlotModelFor: 'LxxUnknownGender' asClass).
	self deny: (self currentSystem hasSlotModelFor: 'LxxGenders' asClass).
	self should: [self currentSystem slotDefinitionNamed: #genders] raise: LcsError.
	self should: [LxxBarebonesPerson slotDefinitionNamed: #gender] raise: LcsError.
	
	builder updateSlotModel.
	self currentSystem currentUnitOfWork applyChanges.

	self assert: (self currentSystem hasSlotModelFor: 'LxxGender' asClass).
	self assert: (self currentSystem hasSlotModelFor: 'LxxMale' asClass).
	self assert: (self currentSystem hasSlotModelFor: 'LxxFemale' asClass).
	self assert: (self currentSystem hasSlotModelFor: 'LxxUnknownGender' asClass).
	self assert: (self currentSystem hasSlotModelFor: 'LxxGenders' asClass).
	self shouldnt: [self currentSystem slotDefinitionNamed: #genders] raise: LcsError.
	self shouldnt: [LxxBarebonesPerson slotDefinitionNamed: #gender] raise: LcsError.
	self assert: (self currentSystem genders findWithKey: 'male') class equals: 'LxxMale' asClass.
	self assert: (self currentSystem genders findWithKey: 'female') class equals: 'LxxFemale' asClass.
	self assert: (self currentSystem genders findWithKey: 'unknownGender') class equals: 'LxxUnknownGender' asClass.

	person := 'LxxBarebonesPerson' asClass new.
	
	self assert: person gender identicalTo: self currentSystem genders defaultInstance

]
