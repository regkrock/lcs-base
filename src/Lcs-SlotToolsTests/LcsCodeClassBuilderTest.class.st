Class {
	#name : #LcsCodeClassBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #private }
LcsCodeClassBuilderTest >> newClassName [
	^ 'LxxMale1'
]

{ #category : #private }
LcsCodeClassBuilderTest >> targetSuperclassName [
	^ 'LcsCode'
]

{ #category : #tests }
LcsCodeClassBuilderTest >> testClassCreationString [
	self subject: LcsCodeClassBuilder new.
	self subject
		newClassName: self newClassName;
		targetPackageName: 'Lcs-Temp';
		targetSuperclassName: self targetSuperclassName;
		rootName: 'Male'.
	
	self assert: self subject isDefaultInstance not.
	self should: [ self subject description ] raise: Error.
	self should: [ self subject code ] raise: Error.
	self should: [ self subject label ] raise: Error.

	self
		assert: self subject classCreationString
		equals: 
'LcsCode subclass: #LxxMale1
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '
]

{ #category : #'as yet unclassified' }
LcsCodeClassBuilderTest >> testInstallClass [
	self subject: LcsCodeClassBuilder new.
	self subject
		newClassName: self newClassName;
		targetPackageName: 'Lcs-Temp';
		targetSuperclassName: self targetSuperclassName;
		rootName: 'Male'.

	self subject buildJobSteps.
	self assert: self subject jobSteps hasNoJobSteps .
	
	self should: [ self newClassName asClass ] raise: NotFound.
	self subject installCode.
	self shouldnt: [ self newClassName asClass ] raise: NotFound.
	self subject verifyCodeInstallation

]
