Class {
	#name : #LcsStandardCodeClassesBuilderJobTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-BarebonesSystemTests'
}

{ #category : #running }
LcsStandardCodeClassesBuilderJobTest >> setupSunitSystem [
	LxxBarebonesSystem new
]

{ #category : #running }
LcsStandardCodeClassesBuilderJobTest >> tearDown [
	LxxBarebonesSystem removeDomainSlotNamed: 'talents'.
	LxxBarebonesPerson removeDomainSlotNamed: 'talent'.
	self removeClassesNamed: #('LxxTalents' 'LxxTalent' ).
	super tearDown
]

{ #category : #tests }
LcsStandardCodeClassesBuilderJobTest >> testCreatingJobToAddTalentCodeAndInstallTalentSlotInPerson [
	| builder |
	builder := 
		LcsStandardCodeClassesBuilderJob new
			classPrefix: 'Lxx';
			installNewClassesInPackageNamed: 'Lcs-BarebonesSystem';
			codeRootName: 'Talent';
			createCodeInstances: #('Guitar' 'Saxaphone');
			installGlobalCollectionSlotInModule: LxxBarebonesSystem ;
			installSlotInDomainClass: LxxBarebonesPerson;
			yourself.
	
	self assert: builder classPrefix equals: 'Lxx'.
	self assert: builder codePackageName equals: 'Lcs-BarebonesSystem'.
	self assert: builder completedRefactorings isEmpty.
	
	self assert: builder codeSuperclassBuilder superclassName equals: 'LcsCode'.
	self assert: builder codeSuperclassBuilder installClassName equals: 'LxxTalent'.
	self assert: builder codeSuperclassBuilder codePackageName  equals: 'Lcs-BarebonesSystem'.
	
	self assert: builder codeCollectionClassBuilder superclassName equals: 'LcsCodes'.
	self assert: builder codeCollectionClassBuilder installClassName equals: 'LxxTalents'.
	self assert: builder codeCollectionClassBuilder codePackageName equals: 'Lcs-BarebonesSystem'.

	self assert: builder globalCollectionSlotBuilder slotName equals: 'talents'.
	self assert: builder globalCollectionSlotBuilder moduleName equals: LxxBarebonesSystem moduleName.
	self assert: builder globalCollectionSlotBuilder targetClassName equals: 'LxxBarebonesSystem'.
	self assert: builder globalCollectionSlotBuilder target equals: LxxBarebonesSystem.
	self assert: builder globalCollectionSlotBuilder slotClassName equals: 'LxxTalents'.

	self assert: builder memberOfSlotInDomainClassBuilder slotName equals: 'talent'.
	self assert: builder memberOfSlotInDomainClassBuilder collectionSlotName equals: 'talents'.
	self assert: builder memberOfSlotInDomainClassBuilder moduleName equals: LxxBarebonesSystem moduleName.

]

{ #category : #tests }
LcsStandardCodeClassesBuilderJobTest >> testInstallingTitleCodesAndTitleSlotInPerson [
	| builder talentClass talentsClass |

	LxxBarebonesPerson verifyClassHasNoDomainSlotNamed: 'talent'.
	LxxBarebonesSystem verifyClassHasNoDomainSlotNamed: 'talents'.
	
	builder := 
		LcsStandardCodeClassesBuilderJob new
			classPrefix: 'Lxx';
			installNewClassesInPackageNamed: 'Lcs-BarebonesSystem';
			codeRootName: 'Talent';
			createCodeInstances: #('Guitar' 'Saxaphone');
			installGlobalCollectionSlotInModule: LxxBarebonesSystem ;
			installSlotInDomainClass: LxxBarebonesPerson;
			yourself.
				
	builder install.
	
	talentClass := self classNamed: 'LxxTalent'.
	talentsClass := self classNamed: 'LxxTalents'.
	
	self assert: talentClass notNil.
	self assert: talentsClass notNil.
	
	self assert: talentClass superclass equals: LcsCode.
	self assert: talentsClass superclass equals: LcsCodes.
	
	LxxBarebonesPerson verifyClassHasDomainSlotNamed: 'talent'.
	LxxBarebonesSystem verifyClassHasDomainSlotNamed: 'talents'
]
