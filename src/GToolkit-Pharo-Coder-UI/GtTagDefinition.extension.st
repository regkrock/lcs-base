Extension { #name : #GtTagDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtTagDefinition >> browseFrom: arg1 [
	| tmp1 |
	tmp1 := RPackageOrganizer default
			packageNamed: self parent category package name
			ifAbsent: [ ^ self ].
	tmp1
		classTagNamed: self name
		ifPresent: [ :arg2 | 
			| tmp2 tmp3 |
			tmp2 := (GtPharoPackageTagCoder forPackageTag: arg2)
					packageCoder: (GtPharoPackageCoder forPackage: tmp1).
			tmp3 := GtCoderToSpawn new coder: tmp2.
			arg1 currentTarget fireEvent: tmp3.
			tmp3 isConsumed
				ifFalse: [ arg1 currentTarget phlow spawnTool: (GtReadyCoderTool coder: tmp3 coder) ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtTagDefinition >> newTabFrom: arg1 [
	| tmp1 |
	tmp1 := RPackageOrganizer default
			packageNamed: self parent category package name
			ifAbsent: [ ^ self ].
	tmp1
		classTagNamed: self name
		ifPresent: [ :arg2 | 
			| tmp2 tmp3 tmp5 |
			tmp2 := GtCoderElement forPackageTag: arg2.
			tmp3 := BlSpace new.
			tmp3
				title: self name;
				icon: BrGlamorousVectorIcons emphasizedBrowse;
				extent: 1200 @ 600.
			tmp3 root background: Color transparent.
			tmp5 := GtPagerWrapperElement new.
			tmp5 tool: tmp2.
			tmp3
				addChild: (GtPager
						createOn: (tmp5
								embellisher: (GtPagerPageEmbellisher new extension: GtPagerPageEmbellisherExtension null)));
				withHalos.
			arg1 target showSpace: tmp3 ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtTagDefinition >> readers [
	^ {self tagReader}
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtTagDefinition >> replaceFrom: arg1 [
	| tmp1 |
	tmp1 := RPackageOrganizer default
			packageNamed: self parent category package name
			ifAbsent: [ ^ self ].
	tmp1
		classTagNamed: self name
		ifPresent: [ :arg2 | 
			| tmp2 tmp3 |
			tmp2 := (GtPharoPackageTagCoder forPackageTag: arg2)
					packageCoder: (GtPharoPackageCoder forPackage: tmp1).
			tmp3 := GtCoderToReplace new coder: tmp2.
			arg1 currentTarget fireEvent: tmp3.
			tmp3 isConsumed
				ifFalse: [ arg1 currentTarget phlow spawnTool: (GtReadyCoderTool coder: tmp3 coder) ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtTagDefinition >> tagReader [
	| tmp2 |
	tmp2 := GtCodeDefinitionSingleReader new.
	tmp2
		title: 'Tag';
		definition: self;
		getSelector: #name;
		renameEvent: GtBehaviorTagRenamed;
		whenAltClickDo: [ :arg1 :arg2 | arg2 replaceFrom: arg1 ];
		whenPrimaryClickDo: [ :arg3 :arg4 | arg4 newTabFrom: arg3 ];
		whenClickDo: [ :arg5 :arg6 | arg6 browseFrom: arg5 ];
		when: BlKeyUpEvent do: [ :arg7 | arg7 target mouseCursor: nil ].
	^ tmp2
		when: BlKeyDownEvent
		do: [ :arg8 | 
			arg8 consumed: true.
			arg8 key isAlt
				ifTrue: [ arg8 target mouseCursor: BlAliasCursor new ]
				ifFalse: [ arg8 key isPrimary
						ifTrue: [ arg8 target mouseCursor: BlCopyCursor new ]
						ifFalse: [ arg8 target mouseCursor: nil ] ] ]
]
