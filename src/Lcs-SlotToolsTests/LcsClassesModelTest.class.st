Class {
	#name : #LcsClassesModelTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsClassesModelTest >> testAddingExistingClass [
	| existingClassModel |
	self subject: LcsClassesModel new.
	self assert: self subject collection size = 0.
	existingClassModel := self subject existingClassModelFor: OrderedCollection.
	self assert: self subject collection size = 1.
	self assert: existingClassModel modelClassname = 'OrderedCollection'.
	self assert: existingClassModel modelClass = OrderedCollection.
	self assert: existingClassModel modelSuperclassName = 'SequenceableCollection'.
	self assert: existingClassModel modelSuperclass = SequenceableCollection

]

{ #category : #tests }
LcsClassesModelTest >> testAddingExistingClassTwiceWhichShouldReturnTheFirstModel [
	| existingClassModel newExistingClassModel |
	self subject: LcsClassesModel new.
	self assert: self subject collection size = 0.
	existingClassModel := self subject existingClassModelFor: OrderedCollection.
	newExistingClassModel := self subject existingClassModelFor: OrderedCollection.
	self assert: existingClassModel identicalTo: newExistingClassModel
]

{ #category : #tests }
LcsClassesModelTest >> testAddingProposedClass [
	| proposedClassModel |
	self subject: LcsClassesModel new.
	self assert: self subject collection size = 0.
	proposedClassModel := self subject proposedClassModelFor: 'LxxSample'.
	self assert: self subject collection size = 1.
	self assert: proposedClassModel modelClassname = 'LxxSample'.
	self assert: proposedClassModel modelClass isNil.
	self assert: proposedClassModel modelSuperclassName isNil.
	self assert: proposedClassModel modelSuperclass isNil

]

{ #category : #tests }
LcsClassesModelTest >> testAddingProposedClassTwiceWhichShouldReturnTheFirstModel [
	| proposedClassModel newProposedClassModel |
	self subject: LcsClassesModel new.
	self assert: self subject collection size = 0.
	proposedClassModel := self subject proposedClassModelFor: 'LxxSample'.
	newProposedClassModel := self subject proposedClassModelFor: 'LxxSample'.
	self assert: proposedClassModel identicalTo: newProposedClassModel

]

{ #category : #tests }
LcsClassesModelTest >> testCreation [
	self subject: LcsClassesModel new.
	self assert: (self subject collection isKindOf: OrderedCollection).
	self assert: self subject collection size = 0
]
