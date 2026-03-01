Class {
	#name : 'LcsSingletonUnknownValueObjectClassBuilderExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsSingletonUnknownValueObjectClassBuilderExamples >> installAndRemoveClass [
	<gtExample>
	| builder |
	builder := self unknownClassBuilder.
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
LcsSingletonUnknownValueObjectClassBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsSingletonUnknownValueObjectClassBuilder new.
	^ builder
]

{ #category : 'private' }
LcsSingletonUnknownValueObjectClassBuilderExamples >> newClassName [
	^ 'XxxUnknownCode'
]

{ #category : 'private' }
LcsSingletonUnknownValueObjectClassBuilderExamples >> targetPackageName [
	^ 'Lcs-Temp'
]

{ #category : 'private' }
LcsSingletonUnknownValueObjectClassBuilderExamples >> targetSuperclassName [
	^ 'LcsSingletonValueObject'
]

{ #category : 'examples' }
LcsSingletonUnknownValueObjectClassBuilderExamples >> unknownClassBuilder [
	<gtExample>
	| builder |
	builder := self newBuilder.
	builder
		newClassName: self newClassName;
		targetPackageName: self targetPackageName;
		targetSuperclassName: self targetSuperclassName.

	self assert: builder defaultInstance = true.
	self assert: builder description = ''.
	self assert: builder label = ''.
	self assert: builder code = 'unknown'.
	self assert: builder newClassName = self newClassName.

	builder buildJobSteps.
	self assert: builder jobSteps hasNoJobSteps.
	^ builder
]

{ #category : 'tests' }
LcsSingletonUnknownValueObjectClassBuilderExamples >> unknownCodeClassCreationString [
	<gtExample>
	| builder |
	builder := self unknownClassBuilder.
	self
		assert: builder classCreationString
		equals: 'LcsSingletonValueObject subclass: #XxxUnknownCode
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '.
	^ builder
]
