Class {
	#name : #GtPharoPackageOverviewElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'package',
		'extendedMethodsElement',
		'behaviorTypesList',
		'headerElement',
		'dependenciesShortElement',
		'whichBaselineElement',
		'aContainer'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Views'
}

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> announcementClassesStream [
	^ self classesStream
		select: [ :arg1 | 
			(arg1 includesBehavior: Announcement)
				and: [ (arg1 includesBehavior: BlEvent) not
						and: [ (arg1 includesBehavior: BeaconSignal) not ] ] ]
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> beaconSignalClassesStream [
	^ self classesStream select: [ :arg1 | arg1 includesBehavior: BeaconSignal ]
]

{ #category : #'private - utilities' }
GtPharoPackageOverviewElement >> behaviorGroupForStream: arg1 named: arg2 ofType: arg3 [
	| tmp2 |
	tmp2 := BrGroup new.
	tmp2
		domainObject: arg2;
		stream: (self streamToCountStream: arg1);
		itemStencil: [ | tmp4 |
				tmp4 := BrButton new.
				tmp4
					hMatchParent;
					aptitude: BrGlamorousLinkButtonWithLabelAptitude;
					action: [ :arg4 | arg4 phlow spawnObject: arg4 model ] ].
	^ tmp2
		itemDataBinder: [ :arg5 :arg6 | 
			arg5
				model: arg1;
				label: arg6 asString , ' ' , arg3 ]
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> behaviorTypeGroupesStream [
	| tmp1 |
	tmp1 := OrderedCollection new.
	tmp1
		add: (self classGroupForStream: self classesStream named: 'Total classes');
		add: (self traitGroupForStream: self traitsStream named: 'Total traits');
		add: (self classGroupForStream: self userInterfaceClassesStream named: 'UI Elements');
		add: (self
					classGroupForStream: self userInterfaceEventClassesStream
					named: 'UI Events');
		add: (self classGroupForStream: self ffiClassesStream named: 'FFI classes');
		add: (self classGroupForStream: self announcementClassesStream named: 'Announcements');
		add: (self
					classGroupForStream: self beaconSignalClassesStream
					named: 'Beacon signals');
		add: (self classGroupForStream: self exampleClassesStream named: 'Examples').
	^ tmp1
]

{ #category : #'private - instance creation' }
GtPharoPackageOverviewElement >> buildPackageTagsIn: arg1 [
	arg1
		addChild: (self createPackageTagNamed: 'UI' stream: self userInterfaceClassesStream);
		addChild: (self createPackageTagNamed: 'FFI' stream: self ffiClassesStream);
		addChild: (self createPackageTagNamed: 'Examples' stream: self exampleClassesStream);
		addChild: (self createPackageTagNamed: 'Extensions' stream: self extensionMethodsStream);
		addChild: (self createPackageTagNamed: 'Beacon' stream: self beaconSignalClassesStream);
		addChild: (self createPackageTagNamed: 'Metadata' stream: self metadataStream)
]

{ #category : #'private - utilities' }
GtPharoPackageOverviewElement >> classGroupForStream: arg1 named: arg2 [
	^ self
		behaviorGroupForStream: arg1
		named: arg2
		ofType: 'classes'
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> classesAndTraitsStream [
	^ AsyncPackageBehaviorsStream forPackage: package
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> classesStream [
	^ self classesAndTraitsStream select: [ :arg1 | arg1 isClass ]
]

{ #category : #'private - instance creation' }
GtPharoPackageOverviewElement >> createClassTypesList [
	| tmp2 |
	tmp2 := BrGroupedList new.
	tmp2
		hMatchParent;
		vFitContentLimited;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		background: Color white;
		padding: (BlInsets
					top: 0
					bottom: 10
					left: 10
					right: 10);
		headerElementStencil: [ | tmp4 |
				tmp4 := BrLabel new.
				tmp4
					margin: (BlInsets top: 10);
					aptitude: (BrGlamorousLabelAptitude new foreground: Color gray) ].
	^ tmp2 headerDataBinder: [ :arg1 :arg2 | arg1 text: arg2 domainObject ]
]

{ #category : #'private - instance creation' }
GtPharoPackageOverviewElement >> createExtensionMethodsStatistic [
	| tmp1 tmp2 tmp3 tmp4 tmp6 tmp8 tmp10 tmp13 tmp15 tmp17 tmp19 |
	tmp6 := BrButton new.
	tmp6
		aptitude: BrGlamorousLinkButtonWithLabelAptitude;
		withAsyncSinkDo: [ :arg1 | 
				arg1
					sink: (AsyncFoldSink
							inject: (AsyncMutex for: Set new)
							into: [ :arg2 :arg3 | 
								arg2
									lock: [ :arg4 | arg4 add: arg3 methodClass ];
									yourself ]);
					whenUpdate: [ :arg5 :arg6 | arg5 label: (arg6 value lock: [ :arg7 | arg7 size ]) ] ];
		action: [ :arg8 | 
				arg8 phlow
					spawnObject: (arg8 asyncSink sink value
							lock: [ :arg9 | arg9 copy asArray sorted: [ :arg10 :arg11 | arg10 name < arg11 name ] ]) ].
	tmp2 := tmp6 label: '0'.
	tmp8 := BrButton new.
	tmp8
		aptitude: BrGlamorousLinkButtonWithLabelAptitude;
		withAsyncSinkDo: [ :arg12 | 
				arg12
					sink: (AsyncFoldSink
							inject: (AsyncMutex for: Set new)
							into: [ :arg13 :arg14 | 
								arg13
									lock: [ :arg15 | arg15 add: arg14 methodClass package ];
									yourself ]);
					whenUpdate: [ :arg16 :arg17 | arg16 label: (arg17 value lock: [ :arg18 | arg18 size ]) ] ];
		action: [ :arg19 | 
				arg19 phlow
					spawnObject: (arg19 asyncSink sink value
							lock: [ :arg20 | arg20 copy asArray sorted: [ :arg21 :arg22 | arg21 name < arg22 name ] ]) ].
	tmp3 := tmp8 label: '0'.
	tmp10 := BrButton new.
	tmp10
		aptitude: BrGlamorousLinkButtonWithLabelAptitude;
		withAsyncSinkDo: [ :arg23 | 
				arg23
					sink: (AsyncFoldSink
							inject: (AsyncMutex for: Set new)
							into: [ :arg24 :arg25 | 
								arg24
									lock: [ :arg26 | arg26 add: arg25 ];
									yourself ]);
					whenUpdate: [ :arg27 :arg28 | arg27 label: (arg28 value lock: [ :arg29 | arg29 size ]) ] ];
		action: [ :arg30 | 
				arg30 phlow
					spawnObject: (arg30 asyncSink sink value
							lock: [ :arg31 | 
								| tmp11 |
								tmp11 := arg31 copy asArray sorted: GtMethodsSortFunction new.
								GtSearchFixedMethodsFilter new methods: tmp11 ]) ].
	tmp4 := tmp10 label: '0'.
	tmp1 := BrHorizontalFlow new.
	tmp1
		hMatchParent;
		vFitContent.
	tmp13 := BrLabel new.
	tmp13 aptitude: BrGlamorousLabelAptitude.
	tmp1
		addChild: (tmp13 text: 'Extends ');
		addChild: tmp2.
	tmp15 := BrLabel new.
	tmp15 aptitude: BrGlamorousLabelAptitude.
	tmp1
		addChild: (tmp15 text: ' classes in ');
		addChild: tmp3.
	tmp17 := BrLabel new.
	tmp17 aptitude: BrGlamorousLabelAptitude.
	tmp1
		addChild: (tmp17 text: ' packages with ');
		addChild: tmp4.
	tmp19 := BrLabel new.
	tmp19 aptitude: BrGlamorousLabelAptitude.
	tmp1
		addChild: (tmp19 text: ' methods.');
		withAsyncSinkDo: [ :arg32 | 
				arg32
					sink: (AsyncSpreadSink
							forSinks: {tmp2 asyncSink.
									tmp3 asyncSink.
									tmp4 asyncSink}) ].
	^ tmp1
]

{ #category : #'private - instance creation' }
GtPharoPackageOverviewElement >> createPackageDependenciesStatistic [
	| tmp1 tmp2 tmp4 tmp9 tmp11 |
	tmp4 := BrButton new.
	tmp4
		aptitude: BrGlamorousLinkButtonWithLabelAptitude;
		withAsyncSinkDo: [ :arg1 | 
				arg1
					sink: (AsyncCollectionSink forCollection: AsyncSharedOrderedCollection new);
					whenUpdate: [ :arg2 :arg3 | arg2 label: arg3 collection size ] ];
		action: [ :arg4 | 
				| tmp5 tmp7 |
				tmp5 := arg4 asyncSink sink collection asArray
						sorted: [ :arg5 :arg6 | arg5 dependencyPackageName < arg6 dependencyPackageName ].
				tmp7 := GtPackageDependencyStatuses new.
				tmp7 package: package.
				arg4 phlow spawnObject: (tmp7 dependencies: tmp5) ].
	tmp2 := tmp4 label: '0'.
	tmp1 := BrHorizontalFlow new.
	tmp1
		hMatchParent;
		vFitContent.
	tmp9 := BrLabel new.
	tmp9 aptitude: BrGlamorousLabelAptitude.
	tmp1
		addChild: (tmp9 text: 'Depends on ');
		addChild: tmp2.
	tmp11 := BrLabel new.
	tmp11 aptitude: BrGlamorousLabelAptitude.
	tmp1
		addChild: (tmp11 text: ' packages');
		withAsyncSinkDo: [ :arg7 | arg7 sink: (AsyncSpreadSink forSinks: {tmp2 asyncSink}) ].
	^ tmp1
]

{ #category : #'private - instance creation' }
GtPharoPackageOverviewElement >> createPackageHeader [
	| tmp1 tmp3 tmp5 |
	tmp1 := BrVerticalPane new.
	tmp1
		hMatchParent;
		vFitContent.
	tmp3 := BrLabel new.
	tmp3
		id: #'package--header-label';
		beHugeSize.
	tmp1 addChild: (tmp3 aptitude: BrGlamorousLabelAptitude new bold).
	tmp5 := BrHorizontalFlow new.
	tmp5
		margin: (BlInsets top: 10);
		id: #'package--header-tags';
		vFitContent.
	tmp1 addChild: tmp5 hMatchParent.
	^ tmp1
]

{ #category : #'private - instance creation' }
GtPharoPackageOverviewElement >> createPackageTagNamed: arg1 stream: arg2 [
	| tmp2 |
	tmp2 := BrLabel new.
	tmp2
		aptitude: BrGlamorousLabelAptitude new;
		beSmallSize;
		visibility: BlVisibility gone;
		geometry: BlStadiumGeometry new;
		background: self theme status neutralBackgroundColor;
		padding: (BlInsets
					top: 1
					bottom: 1
					left: 6
					right: 6);
		margin: (BlInsets
					top: 0
					bottom: 3
					left: 0
					right: 5);
		text: arg1;
		in: [ :arg3 | arg3 viewModel model: arg2 ];
		when: BlClickEvent
			do: [ :arg4 | 
					arg4 consumed: true.
					arg4 currentTarget phlow
						spawnObject: arg4 currentTarget viewModel model asyncSimilarCopy ].
	^ tmp2
		withAsyncFutureDo: [ :arg5 | 
			arg5
				future: arg2 hasNext;
				whenSuccess: [ :arg6 :arg7 | 
						arg7
							ifTrue: [ arg6 visibility: BlVisibility visible ]
							ifFalse: [ arg6 visibility: BlVisibility gone ] ] ]
]

{ #category : #'private - instance creation' }
GtPharoPackageOverviewElement >> createRoundedPaneElement [
	| tmp2 |
	tmp2 := BrVerticalPane new.
	tmp2
		hMatchParent;
		vFitContent;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		addAptitude: BrShadowAptitude;
		background: Color white;
		padding: (BlInsets all: 10).
	^ tmp2 margin: (BlInsets all: 5)
]

{ #category : #'private - instance creation' }
GtPharoPackageOverviewElement >> createWhichBaselineElement [
	aContainer := BrHorizontalFlow new.
	aContainer
		hMatchParent;
		vFitContent.
	^ aContainer
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> exampleClassesStream [
	^ self classesStream select: [ :arg1 | arg1 gtExamples notEmpty ]
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> extensionMethodsStream [
	^ package extensionMethods asAsyncStream
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> ffiClassesStream [
	^ self classesStream
		select: [ :arg1 | 
			(arg1 instanceSide localMethods anySatisfy: [ :arg2 | arg2 isFFIMethod ])
				or: [ arg1 classSide localMethods anySatisfy: [ :arg3 | arg3 isFFIMethod ] ] ]
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> ffiMethodsStream [
	^ (self classesStream
		collect: [ :arg1 | AsyncBehaviorAllMethodsStream forBehavior: arg1 ]) flatten
		select: [ :arg2 | arg2 isFFIMethod ]
]

{ #category : #initialization }
GtPharoPackageOverviewElement >> initialize [
	| tmp2 tmp4 |
	super initialize.
	self
		background: Color white;
		matchParent;
		padding: (BlInsets
					top: 20
					bottom: 20
					left: 20
					right: 20);
		addChild: (headerElement := self createPackageHeader).
	tmp2 := BrHorizontalPane new.
	tmp2
		matchParent;
		margin: (BlInsets top: 10);
		addChild: (self createRoundedPaneElement
					addChild: (behaviorTypesList := self createClassTypesList)).
	tmp4 := BrVerticalPane new.
	tmp4
		matchParent;
		margin: (BlInsets left: 10);
		addChild: (self createRoundedPaneElement
					addChild: (extendedMethodsElement := self createExtensionMethodsStatistic));
		addChild: (self createRoundedPaneElement
					addChild: (dependenciesShortElement := self createPackageDependenciesStatistic)).
	self
		addChild: (tmp2
				addChild: (tmp4
						addChild: (self createRoundedPaneElement
								addChild: (whichBaselineElement := self createWhichBaselineElement))))
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> metadataStream [
	| tmp1 |
	^ (tmp1 := package packageManifestOrNil)
		ifNil: [ AsyncEmptyStream new ]
		ifNotNil: [ {tmp1} asAsyncStream ]
]

{ #category : #accessing }
GtPharoPackageOverviewElement >> package: arg1 [
	package := arg1.
	extendedMethodsElement asyncSink forwardStream: self extensionMethodsStream.
	dependenciesShortElement asyncSink
		forwardStream: self packageDependenciesStream.
	behaviorTypesList groups: self behaviorTypeGroupesStream.
	headerElement
		childWithId: #'package--header-label'
			ifFound: [ :arg2 | arg2 text: package name ];
		childWithId: #'package--header-tags'
			ifFound: [ :arg3 | 
					arg3 removeChildren.
					self buildPackageTagsIn: arg3 ].
	self updateWhichBaselines
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> packageDependenciesStream [
	^ [ package gtDependenciesStatusByAnalyzer asAsyncStream ] asAsyncFuture
		asAsyncStream flatten
]

{ #category : #'private - utilities' }
GtPharoPackageOverviewElement >> streamToCountStream: arg1 [
	^ ((arg1 inject: 0 into: [ :arg2 :arg3 | arg2 + 1 ])
		map: [ :arg4 | arg4 isZero ifTrue: [ AsyncEmptyStream new ] ifFalse: [ {arg4} asAsyncStream ] ])
		asAsyncStream flatten
]

{ #category : #'private - utilities' }
GtPharoPackageOverviewElement >> traitGroupForStream: arg1 named: arg2 [
	^ self
		behaviorGroupForStream: arg1
		named: arg2
		ofType: 'traits'
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> traitsStream [
	^ self classesAndTraitsStream select: [ :arg1 | arg1 isTrait ]
]

{ #category : #'private - updating' }
GtPharoPackageOverviewElement >> updateWhichBaselines [
	whichBaselineElement removeChildren.
	(GtDependencyAnalyzerForPackage baselinesForPackage: package)
		ifEmpty: [ | tmp2 |
			tmp2 := BrLabel new.
			tmp2 aptitude: BrGlamorousLabelAptitude.
			whichBaselineElement addChild: (tmp2 text: 'Does not belong to any baseline') ]
		ifNotEmpty: [ :arg1 | 
			| tmp4 |
			tmp4 := BrLabel new.
			tmp4 aptitude: BrGlamorousLabelAptitude.
			whichBaselineElement
				addChild: (tmp4 text: 'Belongs to the following baseline(s):').
			arg1
				do: [ :arg2 | 
					| tmp6 |
					tmp6 := BrButton new.
					tmp6
						aptitude: BrGlamorousLinkButtonWithLabelAptitude;
						model: arg2;
						action: [ :arg3 | arg3 phlow spawnTool: (GtClassCoderTool forClass: arg3 model) ].
					whichBaselineElement addChild: (tmp6 label: arg2 name) ] ]
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> userInterfaceClassesStream [
	^ self classesStream select: [ :arg1 | arg1 includesBehavior: BlElement ]
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> userInterfaceEventClassesStream [
	^ self classesStream select: [ :arg1 | arg1 includesBehavior: BlEvent ]
]
