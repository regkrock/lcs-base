Class {
	#name : #GtFormContextMenuContent,
	#superclass : #GtAbstractCoderContextMenuContent,
	#instVars : [
		'editorElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms'
}

{ #category : #accessing }
GtFormContextMenuContent >> editorElement [
	^ editorElement
]

{ #category : #accessing }
GtFormContextMenuContent >> editorElement: arg1 [
	editorElement := arg1
]

{ #category : #initialization }
GtFormContextMenuContent >> menuItemStencil [
	^ [ :arg1 :arg2 | 
	| tmp1 tmp2 tmp3 tmp4 tmp6 |
	tmp6 := BrHorizontalPane new.
	tmp6
		id: (GtCoderContextMenuItemId indexed: arg2);
		hMatchParent;
		vFitContent;
		alignCenter;
		addAptitude: self selectionAptitude;
		padding: self itemPadding;
		addChild: (self itemLabelFor: arg1 title asRopedText).
	tmp1 := tmp6
			when: BlClickEvent
			do: [ :arg3 | 
				arg3 consumed: true.
				arg1 action
					cull: self editorElement editor
					cull: self editorElement
					cull: arg3.
				self
					fireEvent: BrDropdownHideWish new;
					fireEvent: BrContextMenuHideWish new ].
	((arg1 shortcutKey respondsTo: #isEmpty) and: [ arg1 shortcutKey isEmpty not ])
		ifTrue: [ | tmp8 tmp10 tmp12 |
			tmp8 := BrHorizontalPane new.
			tmp8
				fitContent;
				geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
				border: (BlBorder paint: Color gray width: 1);
				padding: (BlInsets all: 1);
				margin: (BlInsets left: 10).
			tmp10 := BrLabel new.
			tmp10 aptitude: BrGlamorousLabelAptitude.
			tmp12 := arg1 shortcutKey asRopedText.
			tmp12
				fontName: 'Source Code Pro';
				foreground: Color gray.
			tmp10
				text: (tmp12 fontSize: 10);
				hFitContent.
			tmp8 addChild: tmp10 yourself.
			tmp1 addChild: tmp8 yourself ].
	(tmp2 := arg1 hoverAction)
		ifNotNil: [ tmp1
				when: BlMouseEnterEvent
				do: [ :arg4 | tmp2 cull: self editorElement textualCoderViewModel cull: arg4 ] ].
	(tmp3 := arg1 leaveAction)
		ifNotNil: [ tmp1
				when: BlMouseLeaveEvent
				do: [ :arg5 | tmp3 cull: self editorElement textualCoderViewModel cull: arg5 ] ].
	(tmp4 := arg1 name) ifNotNil: [ tmp1 containerName: tmp4 ].
	tmp1 ]
]
