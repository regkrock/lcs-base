Class {
	#name : 'LcsSingletonCodeClassBuilderTest',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsSingletonCodeClassBuilderTest >> installAndRemoveClass [
	<gtExample>
	| builder |
	self ensureCurrentSystemIsPrototypeSystem.
	builder := self singletonValueObjectClassBuilder.
	
	[
	  self assertClassDoesntExist: self newClassName.
  	builder installCode.
	  self assertClassExists: self newClassName.
	  builder verifyCodeInstallation]
		ensure: [
			builder uninstall.
			builder verifyUninstall.
			self assertClassDoesntExist: self newClassName ].
	^ builder
]

{ #category : 'examples' }
LcsSingletonCodeClassBuilderTest >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsSingletonValueObjectClassBuilder new.
	^builder
]

{ #category : 'private' }
LcsSingletonCodeClassBuilderTest >> newClassName [
	^ 'LxxMale1'
]

{ #category : 'examples' }
LcsSingletonCodeClassBuilderTest >> singletonValueObjectClassBuilder [
	<gtExample>
	| builder |
	builder := self newBuilder
				newClassName: self newClassName;
				targetPackageName: 'Lcs-Temp';
				targetSuperclassName: self targetSuperclassName;
				rootName: 'Male'.

	self assert: builder isDefaultInstance not.
	self assert: builder description = 'Male'.
	self assert: builder code = #male.
	self assert: builder label = 'Male'.
	builder buildJobSteps.
	self assert: builder jobSteps hasNoJobSteps .
	^ builder
]

{ #category : 'examples' }
LcsSingletonCodeClassBuilderTest >> singletonValueObjectClassCreationString [
	<gtExample>
	| builder |
	builder := self singletonValueObjectClassBuilder.
	self
		assert: builder classCreationString
		equals: 'LcsValueObject subclass: #LxxMale1
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '.
	^ builder
]

{ #category : 'private' }
LcsSingletonCodeClassBuilderTest >> targetSuperclassName [
	^ 'LcsValueObject'
]
