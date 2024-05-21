Class {
	#name : #LcsCodeBuilderJob,
	#superclass : #LcsObject,
	#instVars : [
		'classPrefix',
		'codePackageName',
		'completedRefactorings',
		'jobSteps'
	],
	#category : #'Lcs-Tools'
}

{ #category : #build }
LcsCodeBuilderJob >> addCompletedRefactoring: aRefactoring [ 
	self completedRefactorings add: aRefactoring
]

{ #category : #configuration }
LcsCodeBuilderJob >> addJobStep: aBuilderJobStep [ 
	self jobSteps addJobStep: aBuilderJobStep
]

{ #category : #query }
LcsCodeBuilderJob >> builderJob [
	^self
]

{ #category : #accessing }
LcsCodeBuilderJob >> classPrefix [
	^ classPrefix
]

{ #category : #accessing }
LcsCodeBuilderJob >> classPrefix: aString [
	classPrefix := aString
]

{ #category : #accessing }
LcsCodeBuilderJob >> codePackageName [
	^ codePackageName
]

{ #category : #accessing }
LcsCodeBuilderJob >> codePackageName: aString [ 
	codePackageName := aString
]

{ #category : #accessing }
LcsCodeBuilderJob >> completedRefactorings [
	^ completedRefactorings
]

{ #category : #accessing }
LcsCodeBuilderJob >> completedRefactorings: anObject [
	completedRefactorings := anObject
]

{ #category : #'gt view' }
LcsCodeBuilderJob >> gtStepsMondrianTreeFor: aView [
	<gtView>
	^ aView empty
"	self jobSteps hasNoJobSteps ifTrue: [ ^ aView empty ].
	^ aView mondrian
		title: 'Steps';
		priority: 2;
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]"
]

{ #category : #iniitialize }
LcsCodeBuilderJob >> initialize [
	super initialize.
	self
		jobSteps: (LcsCodeBuilderJobSteps newOn: self);
		classPrefix: 'Lcs';
		completedRefactorings: OrderedCollection new.
]

{ #category : #build }
LcsCodeBuilderJob >> installCode [
	self jobSteps installCode
]

{ #category : #configuration }
LcsCodeBuilderJob >> installNewClassesInPackageNamed: aString [ 
	self codePackageName: aString
]

{ #category : #accessing }
LcsCodeBuilderJob >> jobSteps [
	^ jobSteps
]

{ #category : #accessing }
LcsCodeBuilderJob >> jobSteps: anObject [
	jobSteps := anObject
]

{ #category : #'gt view' }
LcsCodeBuilderJob >> paintTreeWith: view [
	view nodes
		shape: [ :each | 
			LcsCodeBuilderStepElement newFromStep: each ];
		with: (self withDeepCollect: #jobSteps).
	view edges
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		fromRightCenter;
		toLeftCenter;
		connectToAll: #steps.
	view layout custom: (GtGradWestHierarchicalLayout new alignment: GtGradHierarchicalLayoutRootAlignment new)
]

{ #category : #'gt view' }
LcsCodeBuilderJob >> stateColor [
	^Color green
]

{ #category : #'gt view' }
LcsCodeBuilderJob >> stepIcon [
	<return: #BlElement or: nil>
	^ nil
]
