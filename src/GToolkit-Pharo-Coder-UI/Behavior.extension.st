Extension { #name : #Behavior }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
Behavior >> gtCoderStreamingMethodsFor: arg1 context: arg2 [
	<gtClassView>
	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 tmp8 tmp10 |
	tmp1 := GtPharoStreamingMethodsCoder forBehavior: self.
	tmp8 := GtPharoStreamingMethodsCoderViewModel new.
	tmp8
		streamingCodersModel: tmp1;
		shouldExpandByDefault: false;
		shouldHaveHeaderByDefault: false.
	tmp2 := tmp8
			selfObject: (arg2
					optionAt: #behaviorCoder
					ifPresent: [ :arg3 | arg3 coderModel object ]
					ifAbsent: [  ]).
	tmp3 := self testSuiteViewModelWith: tmp1 fromContext: arg2.
	tmp4 := GtPharoCoderUIUtility
			exampleViewModelCachedAs: #exampleViewModelHandler_gtCoderStreamingMethodsForContext
			inPhlowContext: arg2
			forMethodsCoder: tmp1.
	tmp6 := ValueHolder new.
	tmp10 := arg1 explicit.
	tmp10
		priority: 9;
		title: 'Methods';
		disableAsync;
		actionDropdownButtonIcon: BrGlamorousVectorIcons filter
			tooltip: 'Filter'
			content: [ :arg4 | tmp1 filterDropDown: arg4 ].
	tmp5 := tmp10
			actionDropdownButtonDo: [ :arg5 | 
				| tmp12 |
				tmp12 := arg5 dropdown.
				tmp12
					id: GtPharoAddNewMethodButtonId;
					icon: BrGlamorousVectorIcons add;
					tooltip: 'Add new method';
					preferredExtent: GtPharoNewMethodCoderElement preferredExtent;
					content: [ :arg6 | 
							self
								gtNewMethodDropdownOn: arg6
								withViewModel: tmp2
								withNewMethodHolder: tmp6 ] ].
	(tmp1 codeGeneratorsAvailableFor: tmp2)
		ifTrue: [ tmp5
				actionDropdownButtonIcon: BrGlamorousVectorIcons robot
				tooltip: 'Generate'
				content: [ :arg7 | tmp1 codeGeneratorsDropDown: arg7 for: tmp2 ] ].
	tmp5
		actionButtonDo: [ :arg8 | 
			arg8
				icon: BrGlamorousVectorIcons inspect;
				tooltip: 'Inspect view model';
				action: [ :arg9 | arg9 phlow spawnObject: tmp2 ] ];
		actionStencil: [ :arg10 | GtPharoCoderUIUtility newExamplesDropdownButtonForViewModel: tmp4 ];
		actionStencil: [ :arg11 | GtPharoCoderUIUtility newTestsDropdownButtonForViewModel: tmp3 ];
		stencil: [ GtPharoStreamingMethodsCoderElement new streamingCodersViewModel: tmp2 ].
	^ tmp5
		actionStencil: [ :arg12 | 
			| tmp14 |
			tmp14 := GtSpotterDropdownButtonStencil new.
			tmp14
				object: self;
				tooltip: 'Search code';
				id: GtPharoSearchCodeButtonId;
				objectActOn: [ :arg13 :arg14 :arg15 | 
						| tmp15 tmp16 |
						tmp15 := false.
						tmp16 := arg15 phlow firstParentWithView phlow firstParentWithView
								navigationModel.
						(arg14 isKindOf: RPackage)
							ifTrue: [ tmp16 selectPackage: arg14.
								tmp15 := true ].
						(arg14 isKindOf: ClassDescription)
							ifTrue: [ tmp16 selectClass: arg14.
								tmp15 := true ].
						(arg14 isKindOf: CompiledMethod)
							ifTrue: [ tmp16 selectMethod: arg14.
								tmp15 := true ].
						arg13 beActed.
						tmp15 ifFalse: [ arg12 phlow spawnTool: arg13 toolToSend ] ];
				asElement ]
		tooltip: 'Search code'
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
Behavior >> gtCopyButtonFor: arg1 [
	<gtClassAction>
	| tmp4 |
	self isTrait
		ifTrue: [ | tmp2 |
			tmp2 := arg1 dropdown.
			tmp2
				tooltip: 'Copy Trait';
				icon: BrGlamorousVectorIcons changes;
				id: GtPharoCopyClassElementId;
				priority: 4.
			^ tmp2
				content: [ :arg2 | 
					((GtCopyTraitForm for: self)
						onAccept: [ :arg3 | 
							arg2
								inUIProcessDo: [ arg2 phlow spawnTool: (GtClassCoderTool forClass: arg3).
									arg2 dispatchEvent: BrDropdownHideWish new ] ]) asElement
						padding: (BlInsets all: 5) ] ].
	tmp4 := arg1 dropdown.
	tmp4
		tooltip: 'Copy Class';
		icon: BrGlamorousVectorIcons changes;
		id: GtPharoCopyClassElementId;
		priority: 4.
	^ tmp4
		content: [ :arg4 | 
			((GtCopyClassForm for: self)
				onAccept: [ :arg5 | 
					arg4
						inUIProcessDo: [ arg4 phlow spawnTool: (GtClassCoderTool forClass: arg5).
							arg4 dispatchEvent: BrDropdownHideWish new ] ]) asElement
				padding: (BlInsets all: 5) ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
Behavior >> gtNewMethodDropdownOn: arg1 withViewModel: arg2 withNewMethodHolder: arg3 [
	| tmp2 tmp4 |
	tmp2 := GtPharoNewMethodCoderElement new.
	tmp2
		behavior: self;
		methodCoderViewModelValueHolder: arg3.
	tmp4 := GtPharoNewMethodCodeSavedHandler new.
	tmp4
		methodsCoderViewModel: arg2;
		element: arg1.
	tmp2 onMethodCoderSaved: (tmp4 methodCoderHolder: arg3).
	^ tmp2
		when: GtPhlowObjectToSpawn
		do: [ :arg4 | 
			| tmp6 |
			arg4 consumed: true.
			tmp6 := GtPhlowObjectToSpawn new.
			tmp6
				previousSpawnEvent: arg4;
				tool: arg4 tool;
				sourceElement: arg4 currentTarget;
				spawnDestination: arg4 spawnDestination;
				in: [ :arg5 | arg5 propertyAt: #spawnContainer put: arg4 currentTarget ].
			arg1 fireEvent: tmp6 yourself ]
]
