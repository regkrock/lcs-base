Class {
	#name : 'LcsDomainCollectionClassBuilderTest',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsDomainCollectionClassBuilderTest >> builderInstallAndRemoveClass [
	<gtExample>
	| builder |
	self ensureCurrentSystemIsPrototypeSystem.
	[
		self should: [ self newClassname asClass ] raise: NotFound.
		builder := self builderWithLxxMalesCreationString.
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
LcsDomainCollectionClassBuilderTest >> builderToCreateLxxMalesClass [
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
LcsDomainCollectionClassBuilderTest >> builderWithLxxMalesCreationString [
	<gtExample>
	| builder |
	builder := self builderToCreateLxxMalesClass.
	self
		assert: builder classCreationString
		equals: 
'LcsDomainCollection subclass: #LxxMales
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '.
	^ builder
]

{ #category : 'examples' }
LcsDomainCollectionClassBuilderTest >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsDomainCollectionClassBuilder new.
	self assert: builder newClassName isNil.
	self assert: builder jobSteps isEmpty.
	self assert: builder targetPackageName isNil.
	self assert: builder targetPackageTagName isNil.
	self assert: builder rootName isNil.
	self assert: builder targetSuperclassName equals: 'LcsDomainCollection'.
	^ builder
]

{ #category : 'private' }
LcsDomainCollectionClassBuilderTest >> newClassname [
	^ 'LxxMales'
]
