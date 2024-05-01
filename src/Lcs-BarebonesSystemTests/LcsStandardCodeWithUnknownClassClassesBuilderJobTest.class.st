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
			installNewClassesInPackageNamed: 'Lcs-BarebonesSystem';
			codeRootName: 'Title';
			createCodeInstances: #('Mr' 'Ms');
			installGlobalCollectionSlotInModule: LxxBarebonesSystem ;
			installSlotInDomainClass: LxxBarebonesPerson;
			yourself.
	
	self assert: builder classPrefix equals: 'Lxx'.
	self assert: builder codePackageName equals: 'Lcs-BarebonesSystem'.
	self assert: builder completedRefactorings isEmpty.
	
	self assert: builder codeSuperclassBuilder superclassName equals: 'LcsCode'.
	self assert: builder codeSuperclassBuilder installClassName equals: 'LxxBaseTitle'.
	self assert: builder codeSuperclassBuilder codePackageName  equals: 'Lcs-BarebonesSystem'.

	self assert: builder codeSubclassesBuilderJobSteps collection size equals: 2.
	self assert: (builder codeSubclassesBuilderJobSteps collection at: 1) superclassName equals: 'LxxBaseTitle'.
	self assert: (builder codeSubclassesBuilderJobSteps collection at: 1) installClassName equals: 'LxxTitle'.
	self assert: (builder codeSubclassesBuilderJobSteps collection at: 1) codePackageName equals: 'Lcs-BarebonesSystem'.
	self deny: (builder codeSubclassesBuilderJobSteps collection at: 1) isDefaultInstance.
	
	self assert: (builder codeSubclassesBuilderJobSteps collection at: 2) superclassName equals: 'LxxBaseTitle'.
	self assert: (builder codeSubclassesBuilderJobSteps collection at: 2) installClassName equals: 'LxxUnknownTitle'.
	self assert: (builder codeSubclassesBuilderJobSteps collection at: 2) codePackageName equals: 'Lcs-BarebonesSystem'.
	self assert: (builder codeSubclassesBuilderJobSteps collection at: 2) isDefaultInstance.
	
	self assert: builder codeCollectionClassBuilder superclassName = 'LcsCodes'.
	self assert: builder codeCollectionClassBuilder installClassName equals: 'LxxTitles'.
	self assert: builder codeCollectionClassBuilder codePackageName equals: 'Lcs-BarebonesSystem'.
	
	self assert: builder globalCollectionSlotBuilder slotName equals: 'titles'.
	self assert: builder globalCollectionSlotBuilder moduleName equals: LxxBarebonesSystem moduleName.
	self assert: builder globalCollectionSlotBuilder targetClassName equals: 'LxxBarebonesSystem'.
	self assert: builder globalCollectionSlotBuilder target equals: LxxBarebonesSystem.
	self assert: builder globalCollectionSlotBuilder slotClassName equals: 'LxxBaseTitle'.


	self assert: builder memberOfSlotInDomainClassBuilder slotName equals: 'title'.
	self assert: builder memberOfSlotInDomainClassBuilder collectionSlotName equals: 'titles'.
	self assert: builder memberOfSlotInDomainClassBuilder moduleName equals: LxxBarebonesSystem moduleName.

]

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> testInstallingTitleCodesAndTitleSlotInPerson [
	| builder titleBaseClass titleClass unknownTitleClass titlesClass |
	
	LxxBarebonesPerson verifyClassHasNoDomainSlotNamed: 'title'.
	LxxBarebonesSystem verifyClassHasNoDomainSlotNamed: 'titles'.
	
	builder := 
		LcsStandardCodeWithUnknownClassClassesBuilderJob new
			classPrefix: 'Lxx';
			installNewClassesInPackageNamed: 'Lcs-BarebonesSystem';
			codeRootName: 'Title';
			createCodeInstances: #('Mr' 'Ms');
			installGlobalCollectionSlotInModule: LxxBarebonesSystem ;
			installSlotInDomainClass: LxxBarebonesPerson;
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
