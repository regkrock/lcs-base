Class {
	#name : #LcsLoaderClassBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #private }
LcsLoaderClassBuilderTest >> newClassName [
	^ 'LxxMale1'
]

{ #category : #private }
LcsLoaderClassBuilderTest >> targetSuperclassName [
	^ 'LcsDomainObject'
]

{ #category : #tests }
LcsLoaderClassBuilderTest >> testClassCreationString [
	self subject: LcsLoaderClassBuilder new.
	self subject
		newClassName: self newClassName;
		targetPackageName: 'Lcs-Temp';
		instanceClassName: 'LxxPerson'.
	
	self
		assert: self subject classCreationString
		equals: 
'LcsObjectsLoader subclass: #LxxMale1
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '
]

{ #category : #'as yet unclassified' }
LcsLoaderClassBuilderTest >> testInstallClass [
	self subject: LcsLoaderClassBuilder new.
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
