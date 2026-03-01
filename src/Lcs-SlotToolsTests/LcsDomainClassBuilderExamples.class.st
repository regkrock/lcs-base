Class {
	#name : 'LcsDomainClassBuilderExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'as yet unclassified' }
LcsDomainClassBuilderExamples >> builderInstallAndRemoveClass [
	<gtExample>
	| builder |
	self ensureCurrentSystemIsPrototypeSystem.
	[
		self should: [ self newClassname asClass ] raise: NotFound.
		builder := self builderWithLxxMale1CreationString.
		builder installCode.
		self shouldnt: [ self newClassname asClass ] raise: NotFound.
		builder verifyCodeInstallation]
	ensure: [
		builder uninstall.
		builder verifyUninstall.
		self should: [ self newClassname asClass ] raise: NotFound].
	^ builder
]

{ #category : 'examples' }
LcsDomainClassBuilderExamples >> builderToCreateLxxMale1Class [
	<gtExample>
	| builder |
	builder := self newBuilder.
	builder
		newClassName: self newClassname;
		targetPackageName: 'Lcs-Temp';
		targetPackageTagName: 'Core'.
	^ builder
]

{ #category : 'examples' }
LcsDomainClassBuilderExamples >> builderWithLxxMale1CreationString [
	<gtExample>	
	| builder |
	builder := self builderToCreateLxxMale1Class.
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
LcsDomainClassBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsDomainClassBuilder new.
	self assert: builder newClassName isNil.
	self assert: builder jobSteps isEmpty.
	self assert: builder targetPackageName isNil.
	self assert: builder targetPackageTagName isNil.
	self assert: builder rootName isNil.
	self assert: builder targetSuperclassName equals: 'LcsDomainObject'.
	^ builder
]

{ #category : 'private' }
LcsDomainClassBuilderExamples >> newClassname [
	^ 'LxxMale1'
]
