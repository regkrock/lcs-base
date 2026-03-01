Class {
	#name : 'LcsValueObjectsLoaderClassBuilderExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsValueObjectsLoaderClassBuilderExamples >> classCreationString [
	<gtExample>
	| builder |
	builder := self loaderBuilder.
	
	self
		assert: builder classCreationString
		equals: 
'LcsValueObjectsLoader subclass: #LxxMale1
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '
]

{ #category : 'examples' }
LcsValueObjectsLoaderClassBuilderExamples >> installAndRemoveClass [
	<gtExample>
	| builder |
	builder := self loaderBuilder.
	[
	  self assertClassDoesntExist: self newClassName.
	  builder installCode.
	  self assertClassExists: self newClassName.
	  builder verifyCodeInstallation ]
		ensure: [
			builder uninstall.
			builder verifyUninstall. 
			self assertClassDoesntExist: self newClassName].
	^ builder

]

{ #category : 'examples' }
LcsValueObjectsLoaderClassBuilderExamples >> loaderBuilder [
	<gtExample>
	| builder |
	builder := self newBuilder
				newClassName: self newClassName;
				targetPackageName: 'Lcs-Temp';
				instanceClassName: 'LxxPerson';
				yourself.
	builder buildJobSteps.
	self assert: builder jobSteps hasNoJobSteps.
	^ builder
]

{ #category : 'examples' }
LcsValueObjectsLoaderClassBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsValueObjectsLoaderClassBuilder new.
	^ builder
]

{ #category : 'private' }
LcsValueObjectsLoaderClassBuilderExamples >> newClassName [
	^ 'LxxMale1'
]

{ #category : 'private' }
LcsValueObjectsLoaderClassBuilderExamples >> targetSuperclassName [
	^ 'LcsDomainObject'
]
