Class {
	#name : 'LcsStandardValueObjectWithUnknownClassClassesBuilderJobExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsStandardValueObjectWithUnknownClassClassesBuilderJobExamples >> installAndRemoveTitles [
	<gtExample>
	<after: #clearUnitOfWork>
	| builderJob |
	self ensureCurrentSystemIsPrototypeSystem.
	builderJob := self titlesWithUnknownTitleClassStandardValueObjectBuilderJob.
	[
	  builderJob execute.
	  builderJob verifyCodeInstallation.
	  self verifyInstallationOf: builderJob ]
	    ensure: [
	    	builderJob uninstall.
	    	builderJob verifyUninstall ]
]

{ #category : 'examples' }
LcsStandardValueObjectWithUnknownClassClassesBuilderJobExamples >> newBuilderJob [
	<gtExample>
	| builderJob |
	self ensureCurrentSystemIsPrototypeSystem.
	builderJob := LcsStandardValueObjectWithUnknownClassClassesBuilderJob new.
	^ builderJob
]

{ #category : 'examples' }
LcsStandardValueObjectWithUnknownClassClassesBuilderJobExamples >> titlesWithUnknownTitleClassStandardValueObjectBuilderJob [
	| builderJob |
	builderJob := self newBuilderJob
					classPrefix: 'Lxx';
					createForRootName: 'Title';
					installNewClassesInPackageNamed: 'Lcs-Temp';
					installCollectionSlotInClass: LxxPersonsModule;
					createProtoCodesFromLabels: #('Mr' 'Ms' '');
					targetModuleClass: LxxPrototypeSystem;
					installMemberSlotInDomainClass: LxxBasePerson;
					buildUnknownClass: true;
					yourself.
	builderJob buildJobSteps.
	^ builderJob
]

{ #category : 'verification' }
LcsStandardValueObjectWithUnknownClassClassesBuilderJobExamples >> verifyInstallationOf: builderJob [
	| person module |
	person := LxxPerson new.
	module := self currentSystem moduleNamed: LxxPersonsModule defaultModuleName.
	self assert: person title identicalTo: module titles defaultInstance.
	self assert: module titles defaultInstance class name = #LxxUnknownTitle
]
