Class {
	#name : #GtPharoPackageTagCoderElement,
	#superclass : #BlElement,
	#traits : 'TGtWithCoderToolbar',
	#classTraits : 'TGtWithCoderToolbar classTrait',
	#instVars : [
		'packageTagCoder'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! Views'
}

{ #category : #'build ui' }
GtPharoPackageTagCoderElement >> buildContentPane [
	self
		removeChildren;
		addChild: self makeLabel;
		addChild: self buildPackageTagLabel;
		addChild: self buildParentLink;
		addChild: self buildContentTabs
]

{ #category : #'build ui' }
GtPharoPackageTagCoderElement >> buildContentTabs [
	<return: #BrTabGroup>
	| tmp1 tmp3 |
	tmp3 := GtPhlowCompositeView new.
	tmp3 views: self packageTagViewItems.
	tmp1 := tmp3 asElementDo: [ :arg1 | arg1 ].
	^ tmp1
]

{ #category : #'build ui' }
GtPharoPackageTagCoderElement >> buildPackageTagLabel [
	| tmp1 tmp2 tmp3 tmp4 tmp6 tmp8 tmp10 tmp12 tmp14 |
	tmp6 := BrHorizontalPane new.
	tmp6
		hMatchParent;
		alignCenterLeft.
	tmp2 := tmp6 vFitContent.
	tmp8 := BrEditableLabel new.
	tmp10 := BrGlamorousEditableLabelAptitude new.
	tmp10
		defaultBackground: Color transparent;
		glamorousCodeFont;
		bold.
	tmp8
		aptitude: (tmp10 fontSize: 18);
		inputFilter: BrTextEditorAlphaNumericInputFilter new;
		text: packageTagCoder packageTag name.
	tmp1 := tmp8 margin: (BlInsets all: 0).
	tmp12 := GtRefactoringsPreviewButton new.
	tmp12
		margin: (BlInsets left: 5);
		visibility: BlVisibility gone;
		refactorings: [ {GtRBRenamePackageTagRefactoring
						packageName: packageTagCoder package name
						from: packageTagCoder packageTag gtTagName
						to: tmp1 text asString} ];
		cancelBlock: [ tmp1 text: packageTagCoder packageTag name ].
	tmp3 := tmp12
			when: GtRefactoringsAppliedEvent
			do: [ :arg1 | arg1 currentTarget visibility: BlVisibility hidden ].
	tmp1 editor
		when: BrTextEditorModifiedEvent
		do: [ :arg2 | 
			arg2 text asString = packageTagCoder packageTag name
				ifTrue: [ tmp3 visibility: BlVisibility gone ]
				ifFalse: [ tmp3 visibility: BlVisibility visible ] ].
	tmp14 := GtPreviewChangeButton new.
	tmp14
		icon: BrGlamorousVectorIcons remove;
		label: 'Unload';
		changeAction: [ self unloadPackageTag ].
	tmp4 := tmp14 changeStencil: [ self buildRemovePackageTagLabel ].
	tmp2
		addChild: tmp1;
		addChild: tmp3;
		addChild: tmp4;
		addChild: self toolbarElement.
	^ tmp2
]

{ #category : #'build ui' }
GtPharoPackageTagCoderElement >> buildParentLink [
	| tmp1 tmp3 tmp5 |
	tmp1 := BlElement new.
	tmp1
		layout: BlLinearLayout new beHorizontal;
		constraintsDo: [ :arg1 | 
				arg1 horizontal matchParent.
				arg1 vertical fitContent ].
	tmp3 := BrLabel new.
	tmp3
		margin: (BlInsets left: 4);
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularFont
					foreground: self theme button defaultTextColor).
	tmp1 addChild: (tmp3 text: 'In: ').
	tmp5 := BrLabel new.
	tmp5
		aptitude: (BrGlamorousButtonExteriorAptitude new borderPaint: Color transparent)
				+ BrGlamorousLabelAptitude new glamorousRegularFont;
		text: packageTagCoder package name;
		fitContent;
		beSmallSize.
	tmp1
		addChild: (tmp5
				when: BlClickEvent
				do: [ :arg2 | 
					| tmp6 tmp7 tmp8 |
					tmp6 := packageTagCoder packageCoder.
					arg2 modifiers isAlt
						ifTrue: [ tmp7 := GtCoderToReplace new coder: tmp6.
							self fireEvent: tmp7.
							tmp7 isConsumed ifFalse: [ self phlow spawnObject: tmp7 coder ] ]
						ifFalse: [ arg2 modifiers isPrimaryModifier
								ifTrue: [ | tmp10 |
									tmp8 := BlSpace new.
									tmp8
										title: tmp6 package name;
										icon: BrGlamorousVectorIcons emphasizedBrowse;
										extent: 1200 @ 600.
									tmp8 root background: Color transparent.
									tmp10 := GtPagerWrapperElement new.
									tmp10 tool: (GtCoderElement forPackage: tmp6 package).
									tmp8
										addChild: (GtPager
												createOn: (tmp10
														embellisher: (GtPagerPageEmbellisher new extension: GtPagerPageEmbellisherExtension null)));
										withHalos.
									arg2 target showSpace: tmp8 ]
								ifFalse: [ tmp7 := GtCoderToSpawn new coder: tmp6.
									self fireEvent: tmp7.
									tmp7 isConsumed ifFalse: [ self phlow spawnObject: tmp7 coder ] ] ] ]).
	^ tmp1
]

{ #category : #'build ui' }
GtPharoPackageTagCoderElement >> buildRemovePackageTagLabel [
	| tmp1 tmp2 tmp4 |
	tmp2 := packageTagCoder packageTag classes size.
	tmp1 := 'Remove package tag <1s> with <2p> class<3?:es>'
			expandMacrosWithArguments: {packageTagCoder packageTag name.
					tmp2.
					tmp2 = 1}.
	tmp4 := BrLabel new.
	tmp4
		margin: (BlInsets all: 10);
		aptitude: BrGlamorousLabelAptitude new glamorousRegularFont.
	^ tmp4 text: tmp1 asRopedText
]

{ #category : #initialization }
GtPharoPackageTagCoderElement >> initialize [
	super initialize.
	self
		initializeToolbarElement;
		padding: (BlInsets
					top: 5
					left: 6
					bottom: 5
					right: 6);
		layout: BlLinearLayout vertical;
		constraintsDo: [ :arg1 | 
				arg1 horizontal matchParent.
				arg1 vertical matchParent ]
]

{ #category : #'build ui' }
GtPharoPackageTagCoderElement >> makeLabel [
	| tmp2 tmp4 |
	tmp2 := BrLabel new.
	tmp4 := BrGlamorousLabelAptitude new glamorousRegularFontAndSize.
	tmp4 foreground: Color gray.
	tmp2
		aptitude: (tmp4 fontSize: 12);
		text: 'Package Tag'.
	^ tmp2 padding: (BlInsets left: 5)
]

{ #category : #accessing }
GtPharoPackageTagCoderElement >> packageTagCoder [
	^ packageTagCoder
]

{ #category : #accessing }
GtPharoPackageTagCoderElement >> packageTagCoder: arg1 [
	packageTagCoder := arg1.
	self buildContentPane
]

{ #category : #'build ui' }
GtPharoPackageTagCoderElement >> packageTagViewItems [
	| tmp1 tmp2 |
	tmp1 := GtPhlowViewsCollector new.
	tmp1
		fromObject: self packageTagCoder packageTag;
		pragmaName: #gtPackageTagView.
	tmp2 := GtPhlowContext new.
	tmp2 packageTagCoder: self packageTagCoder.
	tmp1 context: tmp2.
	^ tmp1 collect
]

{ #category : #actions }
GtPharoPackageTagCoderElement >> unloadPackageTag [
	| tmp1 |
	packageTagCoder unload.
	tmp1 := GtCoderToReplace new
			coder: (GtPharoPackageCoder forPackage: packageTagCoder package).
	self fireEvent: tmp1
]
