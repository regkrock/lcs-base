Class {
	#name : 'LcsUnknownClassBuilderExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsUnknownClassBuilderExamples >> classCreationString [
	<gtExample>
	| builder |
	builder := self unknownClassBuilder.
	self
		assert: builder classCreationString
		equals: 
'LcsDomainObject subclass: #LxxMale1
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '.
	^ builder
]

{ #category : 'examples' }
LcsUnknownClassBuilderExamples >> installAndRemoveClass [
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
LcsUnknownClassBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsUnknownClassBuilder new.
	^ builder
]

{ #category : 'private' }
LcsUnknownClassBuilderExamples >> newClassName [
	^ 'LxxMale1'
]

{ #category : 'private' }
LcsUnknownClassBuilderExamples >> targetSuperclassName [
	^ 'LcsDomainObject'
]

{ #category : 'tests' }
LcsUnknownClassBuilderExamples >> testClassCreationString [
	self subject: LcsUnknownClassBuilder new.
	self subject
		newClassName: self newClassName;
		targetPackageName: 'Lcs-Temp';
		targetSuperclassName: self targetSuperclassName.
	
	self
		assert: self subject classCreationString
		equals: 
'LcsDomainObject subclass: #LxxMale1
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '
]

{ #category : 'examples' }
LcsUnknownClassBuilderExamples >> testInstallClass [
	self subject: LcsUnknownClassBuilder new.
	self subject
		newClassName: self newClassName;
		targetPackageName: 'Lcs-Temp';
		targetSuperclassName: self targetSuperclassName.
		
	self subject buildJobSteps.
	self assert: self subject jobSteps hasNoJobSteps .
	
	self should: [ self newClassName asClass ] raise: NotFound.
	self subject installCode.
	self shouldnt: [ self newClassName asClass ] raise: NotFound.
	self subject verifyCodeInstallation

]

{ #category : 'examples' }
LcsUnknownClassBuilderExamples >> unknownClassBuilder [
	<gtExample>
	| builder |
	builder := self newBuilder.
	builder
		newClassName: self newClassName;
		targetPackageName: 'Lcs-Temp';
		targetSuperclassName: self targetSuperclassName.
	builder buildJobSteps.
	self assert: builder jobSteps hasNoJobSteps.
	^ builder
]
