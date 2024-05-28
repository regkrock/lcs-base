Class {
	#name : #GtCreationEditableTaggerAptitude,
	#superclass : #BrGlamorousTaggerEditableAptitude,
	#instVars : [
		'addButton'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Tagger'
}

{ #category : #private }
GtCreationEditableTaggerAptitude >> addTagCreatorElement [
	self
		addTagElement: self newTagCreatorElement
		withSeparatorAt: tagElements size + 1
]

{ #category : #accessing }
GtCreationEditableTaggerAptitude >> deletionShortcutUsing: arg1 forLabel: arg2 [
	| tmp2 |
	tmp2 := BlShortcutWithAction new.
	tmp2
		name: 'Delete tag';
		description: 'Delete tag if the editor is already empty.';
		combination: BlKeyCombination backspace.
	^ tmp2
		action: [ :arg3 | arg2 text ifEmpty: [ self requestRemoveTag: arg1 from: arg2 ] ]
]

{ #category : #accessing }
GtCreationEditableTaggerAptitude >> margin: arg1 [
	margin := arg1.
	tags replaceChild: addButton with: (addButton := self newAddTagButton)
]

{ #category : #'private - instance creation' }
GtCreationEditableTaggerAptitude >> newAddTagButton [
	| tmp2 tmp4 |
	tmp2 := BrButton new beFocusable.
	tmp2
		aptitude: BrGlamorousButtonWithIconAptitude new;
		icon: BrGlamorousVectorIcons add;
		label: 'Add';
		beSmallSize;
		hExact: 20;
		margin: margin;
		constraintsDo: [ :arg1 | arg1 flow vertical alignCenter ];
		action: [ :arg2 | self addTagCreatorElement ];
		when: BlFocusInEvent do: [ :arg3 | self addTagCreatorElement ].
	tmp4 := BlShortcutWithAction new.
	tmp4 combination: BlKeyCombination shiftTab.
	^ addButton := tmp2
			addShortcut: (tmp4
					action: [ :arg4 | 
						| tmp6 |
						tmp6 := BlFocusFinder new.
						tmp6
							direction: BlFocusSearchDirectionBackward new;
							root: tags parent parent parent;
							referenceElement: arg4 currentTarget;
							nextFocusDo: #requestFocus ifNone: [  ] ])
]

{ #category : #'private - instance creation' }
GtCreationEditableTaggerAptitude >> newTagCreatorElement [
	| tmp2 tmp3 tmp5 tmp7 tmp11 tmp15 |
	tmp3 := false.
	tmp5 := (tagLabelStencil tag: (BrTaggerTag named: '')) asElement.
	tmp5
		when: BlFocusInEvent do: [ :arg1 | tmp2 selecter all select ];
		when: BlFocusOutEvent do: [ :arg2 | tmp2 deselecter all deselect ];
		padding: (BlInsets
					top: 5
					left: 6
					bottom: 5
					right: 6);
		margin: margin;
		constraintsDo: [ :arg3 | arg3 flow vertical alignCenter ].
	tmp7 := BlShortcutWithAction new.
	tmp7
		name: 'Move to previous form item';
		description: 'Moves to the previous form item. If none is found, we cycle back to the last.';
		combination: BlKeyCombination shiftTab.
	tmp5
		addShortcut: (tmp7
				action: [ :arg4 | 
					| tmp9 |
					tmp9 := BlFocusFinder new.
					tmp9
						direction: BlFocusSearchDirectionBackward new;
						root: tags parent parent parent;
						referenceElement: arg4 currentTarget;
						nextFocusDo: #requestFocus ifNone: [  ].
					tmp2 text
						ifEmpty: [ self removeTagCreatorElement: tmp2 withSeparatorAt: tagElements size + 1 ]
						ifNotEmpty: [ self requestAddTag: (BrTaggerTag named: tmp2 text asString) from: tmp2 ] ]).
	tmp11 := BlShortcutWithAction new.
	tmp11
		name: 'Move to next form item';
		description: 'Moves to the next form item. If none is found, we cycle back to the first.';
		combination: BlKeyCombination tab.
	tmp2 := tmp5
			addShortcut: (tmp11
					action: [ :arg5 | 
						arg5 currentTarget
							fireEvent: (BrEditorAcceptWish new text: arg5 currentTarget text).
						arg5 currentTarget text
							ifEmpty: [ | tmp13 |
								tmp13 := BlFocusFinder new.
								tmp13
									direction: BlFocusSearchDirectionForward new;
									root: tags parent parent parent;
									referenceElement: addButton;
									nextFocusDo: #requestFocus ifNone: [  ].
								tmp2 text
									ifEmpty: [ self removeTagCreatorElement: tmp2 withSeparatorAt: tagElements size + 1 ]
									ifNotEmpty: [ self requestAddTag: (BrTaggerTag named: tmp2 text asString) from: tmp2 ] ]
							ifNotEmpty: [ self addTagCreatorElement ] ]).
	tmp2 editor
		when: BrTextEditorModifiedEvent
		do: [ :arg6 | 
			tmp3
				ifFalse: [ tmp3 := true.
					self requestAddTag: (BrTaggerTag named: arg6 text asString) from: tmp2 ] ].
	tmp15 := tmp2 navigator.
	tmp15
		moveTo: 0;
		apply.
	^ tmp2 requestFocus
]

{ #category : #accessing }
GtCreationEditableTaggerAptitude >> newTagElementFor: arg1 [
	| tmp1 tmp3 |
	tmp1 := (tagLabelStencil tag: arg1) asElement margin: margin.
	tmp1
		when: BlFocusInEvent do: [ :arg2 | tmp1 selecter all select ];
		when: BlFocusOutEvent
			do: [ :arg3 | 
					tmp1 deselecter all deselect.
					tmp1 text ifEmpty: [ self requestRemoveTag: arg1 from: tmp1 ] ].
	tmp1 editor
		when: BrTextEditorModifiedEvent
		do: [ :arg4 | 
			arg4 text
				ifEmpty: [ tmp1 addShortcut: (tmp3 := self deletionShortcutUsing: arg1 forLabel: tmp1) ]
				ifNotEmpty: [ tmp3
						ifNotNil: [ tmp1 removeShortcut: tmp3.
							tmp3 := nil ] ].
			self
				requestRenameTag: arg1
				to: arg4 text asString
				from: tmp1 ].
	^ tmp1
]

{ #category : #accessing }
GtCreationEditableTaggerAptitude >> onTagAdded: arg1 at: arg2 [
	| tmp1 |
	tmp1 := self newTagElementFor: arg1.
	self
		assignTag: arg1 toElement: tmp1;
		addTagElement: tmp1 withSeparatorAt: arg2.
	tagElements add: tmp1 beforeIndex: arg2.
	shouldGiveFocusToNewTag ifTrue: [ tmp1 requestFocus deselecter all deselect ]
]

{ #category : #accessing }
GtCreationEditableTaggerAptitude >> onTagRemoved: arg1 at: arg2 [
	self
		tagElementFor: arg1
		ifFound: [ :arg3 | 
			tagElements remove: arg3.
			self removeTagElement: arg3 withSeparatorAt: arg2 ]
]
