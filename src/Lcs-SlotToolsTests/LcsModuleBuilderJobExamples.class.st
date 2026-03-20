Class {
	#name : 'LcsModuleBuilderJobExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsModuleBuilderJobExamples >> installAndRemoveModule [
	<gtExample>
	| builderJob |
	self ensureCurrentSystemIsPrototypeSystem.
	self currentSystem clearUnitOfWork.
	builderJob := self sailClubModuleBuilderJob.
	[
	  builderJob execute.
	  builderJob verifyCodeInstallation.
	  self verifyInstallationOf: builderJob ]
	    ensure: [
	    	builderJob uninstall.
	    	builderJob verifyUninstall ]
]

{ #category : 'examples' }
LcsModuleBuilderJobExamples >> newBuilderJob [
	<gtExample>
	| builderJob |
	self ensureCurrentSystemIsPrototypeSystem.
	builderJob := LcsModuleBuilderJob new.
	^ builderJob
]

{ #category : 'examples' }
LcsModuleBuilderJobExamples >> sailClubModuleBuilderJob [
	<gtExample>
	| builderJob |
	builderJob := LcsModuleBuilderJob new 
					classPrefix: 'Lxx';
					createForRootName:'SailingClub';
					moduleName: 'Sailing Club Module';
					owningModule: LxxPrototypeSystem;
					yourself.
	builderJob buildJobSteps.

	self assert: (self classNamed: 'LxxSailingClubModule') isNil.
	self assert: (self classNamed: 'LxxSailingClubModuleConfiguration') isNil.
	self deny: (LcsModule respondsTo: #sailingClubModule).

	^ builderJob
]

{ #category : 'tests' }
LcsModuleBuilderJobExamples >> testCreationOfNewModule [
	self subject: self sailClubModuleBuilderJob.

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

{ #category : 'examples' }
LcsModuleBuilderJobExamples >> verifyInstallationOf: builderJob [ 
	self assert: self currentSystem sailingClubModule class name = #LxxSailingClubModule
]
