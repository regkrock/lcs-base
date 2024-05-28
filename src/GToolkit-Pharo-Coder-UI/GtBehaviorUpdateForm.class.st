Class {
	#name : #GtBehaviorUpdateForm,
	#superclass : #GtClassCreationForm,
	#instVars : [
		'superSlots'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtBehaviorUpdateForm class >> isAdditionForm [
	^ false
]

{ #category : #accessing }
GtBehaviorUpdateForm >> abstractClassVariable: arg1 [
	| tmp1 tmp2 |
	tmp1 := self createRefactoringModel.
	tmp2 := (self modelClassFrom: tmp1) classSide.
	^ RBAbstractInstanceVariableRefactoring
		model: tmp1
		variable: arg1
		class: tmp2
]

{ #category : #accessing }
GtBehaviorUpdateForm >> abstractVariable: arg1 [
	| tmp1 tmp2 |
	tmp1 := self createRefactoringModel.
	tmp2 := self modelClassFrom: tmp1.
	^ RBAbstractInstanceVariableRefactoring
		model: tmp1
		variable: arg1
		class: tmp2
]

{ #category : #accessing }
GtBehaviorUpdateForm >> addRefactoringPreviewFor: arg1 in: arg2 [
	| tmp2 tmp4 |
	tmp4 := GtRefactoringsPreviewButton new.
	tmp4
		id: GtBehaviorCoderBehaviorNameApplyPreviewId;
		margin: (BlInsets right: 5);
		refactorings: [ {arg1} ];
		cancelBlock: [  ].
	tmp2 := tmp4
			when: GtRefactoringsAppliedEvent
			do: [ :arg3 | tmp2 removeFromParent ].
	arg2 parent addChild: tmp2 after: arg2.
	tmp2 enqueueTask: [ tmp2 openPreview ] asBlTask
]

{ #category : #accessing }
GtBehaviorUpdateForm >> browseReferencesToClassVar: arg1 in: arg2 [
	arg2 phlow
		spawnObject: (GtSearchClassVariableReferenceFilter
				forClassAndSubclasses: (Smalltalk at: self rawClassName asSymbol)
				andVariable: arg1)
]

{ #category : #accessing }
GtBehaviorUpdateForm >> browseReferencesToSlot: arg1 in: arg2 [
	arg2 phlow
		spawnObject: (GtSearchInstanceSlotReferenceFilter
				forClassAndSubclasses: (Smalltalk at: self rawClassName asSymbol)
				andVariable: arg1)
]

{ #category : #accessing }
GtBehaviorUpdateForm >> classSlotsDescription [
	<magritteDescription>
	| tmp2 |
	tmp2 := super classSlotsDescription.
	tmp2
		blocListStencil: (self
				taggerStencilWithCompletion: nil
				andContextMenuBlock: [ :arg1 :arg2 :arg3 | 
					arg3 overallStatus valueOrNil isChanged
						ifTrue: [ GtCoderContextMenuContent new editorElement: arg2 ]
						ifFalse: [ self createClassSlotsContextMenuContentFor: arg1 editor: arg2 ] ]).
	^ tmp2
		blocShortcuts: [ | tmp4 tmp6 |
			tmp4 := BlShortcutWithAction new.
			tmp4
				name: 'Inspect slot';
				description: 'Inspect the slot indicated by the editor';
				combination: BlKeyCombination primaryG.
			tmp6 := BlShortcutWithAction new.
			tmp6
				name: 'Browse slot references';
				description: 'Browses references to the slot indicated by the editor';
				combination: BlKeyCombination primaryN.
			{tmp4
					action: [ :arg4 | 
						arg4 target phlow
							spawnObject: (self newClassName asString asClass classSide
									slotNamed: arg4 target text asString) ].
				tmp6
					action: [ :arg5 | 
						arg5 currentTarget phlow
							spawnObject: (GtSearchClassSlotReferenceFilter
									forClassAndSubclasses: self newClassName asString asClass classSide
									andVariable: arg5 target text asString) ]} ]
]

{ #category : #accessing }
GtBehaviorUpdateForm >> classVarsDescription [
	<magritteDescription>
	| tmp2 |
	tmp2 := super classVarsDescription.
	tmp2
		blocListStencil: (self
				taggerStencilWithCompletion: nil
				andContextMenuBlock: [ :arg1 :arg2 :arg3 | self createClassVarsContextMenuContentFor: arg1 editor: arg2 ]).
	^ tmp2
		blocShortcuts: [ | tmp4 tmp6 |
			tmp4 := BlShortcutWithAction new.
			tmp4
				name: 'Inspect variable';
				description: 'Inspect the variable indicated by the editor';
				combination: BlKeyCombination primaryG.
			tmp6 := BlShortcutWithAction new.
			tmp6
				name: 'Browse variable references';
				description: 'Browses references to the variable indicated by the editor';
				combination: BlKeyCombination primaryN.
			{tmp4
					action: [ :arg4 | 
						arg4 target phlow
							spawnObject: (self newClassName asString asClass classVarNamed: arg4 target text asString) ].
				tmp6
					action: [ :arg5 | 
						arg5 currentTarget phlow
							spawnObject: (GtSearchReferencesFilter
									literal: (self newClassName asString asClass bindingOf: arg5 target text asString)) ]} ]
]

{ #category : #accessing }
GtBehaviorUpdateForm >> commit [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtBehaviorUpdateForm >> createClassSlotsContextMenuContentFor: arg1 editor: arg2 [
	| tmp1 tmp2 tmp4 tmp6 tmp8 tmp10 tmp12 tmp14 |
	tmp1 := GtFormContextMenuContent new editorElement: arg2.
	tmp2 := OrderedCollection new.
	tmp4 := GtCoderContextMenuAction new.
	tmp4 action: [ :arg3 :arg4 | self browseReferencesToSlot: arg1 in: arg4 ].
	tmp6 := GtCoderContextMenuAction new.
	tmp6
		action: [ self
				addRefactoringPreviewFor: (self pushUpClassSlotRefactoringFor: arg1)
				in: arg2 ].
	tmp8 := GtCoderContextMenuAction new.
	tmp8
		action: [ self
				addRefactoringPreviewFor: (self pushDownClassSlotRefactoringFor: arg1)
				in: arg2 ].
	tmp10 := GtCoderContextMenuAction new.
	tmp10
		action: [ self
				addRefactoringPreviewFor: (self generateClassAccessorsFor: arg1 asClassVar: false)
				in: arg2 ].
	tmp12 := GtCoderContextMenuAction new.
	tmp12
		action: [ self addRefactoringPreviewFor: (self abstractClassVariable: arg1) in: arg2 ].
	tmp14 := GtCoderContextMenuAction new.
	tmp14
		action: [ self addRefactoringPreviewFor: (self protectClassVariable: arg1) in: arg2 ].
	tmp2
		addAll: {tmp4 title: (self createLabelTextFor: 'Browse references' description: arg1).
				tmp6 title: (self createLabelTextFor: 'Push up' description: arg1).
				tmp8 title: (self createLabelTextFor: 'Push down' description: arg1).
				tmp10 title: (self createLabelTextFor: 'Create accessors' description: arg1).
				tmp12 title: (self createLabelTextFor: 'Abstract' description: arg1).
				tmp14 title: (self createLabelTextFor: 'Protect' description: arg1)}.
	tmp1 items: tmp2.
	^ tmp1
]

{ #category : #accessing }
GtBehaviorUpdateForm >> createClassVarsContextMenuContentFor: arg1 editor: arg2 [
	| tmp1 tmp2 tmp4 tmp6 tmp8 tmp10 |
	tmp1 := GtFormContextMenuContent new editorElement: arg2.
	tmp2 := OrderedCollection new.
	tmp4 := GtCoderContextMenuAction new.
	tmp4 action: [ :arg3 :arg4 | self browseReferencesToClassVar: arg1 in: arg4 ].
	tmp6 := GtCoderContextMenuAction new.
	tmp6
		action: [ self
				addRefactoringPreviewFor: (self pushUpClassVariableRefactoringFor: arg1)
				in: arg2 ].
	tmp8 := GtCoderContextMenuAction new.
	tmp8
		action: [ self
				addRefactoringPreviewFor: (self pushDownClassVariableRefactoringFor: arg1)
				in: arg2 ].
	tmp10 := GtCoderContextMenuAction new.
	tmp10
		action: [ self
				addRefactoringPreviewFor: (self generateAccessorsFor: arg1 asClassVar: true)
				in: arg2 ].
	tmp2
		addAll: {tmp4 title: (self createLabelTextFor: 'Browse references' description: arg1).
				tmp6 title: (self createLabelTextFor: 'Push up' description: arg1).
				tmp8 title: (self createLabelTextFor: 'Push down' description: arg1).
				tmp10 title: (self createLabelTextFor: 'Create accessors' description: arg1)}.
	tmp1 items: tmp2.
	^ tmp1
]

{ #category : #accessing }
GtBehaviorUpdateForm >> createLabelTextFor: arg1 description: arg2 [
	| tmp2 |
	tmp2 := (' ' , arg2) asRopedText.
	tmp2
		glamorousCodeFont;
		foreground: Color gray.
	^ arg1 asRopedText glamorousRegularFont , tmp2 glamorousCodeTinySize
]

{ #category : #accessing }
GtBehaviorUpdateForm >> createRefactoringModel [
	^ RBClassModelFactory rbNamespace onEnvironment: RBBrowserEnvironment new
]

{ #category : #accessing }
GtBehaviorUpdateForm >> createSlotsContextMenuContentFor: arg1 editor: arg2 [
	| tmp1 tmp2 tmp4 tmp6 tmp8 tmp10 tmp12 tmp14 |
	tmp1 := GtFormContextMenuContent new editorElement: arg2.
	tmp2 := OrderedCollection new.
	tmp4 := GtCoderContextMenuAction new.
	tmp4 action: [ :arg3 :arg4 | self browseReferencesToSlot: arg1 in: arg4 ].
	tmp6 := GtCoderContextMenuAction new.
	tmp6
		action: [ self addRefactoringPreviewFor: (self pushUpSlotRefactoringFor: arg1) in: arg2 ].
	tmp8 := GtCoderContextMenuAction new.
	tmp8
		action: [ self
				addRefactoringPreviewFor: (self pushDownSlotRefactoringFor: arg1)
				in: arg2 ].
	tmp10 := GtCoderContextMenuAction new.
	tmp10
		action: [ self
				addRefactoringPreviewFor: (self generateAccessorsFor: arg1 asClassVar: false)
				in: arg2 ].
	tmp12 := GtCoderContextMenuAction new.
	tmp12
		action: [ self addRefactoringPreviewFor: (self abstractVariable: arg1) in: arg2 ].
	tmp14 := GtCoderContextMenuAction new.
	tmp14
		action: [ self addRefactoringPreviewFor: (self protectVariable: arg1) in: arg2 ].
	tmp2
		addAll: {tmp4 title: (self createLabelTextFor: 'Browse references' description: arg1).
				tmp6 title: (self createLabelTextFor: 'Push up' description: arg1).
				tmp8 title: (self createLabelTextFor: 'Push down' description: arg1).
				tmp10 title: (self createLabelTextFor: 'Create accessors' description: arg1).
				tmp12 title: (self createLabelTextFor: 'Abstract' description: arg1).
				tmp14 title: (self createLabelTextFor: 'Protect' description: arg1)}.
	tmp1 items: tmp2.
	^ tmp1
]

{ #category : #accessing }
GtBehaviorUpdateForm >> executeRefactoring: arg1 [
	[ arg1 execute ]
		on: RBRefactoringError
		do: [ :arg2 | 
			| tmp1 |
			tmp1 := arg2 messageText.
			(tmp1 endsWith: 'Browse references?') ifTrue: [ tmp1 := tmp1 allButLast: 18 ].
			self inform: tmp1 ]
]

{ #category : #accessing }
GtBehaviorUpdateForm >> generateAccessorsFor: arg1 asClassVar: arg2 [
	| tmp1 tmp2 |
	tmp1 := self createRefactoringModel.
	tmp2 := self modelClassFrom: tmp1.
	^ RBCreateAccessorsForVariableRefactoring
		model: tmp1
		variable: arg1
		class: tmp2
		classVariable: arg2
]

{ #category : #accessing }
GtBehaviorUpdateForm >> generateClassAccessorsFor: arg1 [
	| tmp1 tmp2 |
	tmp1 := self createRefactoringModel.
	tmp2 := (self modelClassFrom: tmp1) classSide.
	^ RBCreateAccessorsForVariableRefactoring
		model: tmp1
		variable: arg1
		class: tmp2
		classVariable: false
]

{ #category : #accessing }
GtBehaviorUpdateForm >> generateClassAccessorsFor: arg1 asClassVar: arg2 [
	| tmp1 tmp2 |
	tmp1 := self createRefactoringModel.
	tmp2 := (self modelClassFrom: tmp1) classSide.
	^ RBCreateAccessorsForVariableRefactoring
		model: tmp1
		variable: arg1
		class: tmp2
		classVariable: arg2
]

{ #category : #accessing }
GtBehaviorUpdateForm >> initialize [
	super initialize.
	classSlots := OrderedCollection new
]

{ #category : #accessing }
GtBehaviorUpdateForm >> modelClassFrom: arg1 [
	^ arg1 classNamed: self newClassName asString asSymbol
]

{ #category : #accessing }
GtBehaviorUpdateForm >> nameDescription [
	^ nil
]

{ #category : #accessing }
GtBehaviorUpdateForm >> protectClassVariable: arg1 [
	| tmp1 tmp2 |
	tmp1 := self createRefactoringModel.
	tmp2 := (self modelClassFrom: tmp1) classSide.
	^ RBProtectInstanceVariableRefactoring
		model: tmp1
		variable: arg1
		class: tmp2
]

{ #category : #accessing }
GtBehaviorUpdateForm >> protectVariable: arg1 [
	| tmp1 tmp2 |
	tmp1 := self createRefactoringModel.
	tmp2 := self modelClassFrom: tmp1.
	^ RBProtectInstanceVariableRefactoring
		model: tmp1
		variable: arg1
		class: tmp2
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushDownClassSlotRefactoringFor: arg1 [
	| tmp1 tmp2 |
	tmp1 := self createRefactoringModel.
	tmp2 := (self modelClassFrom: tmp1) classSide.
	^ GtPushDownInstanceVariableRefactoring
		model: tmp1
		variable: arg1
		class: tmp2
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushDownClassVariableRefactoringFor: arg1 [
	| tmp1 tmp2 |
	tmp1 := self createRefactoringModel.
	tmp2 := self modelClassFrom: tmp1.
	^ RBPushDownClassVariableRefactoring
		model: tmp1
		variable: arg1
		class: tmp2
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushDownSlotRefactoringFor: arg1 [
	| tmp1 tmp2 |
	tmp1 := self createRefactoringModel.
	tmp2 := self modelClassFrom: tmp1.
	^ GtPushDownInstanceVariableRefactoring
		model: tmp1
		variable: arg1
		class: tmp2
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushUpClassSlotRefactoringFor: arg1 [
	| tmp1 tmp2 |
	tmp1 := self createRefactoringModel.
	tmp2 := (self modelClassFrom: tmp1) classSide.
	^ RBPullUpInstanceVariableRefactoring
		model: tmp1
		variable: arg1
		class: tmp2 superclass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushUpClassVariableRefactoringFor: arg1 [
	| tmp1 tmp2 |
	tmp1 := self createRefactoringModel.
	tmp2 := self modelClassFrom: tmp1.
	^ RBPullUpClassVariableRefactoring
		model: tmp1
		variable: arg1
		class: tmp2 superclass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushUpSlotRefactoringFor: arg1 [
	| tmp1 tmp2 |
	tmp1 := self createRefactoringModel.
	tmp2 := self modelClassFrom: tmp1.
	^ RBPullUpInstanceVariableRefactoring
		model: tmp1
		variable: arg1
		class: tmp2 superclass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> slotsDescription [
	<magritteDescription>
	| tmp2 |
	tmp2 := super slotsDescription.
	tmp2
		blocListStencil: (self
				taggerStencilWithCompletion: nil
				andContextMenuBlock: [ :arg1 :arg2 :arg3 | 
					(arg3 overallStatus valueOrNil ifNotNil: #isChanged ifNil: [ true ])
						ifTrue: [ GtCoderContextMenuContent new editorElement: arg2 ]
						ifFalse: [ self createSlotsContextMenuContentFor: arg1 editor: arg2 ] ]);
		blocShortcuts: [ | tmp4 tmp6 |
				tmp4 := BlShortcutWithAction new.
				tmp4
					name: 'Inspect slot';
					description: 'Inspect the slot indicated by the editor';
					combination: BlKeyCombination primaryG.
				tmp6 := BlShortcutWithAction new.
				tmp6
					name: 'Browse slot references';
					description: 'Browses references to the slot indicated by the editor';
					combination: BlKeyCombination primaryN.
				{tmp4
						action: [ :arg4 | 
							arg4 target phlow
								spawnObject: (self newClassName asString asClass slotNamed: arg4 target text asString) ].
					tmp6
						action: [ :arg5 | 
							arg5 currentTarget phlow
								spawnObject: (GtSearchInstanceSlotReferenceFilter
										forClassAndSubclasses: self newClassName asString asClass
										andVariable: arg5 target text asString) ]} ].
	^ tmp2
		addCondition: [ :arg6 | arg6 noneSatisfy: [ :arg7 | superSlots includes: arg7 ] ]
		labelled: 'Slot names are already taken in superclass'
]

{ #category : #accessing }
GtBehaviorUpdateForm >> superSlots [
	^ superSlots
]

{ #category : #accessing }
GtBehaviorUpdateForm >> superSlots: arg1 [
	superSlots := arg1
]

{ #category : #accessing }
GtBehaviorUpdateForm >> textualCoderViewModel [
	
]
