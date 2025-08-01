Class {
	#name : #LcsGtCreationForm,
	#superclass : #Object,
	#instVars : [
		'onAccept',
		'packageAndTagName',
		'onElementCreated',
		'onReset',
		'slotClassName',
		'slotName'
	],
	#category : #'Lcs-Magritte-Base-Forms - Models'
}

{ #category : #accessing }
LcsGtCreationForm class >> componentName [
	^ self subclassResponsibility
]

{ #category : #accessing }
LcsGtCreationForm class >> isAdditionForm [
	^ true
]

{ #category : #accessing }
LcsGtCreationForm class >> priority [
	^ self subclassResponsibility
]

{ #category : #converting }
LcsGtCreationForm >> asElement [
	| viewModel |
	viewModel := self asGtMagritteViewModel focusFirstInputField.
	self onElementCreated
		ifNotNil: [ :aCallback | viewModel onElementCreated: aCallback ].
	^ viewModel asElement
]

{ #category : #callbacks }
LcsGtCreationForm >> commit [
	^ self subclassResponsibility
]

{ #category : #callbacks }
LcsGtCreationForm >> commitPackage [
	| aPackage |
	(RPackageOrganizer default includesPackageNamed: packageAndTagName packageName)
		ifTrue: [ aPackage := RPackageOrganizer default
					packageNamed: packageAndTagName packageName.
			^ packageAndTagName tagName
				ifEmpty: [ aPackage ]
				ifNotEmpty: [ :aTagName | aPackage classTagNamed: aTagName ifAbsent: [ aPackage addClassTag: aTagName ] ] ]
		ifFalse: [ aPackage := (RPackage named: packageAndTagName packageName)
					register.
			^ packageAndTagName tagName
				ifEmpty: [ aPackage ]
				ifNotEmpty: [ :aTagName | aPackage addClassTag: aTagName ] ]
]

{ #category : #accessing }
LcsGtCreationForm >> ghostTextFor: aString [
	^ BrGhostTextAttribute
		for: (aString asRopedText glamorousFormEditorCodeFontAndSize foreground: Color lightGray)
]

{ #category : #accessing }
LcsGtCreationForm >> hasPackageAndTag [
	^ true
]

{ #category : #initialization }
LcsGtCreationForm >> initialize [
	packageAndTagName := GtPackageAndTagName new
]

{ #category : #magritte }
LcsGtCreationForm >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		label: 'Create';
		onSuccessCallback: (GtMagritteCallback new
				action: [ :aModel :aButton :aMemento :aDescription | 
					[ | aClass |
					aClass := self commit.
					onAccept ifNotNil: [ onAccept value: aClass ] ] 
						on: Error do: #debug ]);
		beEnabledOnValidOverallStatus
]

{ #category : #magritte }
LcsGtCreationForm >> magritteCancelAction [
	<magritteActionDescription>
	^ super magritteCancelAction
		onSuccessCallback: (GtMagritteCallback new
				action: [ :aModel :aButton :aMemento :aDescription | 
					[ onReset ifNotNil: [ onReset value ] ] 
						on: Error do: #debug ]);
		beAlwaysEnabled
]

{ #category : #accessing }
LcsGtCreationForm >> onAccept [

	^ onAccept
]

{ #category : #accessing }
LcsGtCreationForm >> onAccept: aBlock [

	onAccept := aBlock
]

{ #category : #accessing }
LcsGtCreationForm >> onElementCreated [
	^ onElementCreated
]

{ #category : #accessing }
LcsGtCreationForm >> onElementCreated: aBlock [
	onElementCreated := aBlock
]

{ #category : #accessing }
LcsGtCreationForm >> onReset [
	^ onReset
]

{ #category : #accessing }
LcsGtCreationForm >> onReset: aBlock [
	onReset := aBlock
]

{ #category : #accessing }
LcsGtCreationForm >> packageAndTagDescription [
	"<magritteDescription>"
	^ GtPackageAndTagDescription new
		label: 'Package';
		priority: 5;
		accessor: #packageAndTagName;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]

{ #category : #accessing }
LcsGtCreationForm >> packageAndTagName [

	^ packageAndTagName
]

{ #category : #accessing }
LcsGtCreationForm >> packageAndTagName: anObject [

	packageAndTagName := anObject
]

{ #category : #accessing }
LcsGtCreationForm >> selectInNavigationModel: aNavigationModel anInstance: anInstance [
	aNavigationModel selectPackage: anInstance package.

	anInstance tags
		ifNotEmpty: [ aNavigationModel
				selectPackageTag: (anInstance package classTagNamed: anInstance tags first) ].

	aNavigationModel selectClass: anInstance
]

{ #category : #accessing }
LcsGtCreationForm >> slotClassName [
	^ slotClassName
]

{ #category : #accessing }
LcsGtCreationForm >> slotClassName: anObject [
	slotClassName := anObject
]

{ #category : #accessing }
LcsGtCreationForm >> slotName [
	^ slotName
]

{ #category : #accessing }
LcsGtCreationForm >> slotName: anObject [
	slotName := anObject
]

{ #category : #accessing }
LcsGtCreationForm >> taggerStencilWithCompletion: aCompletionStrategy andContextMenuBlock: aContextMenuBlock [
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
LcsGtCreationForm >> toolFor: anInstance [
	^ GtClassCoderTool forClass: anInstance
]
