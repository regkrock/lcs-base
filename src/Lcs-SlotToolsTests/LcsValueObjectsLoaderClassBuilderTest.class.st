Class {
	#name : 'LcsValueObjectsLoaderClassBuilderTest',
	#superclass : 'LcsCodeBuilderStepTest',
	#category : 'Lcs-SlotToolsTests-Tests',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Tests'
}

{ #category : 'private' }
LcsValueObjectsLoaderClassBuilderTest >> newClassName [
	^ 'LxxMale1'
]

{ #category : 'private' }
LcsValueObjectsLoaderClassBuilderTest >> targetSuperclassName [
	^ 'LcsDomainObject'
]

{ #category : 'tests' }
LcsValueObjectsLoaderClassBuilderTest >> testClassCreationString [
	self subject: LcsValueObjectsLoaderClassBuilder new.
	self subject
		newClassName: self newClassName;
		targetPackageName: 'Lcs-Temp';
		instanceClassName: 'LxxPerson'.
	
	self
		assert: self subject classCreationString
		equals: 
'LcsValueObjectsLoader subclass: #LxxMale1
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '
]

{ #category : 'as yet unclassified' }
LcsValueObjectsLoaderClassBuilderTest >> testInstallClass [
	self subject: LcsValueObjectsLoaderClassBuilder new.
	self subject
		newClassName: self newClassName;
		targetPackageName: 'Lcs-Temp';
		"targetSuperclassName: self targetSuperclassName;;"
		instanceClassName: 'LxxPerson'.

	self subject buildJobSteps.
	self assert: self subject jobSteps hasNoJobSteps .
	
	self should: [ self newClassName asClass ] raise: NotFound.
	self subject installCode.
	self shouldnt: [ self newClassName asClass ] raise: NotFound.
	self subject verifyCodeInstallation

]
