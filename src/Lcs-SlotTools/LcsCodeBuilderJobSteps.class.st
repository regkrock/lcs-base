Class {
	#name : #LcsCodeBuilderJobSteps,
	#superclass : #LcsApplicationObject,
	#instVars : [
		'classPrefix',
		'codePackageName',
		'collection',
		'parent'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsCodeBuilderJobSteps class >> collectionClass [
	^OrderedCollection
]

{ #category : #'instance creation' }
LcsCodeBuilderJobSteps class >> newOn: anObject [
	^ self new
		initializeOn: anObject;
		yourself 
]

{ #category : #'gt views' }
LcsCodeBuilderJobSteps >> addAssociationsToUmlModel: umlModel [
	self collection do: [ :eachStep | eachStep addAssociationsToUmlModel: umlModel ]
]

{ #category : #'gt views' }
LcsCodeBuilderJobSteps >> addClassesToUmlModel: umlModel [
	self collection do: [ :eachStep | eachStep addClassesToUmlModel: umlModel ]
]

{ #category : #steps }
LcsCodeBuilderJobSteps >> addJobStep: aJobStep [
	aJobStep parent: self.
	self collection add: aJobStep.
	aJobStep buildJobSteps.
	^ aJobStep
]

{ #category : #refactorings }
LcsCodeBuilderJobSteps >> addRefactoringsTo: aCollection [
	self collection do: [ :eachStep | eachStep addRefactoringsTo: aCollection ]
]

{ #category : #asking }
LcsCodeBuilderJobSteps >> allStepsAfter: aJobStep [
	self collection last == aJobStep ifTrue: [ ^ OrderedCollection new ].
	^ self collection
		copyFrom: (self collection indexOf: aJobStep) + 1
		to: self collection size
]

{ #category : #collection }
LcsCodeBuilderJobSteps >> buildJobSteps [
	^ self collection do: [ :each | each buildJobSteps ]
]

{ #category : #asking }
LcsCodeBuilderJobSteps >> builderJob [
	^ self parent builderJob
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> classPrefix [
	^ classPrefix
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> classPrefix: aString [
	self collection do: [ :each | (each respondsTo: #classPrefix:) ifTrue: [each classPrefix: aString]].
]

{ #category : #collection }
LcsCodeBuilderJobSteps >> collect: aCollectBlock [
	^ self collection collect: aCollectBlock
]

{ #category : #collection }
LcsCodeBuilderJobSteps >> collect: aCollectBlock thenSelect: aSelectBlock [
	^ self collection collect: aCollectBlock thenSelect: aSelectBlock
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> collection [
	^ collection
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> collection: aCollection [
	^ collection := aCollection
]

{ #category : #asking }
LcsCodeBuilderJobSteps >> completedRefactorings [
	^ self parent completedRefactorings
]

{ #category : #collection }
LcsCodeBuilderJobSteps >> do: aCollectBlock [
	^ self collection do: aCollectBlock
]

{ #category : #collection }
LcsCodeBuilderJobSteps >> do: aDoBlock separatedBy: aBlock [
	self collection do: aDoBlock separatedBy: aBlock
]

{ #category : #'gt views' }
LcsCodeBuilderJobSteps >> gtClassBuilderViewFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Steps List';
		priority: 10;
		expandUpTo: 3;
		items: [ self collection ];
		children: [ :step | step jobSteps ];
		"column: 'Number'
			text: [ :step | step stepNumber ] width: 55;"
		column: 'Step'
			text: [ :step | step jobStepDescription ] width: 400;
		column: 'Step Class'
			text: [ :step | step class name ];
		column: ''
			stencil: [ :step | step viewCodeButton ];
		column: 'Status'
			text: [ :step | step state asString asRopedText ]
]

{ #category : #'gt views' }
LcsCodeBuilderJobSteps >> gtConstructionTreeFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Steps Tree';
		priority: 2;
		painting: [ :aMondrian | LcsCodeBuilderTreeView newPaintTreeOn: aMondrian context: self ]
]

{ #category : #'gt views' }
LcsCodeBuilderJobSteps >> gtPaintTreeWith: aMondrian [
	self
		withDeep: [ :each | each jobSteps collect: [ :eachStep | eachStep ] ]
		do: [ :each | 
			aMondrian nodes
				stencil: [ :eachJobStep | self jobStepPane: eachJobStep ];
				with: {each} ]
		relationDo: [ :from :to | 
			aMondrian edges
				fromRightCenter;
				toLeftCenter;
				stencil: [ :x | self jobStepPaneAssociation ];
				connectAssociations: {from -> to} ].
	aMondrian layout
		custom: (GtGraphHorizontalTreeLayout new
				levelDistance: 50;
				nodeDistance: 20).
	aMondrian
]

{ #category : #testing }
LcsCodeBuilderJobSteps >> hasJobSteps [
	^ self collection notEmpty
]

{ #category : #testing }
LcsCodeBuilderJobSteps >> hasNoJobSteps [
	^ self collection isEmpty
]

{ #category : #testing }
LcsCodeBuilderJobSteps >> hasSteps [
	^ self collection notEmpty
]

{ #category : #asking }
LcsCodeBuilderJobSteps >> inStepsAfter: aJobStep removeTargetClass: aClass [
	(self allStepsAfter: aJobStep) do: [ :eachStep | eachStep clearTargetClass: aClass ]
]

{ #category : #asking }
LcsCodeBuilderJobSteps >> indexOf: aJobStep [
	^ self collection indexOf: aJobStep
]

{ #category : #initialize }
LcsCodeBuilderJobSteps >> initialize [
	super initialize.
	self collection: OrderedCollection new
]

{ #category : #initialize }
LcsCodeBuilderJobSteps >> initializeOn: anObject [ 
	self parent: anObject
]

{ #category : #command }
LcsCodeBuilderJobSteps >> installCode [
	self collection do: [ :each | each installCode ]
]

{ #category : #testing }
LcsCodeBuilderJobSteps >> isEmpty [
	^ self collection isEmpty
]

{ #category : #testing }
LcsCodeBuilderJobSteps >> isNotEmpty [
	^ self collection isNotEmpty
]

{ #category : #querying }
LcsCodeBuilderJobSteps >> jobStep: anInteger [
	^ self collection at: anInteger
]

{ #category : #steps }
LcsCodeBuilderJobSteps >> jobStepAt: anIndex [
	^ self collection at: anIndex
]

{ #category : #'gt views' }
LcsCodeBuilderJobSteps >> jobStepDescription [
	| stream |
	stream := WriteStream on: String new.
	self printJobStreamDetailsOn: stream.
	^ stream contents
]

{ #category : #'gt views' }
LcsCodeBuilderJobSteps >> jobStepPane: eachJobStep [
	^ BrVerticalPane new
		fitContent;
		addChild: (BrLabel new
				text: eachJobStep class name;
				aptitude: (BrGlamorousLabelAptitude new
						foreground: Color gray;
						fontSize: 10));
		addChild: (BrLabel new
				text: eachJobStep jobStepDescription;
				aptitude: BrGlamorousLabelAptitude new)
]

{ #category : #'gt views' }
LcsCodeBuilderJobSteps >> jobStepPaneAssociation [
	^ BlParabollaArcElement new
		zIndex: 0;
		curvatureFraction: 0.0;
		border: (BlBorder paint: (Color gray alpha: 0.2) width: 2);
		toHead: (BlArrowheadSimpleArrow new
				border: (BlBorder builder
						paint: (Color gray alpha: 0.2);
						width: 4;
						build))
]

{ #category : #private }
LcsCodeBuilderJobSteps >> jobSteps [
	^ self collection
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> parent [
	^ parent
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> parent: anObject [
	parent := anObject
]

{ #category : #command }
LcsCodeBuilderJobSteps >> populateSlotModel [
	self collection reverseDo: [ :each | each populateSlotModel ]
]

{ #category : #'gt views' }
LcsCodeBuilderJobSteps >> printJobStreamDetailsOn: aStream [
	aStream nextPutAll: 'Job Steps'
]

{ #category : #callbacks }
LcsCodeBuilderJobSteps >> propogateProperty: aName valueChangedTo: anObject [
	self jobSteps do: [ :eachStep | eachStep propogateProperty: aName valueChangedTo: anObject ]
]

{ #category : #'as yet unclassified' }
LcsCodeBuilderJobSteps >> removeAll [
	self collection removeAll
]

{ #category : #'gt - views' }
LcsCodeBuilderJobSteps >> stepNumberFor: aStep [
	| localStepNumber |
	localStepNumber := (self indexOf: aStep) printString.
	self parent ifNil: [ ^ localStepNumber ].
	^ self parent stepNumber 
		ifEmpty: [ localStepNumber ] 
		ifNotEmpty: [ :parentStepNumber | parentStepNumber , '.' , localStepNumber ]
]

{ #category : #steps }
LcsCodeBuilderJobSteps >> stepsWithClass: aClass [
	^ self collection select: [ :each | each class  == aClass ]
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> targetClassName [
	^ self parent targetClassName
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> targetPackageName [
	^ codePackageName
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> targetPackageName: aString [
	self collection
		do: [ :each | (each respondsTo: #targetPackageName:) ifTrue: [ each targetPackageName: aString ] ]
]

{ #category : #command }
LcsCodeBuilderJobSteps >> uninstall [
	self collection reverseDo: [ :each | each uninstall ]
]

{ #category : #command }
LcsCodeBuilderJobSteps >> updateSlotModel [
	self collection do: [ :each | each updateSlotModel ]
]

{ #category : #command }
LcsCodeBuilderJobSteps >> verifyCodeInstallation [
	self collection do: [ :each | each verifyCodeInstallation ]
]

{ #category : #command }
LcsCodeBuilderJobSteps >> verifyPopulateSlotModel [
	self collection do: [ :each | each verifyPopulateSlotModel ]
]

{ #category : #command }
LcsCodeBuilderJobSteps >> verifySlotModelUpdatesMadeByBuilder [
	self collection do: [ :each | each verifySlotModelUpdatesMadeByBuilder ]
]

{ #category : #command }
LcsCodeBuilderJobSteps >> verifyUninstall [
	self collection do: [ :each | each verifyUninstall ]
]
