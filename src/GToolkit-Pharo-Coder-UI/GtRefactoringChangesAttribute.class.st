Class {
	#name : #GtRefactoringChangesAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'refactoring',
		'completionAction',
		'cancelAction',
		'showWhenCreated',
		'focusAction'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #'private - attributes' }
GtRefactoringChangesAttribute >> cancelAction: arg1 [
	cancelAction := arg1
]

{ #category : #initialization }
GtRefactoringChangesAttribute >> completionAction: arg1 [
	completionAction := arg1
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> doAffect: arg1 in: arg2 [
	| tmp1 |
	tmp1 := self previewButtonClass new.
	tmp1 vMatchParent.
	focusAction ifNotNil: [ tmp1 focusAction: focusAction ].
	tmp1
		refactorings: [ self refactorings ];
		padding: (BlInsets
					top: 1
					right: 4
					bottom: 0
					left: 4);
		cancelBlock: cancelAction;
		beMiniSize;
		when: GtRefactoringsAppliedEvent
			do: [ :arg3 | completionAction notNil ifTrue: [ completionAction cull: arg3 ] ].
	showWhenCreated ifTrue: [ tmp1 enqueueTask: [ tmp1 openPreview ] asBlTask ].
	^ tmp1
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> focusAction [
	^ focusAction
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> focusAction: arg1 [
	focusAction := arg1
]

{ #category : #initialization }
GtRefactoringChangesAttribute >> initialize [
	super initialize.
	self
		beAppend;
		beNotOverwritableByStyler.
	showWhenCreated := false
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> previewButtonClass [
	^ GtRefactoringsPreviewButton
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> refactoring [
	^ refactoring
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> refactoring: arg1 [
	refactoring := arg1
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> refactorings [
	^ {refactoring}
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> showWhenCreated [
	^ showWhenCreated
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> showWhenCreated: arg1 [
	showWhenCreated := arg1
]
