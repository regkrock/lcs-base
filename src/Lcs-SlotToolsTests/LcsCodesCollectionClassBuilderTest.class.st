Class {
	#name : #LcsCodesCollectionClassBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #private }
LcsCodesCollectionClassBuilderTest >> newClassName [
	^ 'LxxMale1'
]

{ #category : #private }
LcsCodesCollectionClassBuilderTest >> targetSuperclassName [
	^ 'LcsValueObjects'
]

{ #category : #tests }
LcsCodesCollectionClassBuilderTest >> testClassCreationString [
	self subject: LcsCodesCollectionClassBuilder new.
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
LcsCodesCollectionClassBuilderTest >> testInstallClass [
	self subject: LcsCodesCollectionClassBuilder new.
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
