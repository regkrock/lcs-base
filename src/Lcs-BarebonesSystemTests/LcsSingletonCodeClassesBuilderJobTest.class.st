Class {
	#name : #LcsSingletonCodeClassesBuilderJobTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-BarebonesSystemTests'
}

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
	
	self assert: builder classPrefix equals: 'Lxx'.
	self assert: builder codePackageName equals: 'Lcs-BarebonesSystem'.
	self assert: builder completedRefactorings isEmpty.
	
	self assert: builder codeSuperclassBuilder superclassName equals: 'LcsCode'.
	self assert: builder codeSuperclassBuilder installClassName equals: 'LxxGender'.
	self assert: builder codeSuperclassBuilder codePackageName  equals: 'Lcs-BarebonesSystem'.

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

	self assert: builder globalCollectionSlotBuilder slotName equals: 'genders'.
	self assert: builder globalCollectionSlotBuilder moduleName equals: LxxBarebonesSystem moduleName.
	self assert: builder globalCollectionSlotBuilder targetClassName equals: 'LxxBarebonesSystem'.
	self assert: builder globalCollectionSlotBuilder target equals: LxxBarebonesSystem.
	self assert: builder globalCollectionSlotBuilder slotClassName equals: 'LxxGender'.

	self assert: builder memberOfSlotInDomainClassBuilder slotName equals: 'gender'.
	self assert: builder memberOfSlotInDomainClassBuilder collectionSlotName equals: 'genders'.
	self assert: builder memberOfSlotInDomainClassBuilder moduleName equals: LxxBarebonesSystem moduleName.
	
	"self assert: (builder memberOfSlotBuilder slotTypes includes: 'LxxGender' asClass)"

	
]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testCreationStringForCreatingLxxGenderSubclassOfLcsCodesClass [
	| builder |
	builder := LcsCodeSuperClassBuilder new.
	builder 
		classPrefix: 'Lxx';
		codePackageName: 'Lcs-BarebonesSystem';
		rootName: 'Gender'.
	self assert: builder codeClassDefintion equals: 'LcsCode subclass: #LxxGender
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-BarebonesSystem'' '
	
]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testCreationStringForCreatingLxxGendersSubclassOfLcsCodes [
	| builder |
	builder := LcsCodeCollectionClassBuilder  new.
	builder 
		classPrefix: 'Lxx';
		codePackageName: 'Lcs-BarebonesSystem';
		rootName: 'Genders'.
	self assert: builder codeClassDefintion equals: 'LcsCodes subclass: #LxxGenders
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-BarebonesSystem'' '
	
]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testCreationStringForCreatingLxxMaleSubclassOfLxxGender [
	| builder |
	builder := LcsCodeClassBuilder  new.
	builder 
		classPrefix: 'Lxx';
		codePackageName: 'Lcs-BarebonesSystem';
		superclassName: 'LxxGender';
		rootName: 'Male'.
	self assert: builder codeClassDefintion equals: 'LxxGender subclass: #LxxMale
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-BarebonesSystem'' '
	
]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testInstallingGenderCodesAndGenderSlotInPerson [
	| builder genderClass femaleClass maleClass unknownGenderClass gendersClass|
	
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
	"builder codeSuperclassBuilder install.
	(builder codeSubclassesBuilderJobSteps collection at: 1) install.
	(builder codeSubclassesBuilderJobSteps collection at: 2) install.
	(builder codeSubclassesBuilderJobSteps collection at: 3) install.
	builder codeCollectionClassBuilder install.
	builder globalCollectionSlotBuilder install.
	builder memberOfSlotInDomainClassBuilder install."
		
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
