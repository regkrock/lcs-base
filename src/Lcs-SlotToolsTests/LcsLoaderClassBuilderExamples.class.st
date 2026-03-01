Class {
	#name : 'LcsLoaderClassBuilderExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsLoaderClassBuilderExamples >> builderToCreateLxxGenderLoaderClass [
	<gtExample>
	| builder |
	builder := self newBuilder.
	builder
		newClassName: self newClassname;
		targetPackageName: 'Lcs-Temp';
		targetPackageTagName: 'Core';
		instanceClassName: 'LxxPerson'. 
	^builder
]

{ #category : 'examples' }
LcsLoaderClassBuilderExamples >> builderWithLxxGenderLoaderCreationString [
	<gtExample>	
	| builder |
	builder := self builderToCreateLxxGenderLoaderClass.
	self
		assert: builder classCreationString
		equals: 'LcsObjectsLoader subclass: #LxxGenderLoader
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '.
	^ builder
]

{ #category : 'examples' }
LcsLoaderClassBuilderExamples >> installAndRemoveClass [
	<gtExample>
	| builder |
	self ensureCurrentSystemIsPrototypeSystem.
	builder := self builderToCreateLxxGenderLoaderClass.
	[
	  self assertClassDoesntExist: self newClassname.
	  builder installCode.
	  self assertClassExists: self newClassname.
	  builder verifyCodeInstallation ]
		ensure: [
			builder uninstall.
			builder verifyUninstall.
			self assertClassDoesntExist: self newClassname ]

]

{ #category : 'examples' }
LcsLoaderClassBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder :=  LcsLoaderClassBuilder new.
	self assert: builder newClassName isNil.
	self assert: builder jobSteps isEmpty.
	self assert: builder targetPackageName isNil.
	self assert: builder targetPackageTagName isNil.
	self assert: builder rootName isNil.
	self assert: builder instanceClassName isNil.
	self assert: builder targetSuperclassName equals: 'LcsObjectsLoader'.
	^ builder
]

{ #category : 'private' }
LcsLoaderClassBuilderExamples >> newClassname [
	^ 'LxxGenderLoader'
]
