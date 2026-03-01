Class {
	#name : 'LcsValueObjectsCollectionClassBuilderExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsValueObjectsCollectionClassBuilderExamples >> classBuilder [
	<gtExample>
	| builder |
	builder := self newBuilder
				newClassName: self newClassName;
				targetPackageName: 'Lcs-Temp';
				targetSuperclassName: self targetSuperclassName;
				rootName: 'Male';
				yourself.
	builder buildJobSteps.
	self assert: builder jobSteps hasNoJobSteps.
	^ builder
]

{ #category : 'examples' }
LcsValueObjectsCollectionClassBuilderExamples >> classCreationString [
	<gtExample>
	| builder |
	builder := self classBuilder.
	self
		assert: builder classCreationString
		equals:  
'LcsValueObjects subclass: #LxxMale1s
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '.
	^ builder
]

{ #category : 'examples' }
LcsValueObjectsCollectionClassBuilderExamples >> installAndRemoveClass [
	<gtExample>
	| builder |
	builder := self classBuilder.
	[ 
	  self assertClassDoesntExist: self newClassName.
	  builder installCode.
	  self assertClassExists: self newClassName.
	  builder verifyCodeInstallation ]
		ensure: [ 
			builder uninstall.
			builder verifyUninstall.
			self assertClassDoesntExist: self newClassName ].
	^ builder
]

{ #category : 'examples' }
LcsValueObjectsCollectionClassBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsValueObjectsCollectionClassBuilder new.
	^ builder
]

{ #category : 'private' }
LcsValueObjectsCollectionClassBuilderExamples >> newClassName [
	^ 'LxxMale1' asEnglishPlural
]

{ #category : 'private' }
LcsValueObjectsCollectionClassBuilderExamples >> targetSuperclassName [
	^ 'LcsValueObjects'
]
