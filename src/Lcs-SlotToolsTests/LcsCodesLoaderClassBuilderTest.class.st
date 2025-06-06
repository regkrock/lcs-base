Class {
	#name : #LcsCodesLoaderClassBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #private }
LcsCodesLoaderClassBuilderTest >> newClassName [
	^ 'LxxMale1'
]

{ #category : #private }
LcsCodesLoaderClassBuilderTest >> targetSuperclassName [
	^ 'LcsDomainObject'
]

{ #category : #tests }
LcsCodesLoaderClassBuilderTest >> testClassCreationString [
	self subject: LcsCodesLoaderClassBuilder new.
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

{ #category : #'as yet unclassified' }
LcsCodesLoaderClassBuilderTest >> testInstallClass [
	self subject: LcsCodesLoaderClassBuilder new.
	self subject
		newClassName: self newClassName;
		targetPackageName: 'Lcs-Temp';
		"targetSuperclassName: self targetSuperclassName;;"
		instanceClassName: 'LxxPerson'..

	self subject buildJobSteps.
	self assert: self subject jobSteps hasNoJobSteps .
	
	self should: [ self newClassName asClass ] raise: NotFound.
	self subject installCode.
	self shouldnt: [ self newClassName asClass ] raise: NotFound.
	self subject verifyCodeInstallation

]
