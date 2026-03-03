Class {
	#name : 'LcsSystemBuilderJobExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsSystemBuilderJobExamples >> clubSystemBuilderJob [
	<gtExample>
	| builderJob |

	builderJob := self newBuilderJob
					classPrefix: 'Lxx';
					createForRootName: 'ClubSystem';
					moduleName: 'Club System';
					buildJobSteps.
	self assert: builderJob numberOfSubsteps equals: 2.
	self assertClassDoesntExist: builderJob newDomainClassName.
	self assertClassDoesntExist: builderJob systemConfigurationClassName.
	self deny: (LcsModule respondsTo: #clubSystem).
	"self deny: ((self classNamed: 'LxxClubSystem') respondsTo: #owningModules)."
	^ builderJob
]

{ #category : 'examples' }
LcsSystemBuilderJobExamples >> clubSystemMethodCreationBuilder [
	<gtExample>
	| builder |
	builder := self clubSystemBuilderJob builderAtStep: '2.2'.
	self assert: builder jobStepDescription equals:'2.2) Install #clubSystem in LcsModule'.
	^ builder
]

{ #category : 'examples' }
LcsSystemBuilderJobExamples >> configuartionSlotDefinitionMethodCreationBuilder [
	<gtExample>
	| builder |
	builder := self clubSystemBuilderJob builderAtStep: '2.4'.
	self assert: builder jobStepDescription equals:'2.4) Install #configurationSlotDefinition in LxxClubSystem class'.
	^ builder
]

{ #category : 'examples' }
LcsSystemBuilderJobExamples >> configurationClassBuilder [
	<gtExample>
	| builder |
	builder := self clubSystemBuilderJob builderAtStep: '1'.
	self assert: builder jobStepDescription equals: '1) Create class: LxxClubSystemConfiguration as subclass of LcsBaseConfiguration'.
	self assert: builder refactoringText equals: 'LcsBaseConfiguration subclass: #LxxClubSystemConfiguration
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lxx-ClubSystem'' '.
	^ builder
]

{ #category : 'examples' }
LcsSystemBuilderJobExamples >> createNewClubSystemMethodCreationBuilder [
	<gtExample>
	| builder |
	builder := self clubSystemBuilderJob builderAtStep: '2.6'.
	self assert: builder jobStepDescription equals:'2.6) Install #createNewClubSystem in LcsApplicationEnvironment class'.
	^ builder
]

{ #category : 'examples' }
LcsSystemBuilderJobExamples >> defaultModuleNameMethodCreationBuilder [
	<gtExample>
	| builder |
	builder := self clubSystemBuilderJob builderAtStep: '2.1'.
	self assert: builder jobStepDescription equals:'2.1) Install #defaultModuleName in LxxClubSystem class'.
	^ builder
]

{ #category : 'examples' }
LcsSystemBuilderJobExamples >> installAndRemoveClubSystem [
	<gtExample>
	| builderJob |
	self ensureCurrentSystemIsPrototypeSystem.
	builderJob := self clubSystemBuilderJob.
	[ 
		builderJob installCode.
		builderJob verifyCodeInstallation ] 
			ensure: [ self uninstall: builderJob ]
]

{ #category : 'examples' }
LcsSystemBuilderJobExamples >> moduleConfigurationClassMethodCreationBuilder [
	<gtExample>
	| builder |
	builder := self clubSystemBuilderJob builderAtStep: '2.3'.
	self assert: builder jobStepDescription equals:'2.3) Install #moduleConfigurationClass in LxxClubSystem class'.
	^ builder
]

{ #category : 'examples' }
LcsSystemBuilderJobExamples >> newBuilderJob [
	<gtExample>
	| builderJob |
	builderJob := LcsSystemBuilderJob new.
	^ builderJob
]

{ #category : 'examples' }
LcsSystemBuilderJobExamples >> owningModulesMethodUpdateBuilder [
	<gtExample>
	| builder |
	builder := self clubSystemBuilderJob builderAtStep: '2.7'.
	self assert: builder jobStepDescription equals:'2.7) Update #owningModules in LcsSecurityModule class'.
	^ builder
]

{ #category : 'examples' }
LcsSystemBuilderJobExamples >> systemClassBuilder [
	<gtExample>
	| builder |
	builder := self clubSystemBuilderJob builderAtStep: '2'.
	self assert: builder jobStepDescription equals: '2) Create class: LxxClubSystem as subclass of LcsSystem'.
	self assert: builder numberOfSubsteps = 7.
	^ builder
]

{ #category : 'examples' }
LcsSystemBuilderJobExamples >> systemDomainClassesMethodCreationBuilder [
	<gtExample>
	| builder |
	builder := self clubSystemBuilderJob builderAtStep: '2.5'.
	self assert: builder jobStepDescription equals:'2.5) Install #systemDomainClasses in LxxClubSystem'.
	^ builder
]

{ #category : 'private' }
LcsSystemBuilderJobExamples >> uninstall: builderJob [
	builderJob uninstall.
	builderJob verifyUninstall.
	self assertClassDoesntExist: builderJob newDomainClassName.
	self assertClassDoesntExist: builderJob systemConfigurationClassName.
	^ self deny: (LcsModule canUnderstand: #clubSystem)
]
