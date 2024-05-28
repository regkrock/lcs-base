Class {
	#name : #GtRefactoringsWithInputPreviewElement,
	#superclass : #GtRefactoringsPreviewButton,
	#instVars : [
		'editorElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement >> buildPreviewForButton: arg1 [
	| tmp1 |
	tmp1 := BrVerticalPane new.
	tmp1 fitContent.
	editorElement
		ifNotNil: [ editorElement removeFromParent.
			tmp1 addChild: editorElement ].
	self buildRefactoringsFor: arg1 in: tmp1.
	^ tmp1
]

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement >> buildRefactoringsFor: arg1 in: arg2 [
	self refactorings notEmpty
		ifTrue: [ arg2 addChild: (self buildAsyncPreviewForButton: arg1) as: #preview ]
]

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement >> editorElement [
	^ editorElement
]

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement >> editorElement: arg1 [
	editorElement := arg1
]

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement >> refactorings: arg1 [
	| tmp1 |
	super refactorings: arg1.
	executedRefactorings := nil.
	editorElement ifNil: [ ^ self ].
	tmp1 := editorElement parent.
	tmp1 ifNil: [ ^ self ].
	tmp1 removeChildNamed: #preview.
	self buildRefactoringsFor: (self childNamed: #previewCheckButton) in: tmp1
]

{ #category : #testing }
GtRefactoringsWithInputPreviewElement >> shouldFocusAcceptButton [
	^ false
]
