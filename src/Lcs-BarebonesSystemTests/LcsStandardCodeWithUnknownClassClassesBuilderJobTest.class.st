Class {
	#name : #LcsStandardCodeWithUnknownClassClassesBuilderJobTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-BarebonesSystemTests'
}

{ #category : #running }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> setupSunitSystem [
	LxxBarebonesSystem new
]

{ #category : #running }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> tearDown [
	LxxBarebonesSystem removeDomainSlotNamed: 'titles'.
	LxxBarebonesPerson removeDomainSlotNamed: 'title'.
	self removeClassesNamed: #('LxxTitles' 'LxxUnknownTitle' 'LxxTitle' 'LxxBaseTitle' ).
	super tearDown
]

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> testCreatingJobToAddTitleCodesAndInstallTitleSlotInPerson [
	| builder |
	builder := 
		LcsStandardCodeWithUnknownClassClassesBuilderJob new
			classPrefix: 'Lxx';
			codeSuperclassRootName: 'Title';
			installCodesInPackageNamed: 'Lcs-BarebonesSystem';
			createCodeInstances: #('Mr' 'Ms');
			installGlobalCollection: 'Titles' inSlotNamed: 'titles' inModule: LxxBarebonesSystem ;
			installSlotIn: LxxBarebonesPerson;
			yourself.
	
	self assert: builder classPrefix equals: 'Lxx'.
	self assert: builder codePackageName equals: 'Lcs-BarebonesSystem'.
	self assert: builder completedRefactorings isEmpty.
	
	self assert: builder codeSuperclassBuilder superclassName equals: 'LcsCode'.
	self assert: builder codeSuperclassBuilder installClassName equals: 'LxxBaseTitle'.
	self assert: builder codeSuperclassBuilder codePackageName  equals: 'Lcs-BarebonesSystem'.

	self assert: builder codeClassBuilders size equals: 2.
	self assert: (builder codeClassBuilders at: 1) superclassName equals: 'LxxBaseTitle'.
	self assert: (builder codeClassBuilders at: 1) installClassName equals: 'LxxTitle'.
	self assert: (builder codeClassBuilders at: 1) codePackageName equals: 'Lcs-BarebonesSystem'.
	self deny: (builder codeClassBuilders at: 1) isDefaultInstance.
	
	self assert: (builder codeClassBuilders at: 2) superclassName equals: 'LxxBaseTitle'.
	self assert: (builder codeClassBuilders at: 2) installClassName equals: 'LxxUnknownTitle'.
	self assert: (builder codeClassBuilders at: 2) codePackageName equals: 'Lcs-BarebonesSystem'.
	self assert: (builder codeClassBuilders at: 2) isDefaultInstance.
	
	self assert: builder codeCollectionClassBuilder superclassName = 'LcsCodes'.
	self assert: builder codeCollectionClassBuilder installClassName equals: 'LxxTitles'.
	self assert: builder codeCollectionClassBuilder codePackageName equals: 'Lcs-BarebonesSystem'.

	self assert: builder memberOfSlotBuilder slotName equals: 'title'.
	self assert: builder memberOfSlotBuilder collectionSlotName equals: 'titles'.
	self assert: builder memberOfSlotBuilder moduleName equals: LxxBarebonesSystem moduleName.

]

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> testInstallingTitleCodesAndTitleSlotInPerson [
	| builder titleBaseClass titleClass unknownTitleClass titlesClass |
	
	LxxBarebonesPerson verifyClassHasNoDomainSlotNamed: 'title'.
	LxxBarebonesSystem verifyClassHasNoDomainSlotNamed: 'titles'.
	
	builder := 
		LcsStandardCodeWithUnknownClassClassesBuilderJob new
			classPrefix: 'Lxx';
			codeSuperclassRootName: 'Title';
			installCodesInPackageNamed: 'Lcs-BarebonesSystem';
			createCodeInstances: #('Mr' 'Ms');
			installGlobalCollection: 'Titles' inSlotNamed: 'titles' inModule: LxxBarebonesSystem ;
			installSlotIn: LxxBarebonesPerson;
			yourself.

	builder install.
	
	titleBaseClass := self classNamed: 'LxxBaseTitle'.
	titleClass := self classNamed: 'LxxTitle'.
	unknownTitleClass := self classNamed: 'LxxUnknownTitle'.
	titlesClass := self classNamed: 'LxxTitles'.
	
	self assert: titleBaseClass notNil.
	self assert: titleClass notNil.
	self assert: unknownTitleClass notNil.
	self assert: titlesClass notNil.
	
	self assert: titleBaseClass superclass equals: LcsCode.
	self assert: titleClass superclass equals: titleBaseClass.
	self assert: unknownTitleClass superclass equals: titleBaseClass.

	self assert: titlesClass superclass equals: LcsCodes.
	
	LxxBarebonesPerson verifyClassHasDomainSlotNamed: 'title'.
	LxxBarebonesSystem verifyClassHasDomainSlotNamed: 'titles'
]
