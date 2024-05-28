Extension { #name : #GtClassSuperclassDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassSuperclassDefinition >> browseFrom: arg1 [
	self class environment
		at: self name
		ifPresent: [ :arg2 | 
			| tmp1 tmp2 |
			tmp2 := GtPharoBehaviorCoder forClass: arg2.
			tmp1 := GtCoderToSpawn new coder: tmp2.
			arg1 currentTarget fireEvent: tmp1.
			tmp1 isConsumed
				ifFalse: [ arg1 currentTarget phlow spawnTool: (GtReadyCoderTool coder: tmp1 coder) ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassSuperclassDefinition >> browseReferencesFrom: arg1 [
	self class environment
		at: self name
		ifPresent: [ :arg2 | arg1 currentTarget phlow spawnObject: arg2 gtReferences ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassSuperclassDefinition >> newTabFrom: arg1 [
	self class environment
		at: self name
		ifPresent: [ :arg2 | 
			| tmp1 tmp2 tmp4 |
			tmp1 := GtCoderElement forClass: arg2.
			tmp2 := BlSpace new.
			tmp2
				title: self name;
				icon: BrGlamorousVectorIcons emphasizedBrowse;
				extent: 1200 @ 600.
			tmp2 root background: Color transparent.
			tmp4 := GtPagerWrapperElement new.
			tmp4 tool: tmp1.
			tmp2
				addChild: (GtPager
						createOn: (tmp4
								embellisher: (GtPagerPageEmbellisher new extension: GtPagerPageEmbellisherExtension null)));
				withHalos.
			arg1 target showSpace: tmp2 ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassSuperclassDefinition >> readers [
	^ {self superclassReader}
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassSuperclassDefinition >> replaceFrom: arg1 [
	self class environment
		at: self name
		ifPresent: [ :arg2 | 
			| tmp1 tmp2 |
			tmp2 := GtPharoBehaviorCoder forClass: arg2.
			tmp1 := GtCoderToReplace new coder: tmp2.
			arg1 currentTarget fireEvent: tmp1.
			tmp1 isConsumed
				ifFalse: [ arg1 currentTarget phlow spawnTool: (GtReadyCoderTool coder: tmp1 coder) ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassSuperclassDefinition >> superclassReader [
	<return: #GtCodeDefinitionViewer>
	| tmp2 |
	tmp2 := GtCodeDefinitionSingleReader new.
	tmp2
		definition: self;
		title: 'Superclass';
		getSelector: #name;
		renameEvent: GtBehaviorSuperclassRenamed;
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
