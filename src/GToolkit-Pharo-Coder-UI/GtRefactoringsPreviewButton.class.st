Class {
	#name : #GtRefactoringsPreviewButton,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'executedRefactorings',
		'cancelBlock',
		'refactoringsComputation',
		'notificationMessages',
		'errorMessages',
		'focusAction',
		'runningElement',
		'running'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtRefactoringsPreviewButton >> beMiniSize [
	self childrenDo: #beMiniSize
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> buildAcceptFor: arg1 progressContainer: arg2 [
	| tmp1 tmp2 tmp4 tmp7 |
	(running and: [ runningElement notNil ])
		ifTrue: [ arg2
				enqueueTask: [ runningElement ifNotNil: [ runningElement removeFromParent ].
					arg2 addChild: runningElement ] asBlTask ].
	tmp1 := [ :arg3 | 
		running
			ifFalse: [ running := true.
				arg3 disable.
				arg1 changesSize > 1
					ifTrue: [ tmp4 := self newProgressElement.
						arg2 addChild: tmp4 after: arg3.
						tmp4 fraction: 0.
						runningElement := tmp4 ].
				(arg1
					applyRefactoringWithProgress: [ :arg4 | 
						tmp4
							ifNotNil: [ tmp4 enqueueTask: (BlTaskAction new action: [ tmp4 fraction: arg4 ]) ] ])
					then: [ :arg5 | 
						running := false.
						self
							dispatchEvent: (GtRefactoringsAppliedEvent new refactorings: executedRefactorings).
						arg2
							enqueueTask: [ arg3
									enable;
									fireEvent: BrDropdownHideWish new ] asBlTask ]
					otherwise: [ :arg6 | 
						| tmp5 |
						running := false.
						tmp5 := arg6 asDebuggableElement
								margin: (BlInsets
										top: 5
										left: 10
										bottom: 15
										right: 10).
						runningElement := tmp5.
						arg2
							enqueueTask: [ tmp4 ifNotNil: [ tmp4 removeFromParent ].
								arg2 addChild: tmp5 ] asBlTask ] ] ].
	tmp7 := BrButton new.
	tmp7
		aptitude: BrGlamorousButtonWithIconAptitude new;
		id: GtRefactoringsPreviewAcceptId;
		icon: BrGlamorousVectorIcons accept;
		beSmallSize;
		requestFocus;
		label: 'Save';
		margin: (BlInsets
					top: 0
					left: 10
					bottom: 10
					right: 0);
		action: tmp1.
	tmp2 := tmp7 yourself.
	running ifTrue: [ tmp2 disable ].
	^ tmp2
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> buildAsyncPreviewForButton: arg1 [
	| tmp2 |
	tmp2 := BrAsyncWidget new.
	tmp2
		layout: BlLinearLayout vertical;
		constraintsDo: [ :arg2 | 
				arg2 vertical exact: 50.
				arg2 horizontal exact: self previewWidth ];
		postAction: [ :arg3 | arg3 constraintsDo: [ :arg4 | arg4 vertical fitContentLimited ] ].
	^ tmp2 stencil: [ self buildRefactoringsPreviewForButton: arg1 ]
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> buildCancelButton [
	| tmp1 tmp3 |
	tmp1 := [ self removeFromParent.
		cancelBlock value ].
	tmp3 := BrButton new.
	tmp3
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons cancel;
		beSmallSize;
		alignCenterLeft;
		label: 'Cancel';
		margin: (BlInsets left: 5);
		action: tmp1.
	^ tmp3 yourself
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> buildPreviewForButton: arg1 [
	^ self buildAsyncPreviewForButton: arg1
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> buildRefactoringsPreviewForButton: arg1 [
	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 tmp7 tmp9 tmp11 tmp13 |
	tmp5 := self executedRefactorings.
	tmp9 := GtRefactoringsElement new.
	tmp9 hExact: self previewWidth * 1.25.
	tmp1 := tmp9 vFitContentLimited.
	(tmp5 allSatisfy: [ :arg2 | arg2 isKindOf: RBRefactoring ])
		ifTrue: [ tmp1 refactorings: tmp5 ]
		ifFalse: [ tmp7 := RBCompositeRefactoryChange named: 'Changes'.
			tmp5 do: [ :arg3 | tmp7 addChange: arg3 ].
			tmp1 changes: tmp7 ].
	tmp11 := BlElement new.
	tmp11
		layout: BlLinearLayout vertical;
		when: GtPhlowObjectToSpawn
			do: [ :arg4 | arg4 target phlow spawnObject: arg4 object ].
	tmp3 := tmp11
			constraintsDo: [ :arg5 | 
				arg5 horizontal exact: self previewWidth.
				arg5 vertical fitContentLimited ].
	tmp13 := BrHorizontalPane new.
	tmp13 vFitContent.
	tmp6 := tmp13 hMatchParent.
	tmp2 := self buildAcceptFor: tmp1 progressContainer: tmp6.
	self errorMessages isEmpty
		ifTrue: [ | tmp16 |
			self notificationMessages
				do: [ :arg6 | 
					| tmp14 |
					tmp14 := arg6 cull: arg1.
					tmp14
						margin: (BlInsets
								top: 10
								left: 10
								bottom: 0
								right: 10).
					tmp3 addChild: tmp14 ].
			tmp16 := tmp1 asScalableElement.
			tmp16
				width: self previewWidth;
				fitWidth.
			tmp3
				addChild: ((tmp16 constraintsDo: [ :arg7 | arg7 vertical fitContentLimited ])
						asScrollableElement
						constraintsDo: [ :arg8 | arg8 vertical fitContentLimited ]).
			tmp6 addChild: tmp2.
			tmp3 addChild: tmp6.
			tmp2 beFocusable ]
		ifFalse: [ self errorMessages
				do: [ :arg9 | 
					| tmp17 |
					tmp17 := arg9 cull: arg1.
					tmp17 padding: (BlInsets all: 5).
					tmp3
						background: BrGlamorousColors errorBackgroundColor;
						addChild: tmp17 ] ].
	^ tmp3
]

{ #category : #accessing }
GtRefactoringsPreviewButton >> cancelBlock: arg1 [
	cancelBlock := arg1.
	cancelBlock notNil ifTrue: [ self addChild: self buildCancelButton ]
]

{ #category : #accessing }
GtRefactoringsPreviewButton >> errorMessages [
	errorMessages ifNil: [ self executeRefactorings ].
	^ errorMessages
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> executeRefactorings [
	errorMessages := OrderedCollection new.
	notificationMessages := OrderedCollection new.
	executedRefactorings := self refactorings.
	executedRefactorings
		do: [ :arg1 | 
			(arg1 isKindOf: RBRefactoring)
				ifTrue: [ arg1 model
						name: ([ arg1 gtDescription asString ]
								on: Error
								do: [ :arg2 | arg2 return: arg1 printString ]) ].
			[ [ arg1 primitiveExecute ]
				on: GtRefactoringNotification
				do: [ :arg3 | 
					notificationMessages add: arg3 messageBlock.
					arg3 pass ] ]
				on: RBRefactoringError
				do: [ :arg4 | 
					errorMessages add: arg4 messageBlock.
					arg4 return ] ]
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> executedRefactorings [
	^ executedRefactorings
		ifNil: [ self executeRefactorings.
			executedRefactorings ]
		ifNotNil: [ executedRefactorings ]
]

{ #category : #actions }
GtRefactoringsPreviewButton >> focusAcceptButton: arg1 [
	self shouldFocusAcceptButton
		ifTrue: [ arg1
				childWithId: GtRefactoringsPreviewAcceptId
				ifFound: [ :arg2 | arg2 enqueueTask: (BlTaskAction new action: [ arg2 requestFocus ]) ] ]
]

{ #category : #accessing }
GtRefactoringsPreviewButton >> focusAction [
	^ focusAction
]

{ #category : #accessing }
GtRefactoringsPreviewButton >> focusAction: arg1 [
	focusAction := arg1
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> initialize [
	| tmp1 tmp6 |
	super initialize.
	self
		fitContent;
		alignCenterLeft.
	refactoringsComputation := [ #() ].
	tmp1 := BrButton new.
	tmp1
		icon: BrGlamorousVectorIcons accept;
		id: #previewCheckButton;
		beSmallSize;
		aptitude: BrGlamorousButtonWithIconAptitude new
					+ ((BrGlamorousWithDropdownAptitude
							handle: [ | tmp3 |
								tmp3 := BrButton new.
								tmp3
									icon: BrGlamorousIcons empty;
									beSmallSize;
									aptitude: BrGlamorousButtonRectangularAptitude new + BrGlamorousButtonIconAptitude new ]
							content: [ | tmp4 |
								tmp4 := self buildPreviewForButton: tmp1.
								focusAction cull: tmp4 cull: self.
								tmp4 ]) preferredExtent: self previewWidth @ 50);
		label: 'Preview'.
	tmp6 := BlShortcutWithAction new.
	tmp6 combination: BlKeyCombination enter.
	tmp1 addShortcut: (tmp6 action: [ self openPreview ]).
	self addChild: tmp1.
	focusAction := [ :arg1 | self focusAcceptButton: arg1 ].
	running := false
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> newProgressElement [
	| tmp1 |
	tmp1 := BrProgress new.
	tmp1
		aptitude: BrGlamorousProgressBarAptitude;
		margin: (BlInsets
					top: 5
					left: 10
					bottom: 15
					right: 10);
		constraintsDo: [ :arg1 | 
				arg1 horizontal matchParent.
				arg1 vertical matchParent ].
	^ tmp1
]

{ #category : #accessing }
GtRefactoringsPreviewButton >> notificationMessages [
	notificationMessages ifNil: [ self executeRefactorings ].
	^ notificationMessages
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> openPreview [
	^ self previewButton
		fireEvent: (BrDropdownShowWish new anchor: self previewButton)
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> previewButton [
	^ self childAt: 1
]

{ #category : #initialization }
GtRefactoringsPreviewButton >> previewWidth [
	^ self isAttachedToSceneGraph
		ifTrue: [ (self topMostParent extent / 2.0) x ]
		ifFalse: [ 500 ]
]

{ #category : #accessing }
GtRefactoringsPreviewButton >> refactorings [
	^ refactoringsComputation value
]

{ #category : #accessing }
GtRefactoringsPreviewButton >> refactorings: arg1 [
	refactoringsComputation := arg1
]

{ #category : #testing }
GtRefactoringsPreviewButton >> shouldFocusAcceptButton [
	^ true
]
