Class {
	#name : 'LcsValueObjectSuperClassBuilderExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsValueObjectSuperClassBuilderExamples >> classBuilder [
	<gtExample>
	| builder |
	builder := self newBuilder
				newClassName: self newClassName;
				targetPackageName: 'Lcs-Temp';
				targetSuperclassName: self targetSuperclassName;
				rootName: 'Male';
				yourself.
		
	self should: [ builder isDefaultInstance ] raise: Error.
	self should: [ builder description ] raise: Error.
	self should: [ builder code ] raise: Error.
	self should: [ builder label ] raise: Error.

	builder buildJobSteps.
	self assert: builder jobSteps hasNoJobSteps.
	^ builder
]

{ #category : 'examples' }
LcsValueObjectSuperClassBuilderExamples >> classCreationString [
	<gtExample>
	| builder |
	builder := self classBuilder.
	self
		assert: builder classCreationString
		equals: 
'LcsValueObject subclass: #LxxMale1
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '.
	^ builder
]

{ #category : 'examples' }
LcsValueObjectSuperClassBuilderExamples >> installAndRemoveClass [
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
LcsValueObjectSuperClassBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsValueObjectSuperClassBuilder new.
	^ builder
]

{ #category : 'private' }
LcsValueObjectSuperClassBuilderExamples >> newClassName [
	^ 'LxxMale1'
]

{ #category : 'private' }
LcsValueObjectSuperClassBuilderExamples >> targetSuperclassName [
	^ 'LcsValueObject'
]
