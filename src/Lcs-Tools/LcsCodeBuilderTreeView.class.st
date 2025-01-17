Class {
	#name : #LcsCodeBuilderTreeView,
	#superclass : #Object,
	#instVars : [
		'parent'
	],
	#category : #'Lcs-Tools'
}

{ #category : #'gt view' }
LcsCodeBuilderTreeView class >> newPaintTreeOn: aMondrian context: anObject [ 
	self new
		paintTreeOn: aMondrian context: anObject 
]

{ #category : #'gt view' }
LcsCodeBuilderTreeView >> jobStepPane: aJobStep [ 
	^ BrVerticalPane new
		fitContent;
		addChild: (BrLabel new
				text: aJobStep class name;
				aptitude: (BrGlamorousLabelAptitude new
						foreground: Color gray;
						fontSize: 10));
		addChild: (BrLabel new
				text: aJobStep jobStepDescription;
				aptitude: BrGlamorousLabelAptitude new)
]

{ #category : #'gt view' }
LcsCodeBuilderTreeView >> jobStepPaneAssociation [
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

{ #category : #'gt view' }
LcsCodeBuilderTreeView >> paintTreeOn: aMondrian context: aBuilder [
	aBuilder
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
	^ aMondrian
]

{ #category : #accessing }
LcsCodeBuilderTreeView >> parent [
	^ parent
]

{ #category : #accessing }
LcsCodeBuilderTreeView >> parent: anObject [
	parent := anObject
]
