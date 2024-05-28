Class {
	#name : #GtPharoBehaviorCoderNameElement,
	#superclass : #BrFrame,
	#instVars : [
		'behaviorCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! Views'
}

{ #category : #callbacks }
GtPharoBehaviorCoderNameElement >> actOnCoderClassChangedFor: arg1 [
	
]

{ #category : #'building - ui' }
GtPharoBehaviorCoderNameElement >> addAddOnsElementIn: arg1 [
	| tmp1 |
	tmp1 := self newAddonActionsElement.
	tmp1 coderViewModel: self coderViewModel.
	arg1 addChild: tmp1
]

{ #category : #accessing }
GtPharoBehaviorCoderNameElement >> addAdviceDropDownIn: arg1 [
	| tmp1 tmp2 |
	(tmp2 := behaviorCoderViewModel behavior)
		ifNotNil: [ tmp1 := ((GtAdvice adviceForClass: tmp2) asAsyncStream
					select: [ :arg2 | arg2 hasAdvice ]) cached.
			(tmp1 asyncSimilarCopy hasNext
				then: [ :arg3 | 
					arg3
						ifTrue: [ arg1
								enqueueTask: (BlTaskAction new
										action: [ arg1 addChild: (self buildAdviceListFor: tmp1 asyncSimilarCopy) ]) ] ])
				await ]
]

{ #category : #accessing }
GtPharoBehaviorCoderNameElement >> behavior [
	<return: #Behavior>
	^ self coderViewModel coder behavior
]

{ #category : #actions }
GtPharoBehaviorCoderNameElement >> browseClassReferences [
	| tmp1 tmp2 |
	tmp1 := behaviorCoderViewModel coder.
	(tmp2 := tmp1 theClass) ifNotNil: [ self phlow spawnObject: tmp2 gtReferences ]
]

{ #category : #'building - ui' }
GtPharoBehaviorCoderNameElement >> buildAdviceListFor: arg1 [
	| tmp1 tmp2 |
	tmp1 := GtFixItButton new.
	tmp1
		beTinySize;
		label: 'Advice'.
	tmp2 := BrGlamorousWithDropdownAptitude
			handle: [ | tmp3 |
				tmp3 := BrButton new.
				tmp3
					beTinySize;
					aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude
								- BrGlamorousButtonExteriorAptitude;
					icon: BrGlamorousVectorIcons repair.
				tmp3 ]
			content: [ | tmp4 tmp6 |
				tmp4 := BrSimpleList new.
				tmp4
					padding: (BlInsets all: 3);
					vFitContentLimited;
					hExact: 300.
				tmp6 := BrStreamItemsProvider new.
				tmp6 preloadAmount: 1.
				tmp4
					itemsProvider: (tmp6 stream: arg1 asyncSimilarCopy);
					stencil: [ :arg2 | arg2 buildElementFor: tmp1 ].
				tmp4 ].
	tmp1
		aptitude: BrGlamorousButtonWithIconAptitude + tmp2;
		icon: BrGlamorousVectorIcons repair;
		margin: (BlInsets left: 5).
	^ tmp1
]

{ #category : #'building - ui' }
GtPharoBehaviorCoderNameElement >> buildContent [
	| tmp1 tmp2 tmp4 tmp6 |
	tmp6 := BrHorizontalPane new.
	tmp6
		hMatchParent;
		alignCenterLeft.
	tmp1 := tmp6 vFitContent.
	tmp2 := self buildEditableNameLabel.
	self registerShortcutsForNameEditor: tmp2.
	tmp2 editor
		when: BrTextEditorModifiedEvent
		do: [ :arg1 | 
			arg1 text asString trimBoth asSymbol = self coderModel name
				ifTrue: [ tmp4 removeFromParent ]
				ifFalse: [ (tmp1 hasChild: tmp4) ifFalse: [ tmp1 addChild: tmp4 after: tmp2 ] ] ].
	self instalCompletionControllerOnNameEditor: tmp2.
	tmp4 := self buildRefactoringPreviewButtonForNameEditor: tmp2 inContainer: tmp1.
	tmp1 addChild: tmp2.
	self
		addAddOnsElementIn: tmp1;
		addAdviceDropDownIn: tmp1.
	^ tmp1
]

{ #category : #'building - ui' }
GtPharoBehaviorCoderNameElement >> buildEditableNameLabel [
	| tmp2 tmp4 |
	tmp2 := BrEditableLabel new.
	tmp4 := BrGlamorousEditableLabelAptitude new.
	tmp4
		defaultBackground: Color transparent;
		glamorousCodeFont;
		bold.
	tmp2
		aptitude: (tmp4 fontSize: 18)
				+ (BrGlamorousWithContextMenuAptitude
						content: [ BrGlamorousSimpleContextMenuContent new items: self contextMenuItemsForClass ]);
		inputFilter: BrTextEditorClassNameInputFilter new;
		text: self coderModel name;
		margin: (BlInsets all: 0).
	^ tmp2 id: GtBehaviorCoderBehaviorNameId
]

{ #category : #'building - ui' }
GtPharoBehaviorCoderNameElement >> buildRefactoringPreviewButtonForNameEditor: arg1 inContainer: arg2 [
	| tmp2 |
	tmp2 := GtRefactoringsPreviewButton new.
	tmp2
		id: GtBehaviorCoderBehaviorNameApplyPreviewId;
		margin: (BlInsets left: 5);
		refactorings: [ {GtRBRenameClassRefactoring
						model: (RBClassModelFactory rbNamespace
								onEnvironment: RBBrowserEnvironment new)
						rename: self coderModel theClass name
						to: arg1 text asString} ];
		cancelBlock: [ arg1 text: self coderModel theClass name ].
	^ tmp2
		when: GtRefactoringsAppliedEvent
		do: [ :arg3 | 
			| tmp3 |
			tmp3 := arg3 currentTarget.
			arg2 enqueueTask: [ arg2 removeChild: tmp3 ] asBlTask ]
]

{ #category : #accessing }
GtPharoBehaviorCoderNameElement >> coderModel [
	<return: #Behavior>
	^ self coderViewModel coder
]

{ #category : #accessing }
GtPharoBehaviorCoderNameElement >> coderViewModel [
	^ behaviorCoderViewModel
]

{ #category : #accessing }
GtPharoBehaviorCoderNameElement >> coderViewModel: arg1 [
	self unsubscribeFromCoderViewModel.
	behaviorCoderViewModel := arg1.
	self
		subscribeToCoderViewModel;
		addChild: self buildContent
]

{ #category : #'building - ui' }
GtPharoBehaviorCoderNameElement >> contextMenuItemsForClass [
	^ {'Browse references' -> [ :arg1 | self browseClassReferences ].
		'Rename' -> [ :arg2 | arg2 switchToEditor ]}
]

{ #category : #initialization }
GtPharoBehaviorCoderNameElement >> initialize [
	super initialize.
	self
		hMatchParent;
		vFitContent
]

{ #category : #accessing }
GtPharoBehaviorCoderNameElement >> instalCompletionControllerOnNameEditor: arg1 [
	(GtCompletionController on: arg1 strategy: GtClassesCompletionStrategy new)
		install showOnTextModification: false
]

{ #category : #accessing }
GtPharoBehaviorCoderNameElement >> newAddonActionsElement [
	| tmp2 |
	tmp2 := GtBehaviorCoderActionsElement new.
	tmp2 id: #actions.
	^ tmp2 yourself
]

{ #category : #shortcuts }
GtPharoBehaviorCoderNameElement >> registerShortcutsForNameEditor: arg1 [
	arg1
		whenKey: BlKeyCombination primaryN
			labelDo: [ :arg2 | self browseClassReferences ];
		whenKey: BlKeyCombination primaryB
			labelDo: [ :arg3 | self phlow spawnTool: (GtClassCoderTool observedClass: self behavior) ];
		whenKey: BlKeyCombination primaryG
			labelDo: [ :arg4 | self phlow spawnObject: self behavior ];
		whenKey: BlKeyCombination primaryR
			labelDo: [ :arg5 | arg5 currentTarget switchToEditor ];
		whenKey: BlKeyCombination primaryC
			labelDo: [ :arg6 | Clipboard clipboardText: self behavior name asString ]
]

{ #category : #subscriptions }
GtPharoBehaviorCoderNameElement >> subscribeToCoderViewModel [
	behaviorCoderViewModel weak
		when: GtCoderClassChanged
		send: #actOnCoderClassChangedFor:
		to: self
]

{ #category : #subscriptions }
GtPharoBehaviorCoderNameElement >> unsubscribeFromCoderViewModel [
	| tmp1 |
	(tmp1 := behaviorCoderViewModel) ifNotNil: [ tmp1 unsubscribe: self ]
]
