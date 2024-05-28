Extension { #name : #GtPackageDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPackageDefinition >> browseFrom: arg1 [
	| tmp1 tmp2 tmp3 |
	tmp1 := RPackageOrganizer default packageNamed: self name ifAbsent: [ ^ self ].
	tmp3 := GtPharoPackageCoder forPackage: tmp1.
	tmp2 := GtCoderToSpawn new coder: tmp3.
	arg1 currentTarget fireEvent: tmp2.
	tmp2 isConsumed
		ifFalse: [ arg1 currentTarget phlow spawnTool: (GtReadyCoderTool coder: tmp2 coder) ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPackageDefinition >> newTabFrom: arg1 [
	| tmp1 tmp2 tmp3 tmp5 |
	tmp1 := RPackageOrganizer default packageNamed: self name ifAbsent: [ ^ self ].
	tmp2 := GtCoderElement forPackage: tmp1.
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
	arg1 target showSpace: tmp3
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPackageDefinition >> packageReader [
	| tmp2 |
	tmp2 := GtCodeDefinitionSingleReader new.
	tmp2
		title: 'Package';
		definition: self;
		getSelector: #name;
		renameEvent: GtBehaviorPackageRenamed;
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

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPackageDefinition >> readers [
	^ {self packageReader}
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPackageDefinition >> replaceFrom: arg1 [
	| tmp1 tmp2 tmp3 |
	tmp1 := RPackageOrganizer default packageNamed: self name ifAbsent: [ ^ self ].
	tmp3 := GtPharoPackageCoder forPackage: tmp1.
	tmp2 := GtCoderToReplace new coder: tmp3.
	arg1 currentTarget fireEvent: tmp2.
	tmp2 isConsumed
		ifFalse: [ arg1 currentTarget phlow spawnTool: (GtReadyCoderTool coder: tmp2 coder) ]
]
