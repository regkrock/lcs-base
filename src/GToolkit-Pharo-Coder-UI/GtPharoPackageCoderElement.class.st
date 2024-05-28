Class {
	#name : #GtPharoPackageCoderElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtPharoWithPackageCoderViewModel + TGtWithCoderToolbar',
	#classTraits : 'TGtPharoWithPackageCoderViewModel classTrait + TGtWithCoderToolbar classTrait',
	#instVars : [
		'packageCoder'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Views'
}

{ #category : #'private - ui' }
GtPharoPackageCoderElement >> buildContentPane [
	self
		addChildren: {self makeLabel.
				self buildPackageLabel.
				self buildParentLink.
				self buildContentTabs}
]

{ #category : #'private - ui' }
GtPharoPackageCoderElement >> buildContentTabs [
	<return: #BrTabGroup>
	| tmp1 tmp3 |
	tmp3 := GtPhlowCompositeView new.
	tmp3 views: self packageViewItems.
	tmp1 := tmp3 asElementDo: [ :arg1 | arg1 ].
	^ tmp1
]

{ #category : #'private - ui' }
GtPharoPackageCoderElement >> buildPackageLabel [
	| tmp1 tmp2 tmp3 tmp4 tmp6 tmp8 tmp10 tmp12 tmp14 |
	tmp6 := BrHorizontalPane new.
	tmp6
		hMatchParent;
		alignCenterLeft.
	tmp2 := tmp6 vFitContent.
	tmp8 := BrEditableLabel new.
	tmp8 id: GtPackageCoderPackageNameId.
	tmp10 := BrGlamorousEditableLabelAptitude new.
	tmp10
		defaultBackground: Color transparent;
		glamorousCodeFont;
		bold.
	tmp8
		aptitude: (tmp10 fontSize: 18);
		text: packageCoder package name;
		margin: (BlInsets all: 0);
		whenKey: BlKeyCombination primaryB
			labelDo: [ :arg1 | self phlow spawnTool: (GtPackageCoderTool package: self package) ];
		whenKey: BlKeyCombination primaryG
			labelDo: [ :arg2 | self phlow spawnObject: self package ];
		whenKey: BlKeyCombination primaryR
			labelDo: [ :arg3 | arg3 currentTarget switchToEditor ].
	tmp1 := tmp8
			whenKey: BlKeyCombination primaryC
			labelDo: [ :arg4 | Clipboard clipboardText: self package name asString ].
	tmp12 := GtRefactoringsPreviewButton new.
	tmp12
		margin: (BlInsets left: 5);
		visibility: BlVisibility gone;
		refactorings: [ {GtRBRenamePackageRefactoring
						from: packageCoder package name
						to: tmp1 text asString} ];
		cancelBlock: [ tmp1 text: packageCoder package name ].
	tmp3 := tmp12
			when: GtRefactoringsAppliedEvent
			do: [ :arg5 | arg5 currentTarget visibility: BlVisibility hidden ].
	tmp1 editor
		when: BrTextEditorModifiedEvent
		do: [ :arg6 | 
			arg6 text asString = packageCoder package name
				ifTrue: [ tmp3 visibility: BlVisibility gone ]
				ifFalse: [ tmp3 visibility: BlVisibility visible ] ].
	tmp14 := GtPreviewChangeButton new.
	tmp14
		icon: BrGlamorousVectorIcons remove;
		label: 'Unload';
		changeAction: [ self unloadPackage ].
	tmp4 := tmp14 changeStencil: [ self buildRemovePackageLabel ].
	tmp2
		addChild: tmp1;
		addChild: tmp3;
		addChild: tmp4;
		addChild: self toolbarElement.
	^ tmp2
]

{ #category : #'private - ui' }
GtPharoPackageCoderElement >> buildPackageTagsList [
	| tmp2 |
	tmp2 := BrSimpleList new.
	tmp2
		itemStencil: [ GtPackageTagCardElement new ];
		itemDataBinder: [ :arg1 :arg2 | arg1 coder: arg2 ].
	^ tmp2
		items: (packageCoder packageTagsCoder coders
				asSortedCollection: [ :arg3 :arg4 | arg3 packageTagName < arg4 packageTagName ])
]

{ #category : #'private - ui' }
GtPharoPackageCoderElement >> buildParentLink [
	| tmp1 tmp3 tmp5 tmp7 |
	tmp3 := BrHorizontalPane new.
	tmp3 hMatchParent.
	tmp1 := tmp3 vFitContent.
	tmp5 := BrLabel new.
	tmp5
		margin: (BlInsets left: 4);
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularFont
					foreground: self theme button defaultTextColor).
	tmp1 addChild: (tmp5 text: 'In: ').
	tmp7 := BrLabel new.
	tmp7
		aptitude: (BrGlamorousButtonExteriorAptitude new borderPaint: Color transparent)
				+ BrGlamorousLabelAptitude new glamorousRegularFont;
		text: 'Pharo';
		beSmallSize;
		fitContent.
	tmp1
		addChild: (tmp7
				when: BlClickEvent
				do: [ :arg1 | 
					| tmp8 tmp9 tmp10 |
					tmp8 := GtPharoPackagesCoder forAllPackages.
					arg1 modifiers isAlt
						ifTrue: [ tmp9 := GtCoderToReplace new coder: tmp8.
							self fireEvent: tmp9.
							tmp9 isConsumed ifFalse: [ self phlow spawnObject: tmp9 coder ] ]
						ifFalse: [ arg1 modifiers isPrimaryModifier
								ifTrue: [ | tmp12 |
									tmp10 := BlSpace new.
									tmp10
										title: 'Packages';
										icon: BrGlamorousVectorIcons emphasizedBrowse;
										extent: 1200 @ 600.
									tmp10 root background: Color transparent.
									tmp12 := GtPagerWrapperElement new.
									tmp12 tool: GtCoderElement forAllPackages.
									tmp10
										addChild: (GtPager
												createOn: (tmp12
														embellisher: (GtPagerPageEmbellisher new extension: GtPagerPageEmbellisherExtension null)));
										withHalos.
									arg1 target showSpace: tmp10 ]
								ifFalse: [ tmp9 := GtCoderToSpawn new coder: tmp8.
									self fireEvent: tmp9.
									tmp9 isConsumed ifFalse: [ self phlow spawnObject: tmp9 coder ] ] ] ]).
	^ tmp1
]

{ #category : #'private - ui' }
GtPharoPackageCoderElement >> buildRemovePackageLabel [
	| tmp1 tmp2 tmp3 tmp4 tmp6 |
	tmp2 := packageCoder package definedClasses size.
	tmp4 := packageCoder package classTags size.
	tmp3 := packageCoder package extensionMethods size.
	tmp1 := 'Remove package <1s> with <2p> class<3?:es>, <4p> tag<5?:s> and <6p> extension method<7?:s>'
			expandMacrosWithArguments: {packageCoder package name.
					tmp2.
					tmp2 = 1.
					tmp4.
					tmp4 = 1.
					tmp3.
					tmp3 = 1}.
	tmp6 := BrLabel new.
	tmp6
		margin: (BlInsets all: 10);
		aptitude: BrGlamorousLabelAptitude new glamorousRegularFont.
	^ tmp6 text: tmp1 asRopedText
]

{ #category : #accessing }
GtPharoPackageCoderElement >> coderViewModel: arg1 [
	packageCoder := arg1 coder.
	self buildContentPane
]

{ #category : #initialization }
GtPharoPackageCoderElement >> initialize [
	super initialize.
	self
		initializeToolbarElement;
		padding: (BlInsets
					top: 5
					left: 6
					bottom: 5
					right: 6);
		when: BlClickEvent do: [ self requestFocus ];
		matchParent
]

{ #category : #'private - ui' }
GtPharoPackageCoderElement >> makeLabel [
	| tmp2 tmp4 |
	tmp2 := BrLabel new.
	tmp4 := BrGlamorousLabelAptitude new glamorousRegularFontAndSize.
	tmp4 foreground: Color gray.
	tmp2
		aptitude: (tmp4 fontSize: 12);
		text: 'Package'.
	^ tmp2 padding: (BlInsets left: 5)
]

{ #category : #accessing }
GtPharoPackageCoderElement >> package [
	<return: #RPackage>
	^ self packageCoder package
]

{ #category : #accessing }
GtPharoPackageCoderElement >> packageCoder [
	<return: #GtPharoPackageCoder>
	^ packageCoder
]

{ #category : #'private - ui' }
GtPharoPackageCoderElement >> packageViewItems [
	| tmp1 tmp2 |
	tmp1 := GtPhlowViewsCollector new.
	tmp1
		fromObject: self packageCoder package;
		pragmaName: #gtPackageView.
	tmp2 := GtPhlowContext new.
	tmp2 packageCoder: self packageCoder.
	tmp1 context: tmp2.
	^ tmp1 collect
]

{ #category : #actions }
GtPharoPackageCoderElement >> unloadPackage [
	packageCoder unload.
	self
		fireEvent: (GtCoderToReplace new coder: GtPharoPackagesCoder forAllPackages)
]
