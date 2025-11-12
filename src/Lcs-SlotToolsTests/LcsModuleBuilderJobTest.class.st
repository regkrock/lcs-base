Class {
	#name : #LcsModuleBuilderJobTest,
	#superclass : #LcsCodeJobBuilderTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #examples }
LcsModuleBuilderJobTest >> sailClubModuleBuilderExample [
	<gtExample>
	| job |
	job := LcsModuleBuilderJob new.
	job 
		classPrefix: 'Lxx';
		createForRootName:'SailingClub';
		moduleName: 'Sailing Club Module';
		owningModule: LxxPrototypeSystem;
		buildJobSteps.

		
	self assert: (self classNamed: 'LxxSailingClubModule') isNil.
	self assert: (self classNamed: 'LxxSailingClubModuleConfiguration') isNil.
	self deny: (LcsModule respondsTo: #sailingClubModule).

	^ job
]

{ #category : #tests }
LcsModuleBuilderJobTest >> testCreationOfNewModule [
	self subject: self sailClubModuleBuilderExample.

	self subject installCode.

	self assert: (self classNamed: 'LxxSailingClubModule') notNil.
	self assert: (self classNamed: 'LxxSailingClubModuleConfiguration') notNil.
	self assert: (LcsModule canUnderstand: #sailingClubModule).
	self assert: ((self classNamed: 'LxxSailingClubModule') respondsTo: #owningModules).
	
	self subject uninstall.

	self assert: (self classNamed: 'LxxSailingClubModule') isNil.
	self assert: (self classNamed: 'LxxSailingClubModuleConfiguration') isNil.
	self deny: (LcsModule canUnderstand: #sailingClubModule)
]
