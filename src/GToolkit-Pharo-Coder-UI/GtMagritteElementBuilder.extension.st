Extension { #name : #GtMagritteElementBuilder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtMagritteElementBuilder >> newPackageNameWidget: arg1 [
	| tmp1 tmp2 tmp3 tmp4 tmp6 |
	tmp1 := self memento.
	tmp2 := BrEditor new.
	tmp4 := arg1 editorAptitude
			ifNil: [ BrGlamorousRegularEditorAptitude new glamorousRegularFontAndSize ]
			ifNotNil: #value.
	tmp2
		inputFilter: BrPackageNameInputFilter new;
		aptitude: tmp4.
	tmp6 := BrStyleCommonAptitude new.
	tmp6
		default: [ :arg2 | arg2 border: BlBorder empty ];
		hovered: [ :arg3 | 
				arg3
					border: (BlBorder paint: BrGlamorousColors disabledButtonBorderColor width: 1) ].
	tmp2
		addAptitude: (tmp6
				focused: [ :arg4 | 
					arg4
						border: (BlBorder paint: BrGlamorousColors focusedEditorBorderColor width: 1) ]);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		vFitContent;
		hFitContentLimited;
		margin: (BlInsets top: 2 bottom: 4);
		constraintsDo: [ :arg5 | 
				arg5 grid vertical alignCenter.
				arg5 minWidth: 20 ];
		when: BlFocusInEvent do: [ :arg6 | tmp2 selecter all select ];
		when: BlFocusOutEvent do: [ :arg7 | tmp2 deselecter all deselect ];
		withAsyncSinkDo: [ :arg8 | 
				arg8
					sink: AsyncPeekSink new;
					whenUpdate: [ :arg9 :arg10 | arg9 text: arg10 value currentValue packageRope ].
				(tmp1 readObservableValueUsing: arg1) observe: arg8 ].
	tmp3 := GtStringsCompletionStrategy new
			completions: (GtPrefixTree withAll: RPackageOrganizer default packageNames).
	(GtCompletionController on: tmp2 strategy: tmp3) install.
	tmp2 editor
		when: BrTextEditorModifiedEvent
		do: [ :arg11 | 
			| tmp7 tmp8 |
			tmp7 := tmp1 readUsing: arg1.
			tmp8 := tmp7 copyWithNewPackageName: arg11 text asString.
			GtMagritteBuilderUtility
				write: tmp8
				using: arg1
				memento: tmp1
				element: tmp2 ].
	^ tmp2
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtMagritteElementBuilder >> newTagNameWidget: arg1 [
	| tmp1 tmp2 tmp3 tmp5 tmp7 |
	tmp1 := self memento.
	tmp2 := BrEditor new.
	tmp3 := arg1 editorAptitude
			ifNil: [ BrGlamorousRegularEditorAptitude new glamorousRegularFontAndSize ]
			ifNotNil: #value.
	tmp2
		inputFilter: BrPackageTagNameInputFilter new;
		aptitude: tmp3.
	tmp7 := BrStyleCommonAptitude new.
	tmp7
		default: [ :arg2 | arg2 border: BlBorder empty ];
		hovered: [ :arg3 | 
				arg3
					border: (BlBorder paint: BrGlamorousColors disabledButtonBorderColor width: 1) ].
	tmp2
		addAptitude: (tmp7
				focused: [ :arg4 | 
					arg4
						border: (BlBorder paint: BrGlamorousColors focusedEditorBorderColor width: 1) ]);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		vFitContent;
		hFitContentLimited;
		margin: (BlInsets top: 2 bottom: 4);
		constraintsDo: [ :arg5 | 
				arg5 grid vertical alignCenter.
				arg5 minWidth: 20 ];
		when: BlFocusInEvent do: [ :arg6 | tmp2 selecter all select ];
		when: BlFocusOutEvent do: [ :arg7 | tmp2 deselecter all deselect ];
		withAsyncSinkDo: [ :arg8 | 
				arg8
					sink: AsyncPeekSink new;
					whenUpdate: [ :arg9 :arg10 | 
							| tmp8 tmp9 |
							tmp8 := arg10 value currentValue packageName asPackageIfAbsent: [  ].
							tmp8
								ifNotNil: [ tmp5 ifNotNil: [ tmp5 uninstall ].
									tmp9 := GtStringsCompletionStrategy new
											completions: (GtPrefixTree withAll: (tmp8 classTags collect: #name)).
									tmp5 := (GtCompletionController on: tmp2 strategy: tmp9) install ].
							arg9 text: arg10 value currentValue tagRope ].
				(tmp1 readObservableValueUsing: arg1) observe: arg8 ].
	tmp2 editor
		when: BrTextEditorModifiedEvent
		do: [ :arg11 | 
			| tmp10 tmp11 |
			tmp10 := tmp1 readUsing: arg1.
			tmp11 := tmp10 copyWithNewTagName: arg11 text asString.
			GtMagritteBuilderUtility
				write: tmp11
				using: arg1
				memento: tmp1
				element: tmp2 ].
	^ tmp2
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtMagritteElementBuilder >> visitGtPackageAndTagDescription: arg1 [
	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 tmp8 |
	tmp6 := self memento.
	tmp3 := BrHorizontalPane new fitContent.
	tmp1 := self newPackageNameWidget: arg1.
	tmp2 := self newTagNameWidget: arg1.
	self
		addShortcutsTo: tmp1 using: arg1;
		addShortcutsTo: tmp2 using: arg1.
	tmp3 addChild: tmp1 as: #package.
	tmp8 := GtMagritteBuilderUtility
			newFieldLabelWithSpace: self defaultSpacing
			using: arg1.
	tmp8 text: 'Tag:'.
	tmp3
		addChild: (tmp8 constraintsDo: [ :arg2 | arg2 linear vertical alignCenter ]);
		addChild: tmp2 as: #tag.
	arg1 isWithChangeIndicator
		ifTrue: [ tmp5 := GtMagritteBuilderUtility
					newValidationContainerWith: tmp3
					memento: tmp6
					using: arg1 ]
		ifFalse: [ tmp5 := tmp3 ].
	tmp4 := self addFieldElement: tmp5 using: arg1.
	tmp4 padding: tmp4 padding + (BlInsets top: self defaultSpacing)
]
