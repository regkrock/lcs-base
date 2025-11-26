Class {
	#name : 'LcsUnknownClassBuilderTest',
	#superclass : 'LcsCodeBuilderStepTest',
	#category : 'Lcs-SlotToolsTests-Tests',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Tests'
}

{ #category : 'private' }
LcsUnknownClassBuilderTest >> newClassName [
	^ 'LxxMale1'
]

{ #category : 'private' }
LcsUnknownClassBuilderTest >> targetSuperclassName [
	^ 'LcsDomainObject'
]

{ #category : 'tests' }
LcsUnknownClassBuilderTest >> testClassCreationString [
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

{ #category : 'as yet unclassified' }
LcsUnknownClassBuilderTest >> testInstallClass [
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
