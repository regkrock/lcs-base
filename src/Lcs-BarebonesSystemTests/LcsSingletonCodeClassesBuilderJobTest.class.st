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
			codeSuperclassRootName: 'Gender';
			installCodesInPackageNamed: 'Lcs-BarebonesSystem';
			addCodeClassBuilder: (LcsCodeClassBuilder newRootName: 'Male');
			addCodeClassBuilder: (LcsCodeClassBuilder newRootName: 'Female');
			addCodeClassBuilder: ((LcsCodeClassBuilder newRootName: 'UnknownGender')
									beDefaultInstance;
									yourself);
			installGlobalCollection: 'Genders' inSlotNamed: 'genders' inModule: LxxBarebonesSystem ;
			installSlotIn: LxxBarebonesPerson;
			yourself.
	
	self assert: builder classPrefix equals: 'Lxx'.
	self assert: builder codePackageName equals: 'Lcs-BarebonesSystem'.
	self assert: builder completedRefactorings isEmpty.
	
	self assert: builder codeSuperclassBuilder superclassName equals: 'LcsCode'.
	self assert: builder codeSuperclassBuilder installClassName equals: 'LxxGender'.
	self assert: builder codeSuperclassBuilder codePackageName  equals: 'Lcs-BarebonesSystem'.

	self assert: builder codeClassBuilders size equals: 3.
	self assert: (builder codeClassBuilders at: 1) superclassName equals: 'LxxGender'.
	self assert: (builder codeClassBuilders at: 1) installClassName equals: 'LxxMale'.
	self assert: (builder codeClassBuilders at: 1) codePackageName equals: 'Lcs-BarebonesSystem'.
	self deny: (builder codeClassBuilders at: 1) isDefaultInstance.
	
	self assert: (builder codeClassBuilders at: 2) superclassName equals: 'LxxGender'.
	self assert: (builder codeClassBuilders at: 2) installClassName equals: 'LxxFemale'.
	self assert: (builder codeClassBuilders at: 2) codePackageName equals: 'Lcs-BarebonesSystem'.
	self deny: (builder codeClassBuilders at: 2) isDefaultInstance.
	
	self assert: (builder codeClassBuilders at: 3) superclassName equals: 'LxxGender'.
	self assert: (builder codeClassBuilders at: 3) installClassName equals: 'LxxUnknownGender'.
	self assert: (builder codeClassBuilders at: 3) codePackageName equals: 'Lcs-BarebonesSystem'.
	self assert: (builder codeClassBuilders at: 3) isDefaultInstance.
	
	self assert: builder codeCollectionClassBuilder superclassName = 'LcsCodes'.
	self assert: builder codeCollectionClassBuilder installClassName equals: 'LxxGenders'.
	self assert: builder codeCollectionClassBuilder codePackageName equals: 'Lcs-BarebonesSystem'.

	self assert: builder memberOfSlotBuilder slotName equals: 'gender'.
	self assert: builder memberOfSlotBuilder collectionSlotName equals: 'genders'.
	self assert: builder memberOfSlotBuilder moduleName equals: LxxBarebonesSystem moduleName.
	"self assert: (builder memberOfSlotBuilder slotTypes includes: 'LxxGender' asClass)"

	
]

{ #category : #tests }
LcsSingletonCodeClassesBuilderJobTest >> testInstallingGenderCodesAndGenderSlotInPerson [
	| builder genderClass femaleClass maleClass unknownGenderClass gendersClass|
	
	LxxBarebonesPerson verifyClassHasNoDomainSlotNamed: 'gender'.
	LxxBarebonesSystem verifyClassHasNoDomainSlotNamed: 'genders'.
	
	builder := 
		LcsSingletonCodeClassesBuilderJob new
			classPrefix: 'Lxx';
			codeSuperclassRootName: 'Gender';
			installCodesInPackageNamed: 'Lcs-BarebonesSystem';
			addCodeClassBuilder: (LcsCodeClassBuilder newRootName: 'Male');
			addCodeClassBuilder: (LcsCodeClassBuilder newRootName: 'Female');
			addCodeClassBuilder: ((LcsCodeClassBuilder newRootName: 'UnknownGender')
									beDefaultInstance;
									yourself);
			installGlobalCollection: 'Genders' inSlotNamed: 'genders' inModule: LxxBarebonesSystem ;
			installSlotIn: LxxBarebonesPerson;
			yourself.

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
