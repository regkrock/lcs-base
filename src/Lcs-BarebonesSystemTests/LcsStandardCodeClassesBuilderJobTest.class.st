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
			codeSuperclassRootName: 'Talent';
			installCodesInPackageNamed: 'Lcs-BarebonesSystem';
			createCodeInstances: #('Guitar' 'Saxaphone');
			installGlobalCollection: 'Talents' inSlotNamed: 'talents' inModule: LxxBarebonesSystem ;
			installSlotIn: LxxBarebonesPerson;
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

	self assert: builder memberOfSlotBuilder slotName equals: 'talent'.
	self assert: builder memberOfSlotBuilder collectionSlotName equals: 'talents'.
	self assert: builder memberOfSlotBuilder moduleName equals: LxxBarebonesSystem moduleName.

]

{ #category : #tests }
LcsStandardCodeClassesBuilderJobTest >> testInstallingTitleCodesAndTitleSlotInPerson [
	| builder talentClass talentsClass |

	LxxBarebonesPerson verifyClassHasNoDomainSlotNamed: 'talent'.
	LxxBarebonesSystem verifyClassHasNoDomainSlotNamed: 'talents'.
	
	builder := 
		LcsStandardCodeClassesBuilderJob new
			classPrefix: 'Lxx';
			codeSuperclassRootName: 'Talent';
			installCodesInPackageNamed: 'Lcs-BarebonesSystem';
			createCodeInstances: #('Guitar' 'Saxaphone');
			installGlobalCollection: 'Talents' inSlotNamed: 'talents' inModule: LxxBarebonesSystem ;
			installSlotIn: LxxBarebonesPerson;
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
