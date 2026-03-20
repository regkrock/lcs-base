Class {
	#name : 'LcsStandardValueObjectClassesBuilderJobExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsStandardValueObjectClassesBuilderJobExamples >> installAndRemoveTitles [
	<gtExample>
	| builderJob |
	self ensureCurrentSystemIsPrototypeSystem.
	self currentSystem clearUnitOfWork.
	builderJob := self titlesStandardValueObjectBuilderJob.
	[
	  builderJob execute.
	  builderJob verifyCodeInstallation.
	  self verifyInstallationOf: builderJob ]
	    ensure: [
	    	builderJob uninstall.
	    	builderJob verifyUninstall ]
]

{ #category : 'examples' }
LcsStandardValueObjectClassesBuilderJobExamples >> newBuilderJob [
	<gtExample>
	| builderJob |
	self ensureCurrentSystemIsPrototypeSystem.
	builderJob := LcsStandardValueObjectClassesBuilderJob new.
	^ builderJob
]

{ #category : 'examples' }
LcsStandardValueObjectClassesBuilderJobExamples >> testCreationOfSingletonClasses [
	| person |
	self currentCodeBuilderJob: self titlesStandardValueObjectBuilderJob.
	self currentCodeBuilderJob execute.

	person := LxxPerson new.
	self
		assert: person title
		identicalTo: (self currentSystem moduleNamed: LxxPersonsModule defaultModuleName) titles
				defaultInstance
]

{ #category : 'examples' }
LcsStandardValueObjectClassesBuilderJobExamples >> titlesStandardValueObjectBuilderJob [
	<gtExample>
	| builderJob |
	builderJob :=  self newBuilderJob
		classPrefix: 'Lxx';
		createForRootName: 'Title';
		installNewClassesInPackageNamed: 'Lcs-Temp';
		installCollectionSlotInClass: LxxPersonsModule;
		createProtoCodesFromLabels: #('Mr' 'Ms' '');
		targetModuleClass: LxxPrototypeSystem;
		installMemberSlotInDomainClass: LxxBasePerson;
		yourself.
	builderJob buildJobSteps.
	^ builderJob
]

{ #category : 'validation' }
LcsStandardValueObjectClassesBuilderJobExamples >> verifyInstallationOf: builderJob [
	| person module |
	person := LxxPerson new.
	module := self currentSystem moduleNamed: LxxPersonsModule defaultModuleName.
	self assert: person title identicalTo: module titles defaultInstance
]
