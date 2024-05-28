Class {
	#name : #GtRefactoringWithInputChangesAttribute,
	#superclass : #GtRefactoringChangesAttribute,
	#instVars : [
		'editorElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtRefactoringWithInputChangesAttribute >> doAffect: arg1 in: arg2 [
	| tmp1 |
	tmp1 := super doAffect: arg1 in: arg2.
	tmp1 editorElement: editorElement.
	^ tmp1
]

{ #category : #accessing }
GtRefactoringWithInputChangesAttribute >> editorElement [
	^ editorElement
]

{ #category : #accessing }
GtRefactoringWithInputChangesAttribute >> editorElement: arg1 [
	editorElement := arg1
]

{ #category : #accessing }
GtRefactoringWithInputChangesAttribute >> previewButtonClass [
	^ GtRefactoringsWithInputPreviewElement
]

{ #category : #accessing }
GtRefactoringWithInputChangesAttribute >> refactorings [
	^ refactoring ifNil: [ #() ] ifNotNil: [ {refactoring} ]
]
