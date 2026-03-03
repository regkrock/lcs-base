Class {
	#name : 'LcsUmlModelExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsUmlModelExamples >> newUmlModel [
	<gtExample>
	| model |
	model := LcsUmlModel new.
	self assert: (model collection isKindOf: OrderedCollection).
	self assert: model collection size = 0.
	^ model
]

{ #category : 'tests' }
LcsUmlModelExamples >> umlModelAfterAtteptingToAddOrderedCollectionASecondTime [
	<gtExample>
	| existingClassModel umlModel orderedCollectionModel |
	umlModel := self umlModelWithOrderedCollectionAdded.
	orderedCollectionModel := umlModel collection first.
	existingClassModel := umlModel addClassModelForExisting: OrderedCollection.
	self assert: orderedCollectionModel identicalTo: existingClassModel.
	^ umlModel
]

{ #category : 'tests' }
LcsUmlModelExamples >> umlModelWithOrderedCollectionAdded [
	<gtExample>
	| umlModel existingClassModel |
	umlModel := self newUmlModel.
	existingClassModel := umlModel addClassModelForExisting: OrderedCollection.
	self assert: umlModel collection size = 1.
	self assert: existingClassModel modelClassname = 'OrderedCollection'.
	self assert: existingClassModel modelClass = OrderedCollection.
	self assert: existingClassModel modelSuperclassName = 'SequenceableCollection'.
	self assert: existingClassModel modelSuperclass = SequenceableCollection.
	^ umlModel
]

{ #category : 'tests' }
LcsUmlModelExamples >> umlModelWithOrderedCollectionAndAProposedClass [
	<gtExample>
	| proposedClassModel umlModel |
	umlModel := self umlModelWithOrderedCollectionAdded.
	proposedClassModel := umlModel proposedClassModelFor: 'LxxSample'.
	self assert: umlModel collection size = 2.
	self assert: proposedClassModel modelClassname = 'LxxSample'.
	self assert: proposedClassModel modelClass isNil.
	self assert: proposedClassModel modelSuperclassName isNil.
	self assert: proposedClassModel modelSuperclass isNil.
	^ umlModel
]
