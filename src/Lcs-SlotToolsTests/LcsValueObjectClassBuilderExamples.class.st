Class {
	#name : 'LcsValueObjectClassBuilderExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsValueObjectClassBuilderExamples >> classCreationString [
	<gtExample>
	| builder |
	builder := self valueObjectClassBuilder.
	self
		assert: builder classCreationString
		equals: 
'LcsValueObject subclass: #LxxMale1
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '.
	^builder
]

{ #category : 'examples' }
LcsValueObjectClassBuilderExamples >> installAndRemoveClass [
	<gtExample>
	| builder |
	builder := self valueObjectClassBuilder.
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
LcsValueObjectClassBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsValueObjectClassBuilder new.
	self assert: builder isDefaultInstance not.
	self should: [ builder description ] raise: Error.
	self should: [ builder code ] raise: Error.
	self should: [ builder label ] raise: Error.
	^ builder
]

{ #category : 'private' }
LcsValueObjectClassBuilderExamples >> newClassName [
	^ 'LxxMale1'
]

{ #category : 'private' }
LcsValueObjectClassBuilderExamples >> targetSuperclassName [
	^ 'LcsValueObject'
]

{ #category : 'examples' }
LcsValueObjectClassBuilderExamples >> valueObjectClassBuilder [
	<gtExample>
	| builder |
	builder := self newBuilder.
	builder
		newClassName: self newClassName;
		targetPackageName: 'Lcs-Temp';
		targetSuperclassName: self targetSuperclassName;
		rootName: 'Male'.
	builder buildJobSteps.
	self assert: builder jobSteps hasNoJobSteps.
	^ builder
]
