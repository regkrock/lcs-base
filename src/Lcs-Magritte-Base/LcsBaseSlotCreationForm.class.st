Class {
	#name : #LcsBaseSlotCreationForm,
	#superclass : #Object,
	#instVars : [
		'targetClass',
		'slotModelBuilder',
		'onReset',
		'onAccept'
	],
	#category : #'Lcs-Magritte-Base-Forms - Models'
}

{ #category : #'instance creation' }
LcsBaseSlotCreationForm class >> newOn: aTarget [
	^ self new
		initializeOn: aTarget;
		yourself
]

{ #category : #callbacks }
LcsBaseSlotCreationForm >> buildJobSteps [
	self slotModelBuilder 
			initializeJobSteps;
			buildJobSteps
]

{ #category : #configuration }
LcsBaseSlotCreationForm >> builderClass [
	^ self class builderClass
]

{ #category : #'magritte - support' }
LcsBaseSlotCreationForm >> commitSlotBuilderChangesAction [
	^ GtMagritteAction new
		beInFutureProcess;
		beWithFutureResponse;
		action: [ :aModel :aButton :aMemento :aDescription | 
			aMemento commit.
			aModel buildJobSteps ]
]

{ #category : #initialize }
LcsBaseSlotCreationForm >> executeModelBuilderJob [
	self slotModelBuilder execute.
	"self reinitialize."
]

{ #category : #'gt views' }
LcsBaseSlotCreationForm >> gtConstructionTreeFor: aView [
	<gtView>
	^ aView forward
		title: 'Steps Tree';
		priority: 98;
		object: [  self slotModelBuilder ];
		view: #gtConstructionTreeFor:
]

{ #category : #'gt views' }
LcsBaseSlotCreationForm >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView forward
		title: 'Refactoring';
		priority: 99.2;
		object: [  self slotModelBuilder ];
		view: #gtRefactoringChangeOn:
]

{ #category : #'gt views' }
LcsBaseSlotCreationForm >> gtSlotBuilderFor: aView [
	<gtView>
	^ aView forward
		title: 'Slot Builder Raw';
		priority: 99.6;
		object: [  self slotModelBuilder ];
		view: #gtRawFor:
]

{ #category : #'gt views' }
LcsBaseSlotCreationForm >> gtSlotBuilderMetaFor: aView [
	<gtView>
	^ aView forward
		title: 'Slot Builder Meta';
		priority: 99.7;
		object: [  self slotModelBuilder ];
		view: #gtMetaFor:
]

{ #category : #'gt views' }
LcsBaseSlotCreationForm >> gtUMLFor: aView [
	<gtView>
	^ aView forward
		title: 'UML';
		priority: 99;
		object: [  self slotModelBuilder ];
		view: #gtUMLFor:
]

{ #category : #initialize }
LcsBaseSlotCreationForm >> initialize [
	super initialize.
	self slotModelBuilder: self builderClass new
]

{ #category : #initialize }
LcsBaseSlotCreationForm >> initializeOn: aTarget [
	self targetClass: (aTarget isClass ifTrue: [ aTarget ] ifFalse: [ aTarget class ]).
	self slotModelBuilder targetPackageName: self targetClass package name
]

{ #category : #testing }
LcsBaseSlotCreationForm >> isSlotModelBuilderNotReified [
	^ self slotModelBuilder class = LcsCodeBuilderStep
]

{ #category : #'magritte - support' }
LcsBaseSlotCreationForm >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		label: 'Update Builder';
		action: self commitSlotBuilderChangesAction;
		beEnabledOnValidOverallStatus
]

{ #category : #'magritte - support' }
LcsBaseSlotCreationForm >> magritteBuildAction [
	<magritteActionDescription>
	"self isSlotModelBuilderNotReified ifTrue: [ ^ nil ]."
	^ MAActionDescription new
		priority: 30;
		label: 'Build';
		isLabelVisible: false;
		beToolbarAction;
		blocIcon: BrGlamorousVectorIcons play;
		action: (
			GtMagritteAction new
				beInUIProcess;
				action: [ :aModel :aButton :aMemento :aDescription | 
					aModel executeModelBuilderJob.
					aButton phlow fireViewUpdateWish ]);
		onOverallStatusChanged: (
			GtMagritteBasicAction new
				action: [ :aStatus :aButton :aMemento :aDescription |
							aStatus isChanged
								ifTrue: [ aDescription enabled: false ]
								ifFalse: [ aDescription enabled: aStatus isValidAndInactive ] ])
]

{ #category : #'magritte - support' }
LcsBaseSlotCreationForm >> magritteCancelAction [
	<magritteActionDescription>
	^ super magritteCancelAction
		onSuccessCallback: (GtMagritteCallback new
				action: [ :aModel :aButton :aMemento :aDescription | 
					[ onReset ifNotNil: [ onReset value ] ] 
						on: Error do: #debug ]);
		beAlwaysEnabled
]

{ #category : #'magritte - support' }
LcsBaseSlotCreationForm >> magritteUndoBuildAction [
	<magritteActionDescription>
	"self isSlotModelBuilderNotReified ifTrue: [ ^ nil ]."
	^ MAActionDescription new
		priority: 31;
		label: 'Undo Build';
		isLabelVisible: false;
		beToolbarAction;
		blocIcon: BrGlamorousVectorIcons left;
		action: (
			GtMagritteAction new
				beInUIProcess;
				action: [ :aModel :aButton :aMemento :aDescription | 
					aModel uninstallModelBuilderJob.
					"aButton phlow fireViewUpdateWish" ]);
		onOverallStatusChanged: (
			GtMagritteBasicAction new
				action: [ :aStatus :aButton :aMemento :aDescription |
							aStatus isChanged
								ifTrue: [ aDescription enabled: false ]
								ifFalse: [ aDescription enabled: aStatus isValidAndInactive ] ])
]

{ #category : #accessing }
LcsBaseSlotCreationForm >> onAccept [

	^ onAccept
]

{ #category : #accessing }
LcsBaseSlotCreationForm >> onAccept: aBlock [

	onAccept := aBlock
]

{ #category : #accessing }
LcsBaseSlotCreationForm >> onReset [
	^ onReset
]

{ #category : #accessing }
LcsBaseSlotCreationForm >> onReset: aBlock [
	onReset := aBlock
]

{ #category : #initialize }
LcsBaseSlotCreationForm >> reinitialize [
	| target |
	target := self targetClass.
	self initialize.
	self initializeOn: target
]

{ #category : #accessing }
LcsBaseSlotCreationForm >> slotModelBuilder [
	^ slotModelBuilder
]

{ #category : #accessing }
LcsBaseSlotCreationForm >> slotModelBuilder: anObject [
	slotModelBuilder := anObject
]

{ #category : #'magritte - support' }
LcsBaseSlotCreationForm >> taggerStencilWithCompletion: aCompletionStrategy andContextMenuBlock: aContextMenuBlock [
	^ [ :aMemento :aDescription :aForm | 
	| aTagger aTaggerAptitude |
	aTagger := BrTagger new hFitContentLimited.
	aForm hMatchParent.
	aTagger
		padding: (BlInsets top: -2 bottom: 5);
		clipChildren: false;
		aptitude: (aTaggerAptitude := GtCreationEditableTaggerAptitude new
					margin: (BlInsets
							top: 0
							bottom: 3
							left: 0
							right: 5);
					tagLabel: [ :aTag | 
						| aLabel |
						aLabel := BrEditor new fitContent
								text: (aDescription displayStringFor: aTag name);
								aptitude: (BrGlamorousEditableLabelAptitude new glamorousFormEditorCodeFontAndSize
										defaultForeground: Color black);
								addShortcut: (BlShortcutWithAction new
										name: 'Move to previous form item';
										description: 'Moves to the previous form item. If none is found, we cycle back to the last.';
										combination: BlKeyCombination shiftTab;
										action: [ :anEvent | 
											BlFocusFinder new
												direction: BlFocusSearchDirectionBackward new;
												root: aForm;
												referenceElement: anEvent currentTarget;
												nextFocusDo: #requestFocus ifNone: [  ] ]);
								addShortcut: (BlShortcutWithAction new
										name: 'Move to next form item';
										description: 'Moves to the next form item. If none is found, we cycle back to the first.';
										combination: (BlKeyCombination tab or: BlKeyCombination enter);
										action: [ :anEvent | 
											BlFocusFinder new
												direction: BlFocusSearchDirectionForward new;
												root: aForm;
												referenceElement: anEvent currentTarget;
												nextFocusDo: #requestFocus ifNone: [  ] ]).

						aDescription blocShortcuts
							ifNotNil: [ :aBlockReturningCollection | 
								aBlockReturningCollection value
									do: [ :aShortcut | aLabel addShortcut: aShortcut ] ].

						aCompletionStrategy
							ifNotNil: [ (GtCompletionController on: aLabel strategy: aCompletionStrategy) install ].
						aContextMenuBlock
							ifNotNil: [ aLabel
									addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
											content: [ aContextMenuBlock
													value: aTag name
													value: aLabel
													value: aMemento ]) ].
						aLabel ]).
	aTagger
		when: BrTaggerAddTagRequest
		do: [ :aRequest | 
			| aValue |
			aRequest currentTarget addTag: aRequest tag.
			aValue := aTagger tags collect: #name thenSelect: #isNotEmpty.

			GtMagritteBuilderUtility
				write: aValue asArray
				using: aDescription
				memento: aMemento
				element: aTagger ].
	aTagger
		when: BrTaggerRenameTagRequest
		do: [ :aRequest | 
			(aRequest tag name = aRequest newName) not
				ifTrue: [ | aValue |
					aRequest currentTarget renameTag: aRequest tag to: aRequest newName.
					aValue := aTagger tags collect: #name.

					GtMagritteBuilderUtility
						write: aValue asArray
						using: aDescription
						memento: aMemento
						element: aTagger ] ].
	aTagger
		when: BrTaggerRemoveTagRequest
		do: [ :aRequest | 
			| aValue |
			aRequest currentTarget removeTag: aRequest tag.
			aValue := aTagger tags collect: #name.

			GtMagritteBuilderUtility
				write: aValue asArray
				using: aDescription
				memento: aMemento
				element: aTagger ].
	aTagger
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :theTagger :aSink | 
					| theValues |
					(theTagger tags isEmpty or: [ aSink value isChanged not ])
						ifTrue: [ theValues := aSink value currentValue.
							theTagger namedTags: theValues ] ].
			(aMemento readObservableValueUsing: aDescription) observe: anElementSink ].
	GtMagritteBuilderUtility
		newValidationContainerWith: aTagger
		memento: aMemento
		using: aDescription ]

]

{ #category : #accessing }
LcsBaseSlotCreationForm >> targetClass [
	^ targetClass
]

{ #category : #accessing }
LcsBaseSlotCreationForm >> targetClass: anObject [
	targetClass := anObject
]

{ #category : #magritte }
LcsBaseSlotCreationForm >> targetClassDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Install Slot In Domain Class';
		priority: 1;
		accessor: #'targetClass';
		beReadOnly;
		blocShortcuts: [ 
			{BlShortcutWithAction new
				name: 'Browse class';
				description: 'Browses the class indicated by the editor';
				combination: BlKeyCombination primaryB;
				action: [ :anEvent | anEvent target phlow spawnTool: (GtClassCoderTool forClass: anEvent target text asString asClass) ].
			BlShortcutWithAction new
				name: 'Inspect class';
				description: 'Inspects the class indicated by the editor';
				combination: BlKeyCombination primaryG;
				action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass ].
			BlShortcutWithAction new
				name: 'Browse class references';
				description: 'Browses references to the class indicated by the editor';
				combination: BlKeyCombination primaryN;
				action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass gtReferences ]} ];
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
	"^ (self magritteDescriptionFor: #targetClass) ifNotNil: [ :description |
		description
			priority: 2;
			yourself ]"
]

{ #category : #private }
LcsBaseSlotCreationForm >> umlModel [
	^ self slotModelBuilder umlModel
]

{ #category : #private }
LcsBaseSlotCreationForm >> umlMondrianModel [
	^ self slotModelBuilder umlMondrianModel
]

{ #category : #initialize }
LcsBaseSlotCreationForm >> uninstallModelBuilderJob [
	self slotModelBuilder uninstall.
	"self reinitialize."
]
