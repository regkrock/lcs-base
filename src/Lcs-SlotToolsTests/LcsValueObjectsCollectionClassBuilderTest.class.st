Class {
	#name : #LcsValueObjectsCollectionClassBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #private }
LcsValueObjectsCollectionClassBuilderTest >> newClassName [
	^ 'LxxMale1'
]

{ #category : #private }
LcsValueObjectsCollectionClassBuilderTest >> targetSuperclassName [
	^ 'LcsValueObjects'
]

{ #category : #tests }
LcsValueObjectsCollectionClassBuilderTest >> testClassCreationString [
	self subject: LcsValueObjectsCollectionClassBuilder new.
	self subject
		newClassName: self newClassName asEnglishPlural;
		targetPackageName: 'Lcs-Temp';
		targetSuperclassName: self targetSuperclassName;
		rootName: 'Male'.

			self
		assert: self subject classCreationString
		equals: 
'LcsValueObjects subclass: #LxxMale1s
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '
]

{ #category : #'as yet unclassified' }
LcsValueObjectsCollectionClassBuilderTest >> testInstallClass [
	self removeClassName: 'LxxMale1s'.
	self subject: LcsValueObjectsCollectionClassBuilder new.
	self subject
		newClassName: self newClassName asEnglishPlural;
		targetPackageName: 'Lcs-Temp';
		targetSuperclassName: self targetSuperclassName;
		rootName: 'Male'.

	self subject buildJobSteps.
	self assert: self subject jobSteps hasNoJobSteps .
	
	self should: [ self newClassName asEnglishPlural asClass ] raise: NotFound.
	self subject installCode.
	self shouldnt: [ self newClassName asEnglishPlural asClass ] raise: NotFound.
	self subject verifyCodeInstallation

]
