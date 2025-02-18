Class {
	#name : #LcsBaseApplicationEnvironmentStatus,
	#superclass : #LcsApplicationObject,
	#instVars : [
		'parent'
	],
	#category : #'Lcs-SystemManagement-Environment'
}

{ #category : #'instance creation' }
LcsBaseApplicationEnvironmentStatus class >> newOn: anApplicationEnvironment [ 
	^ self new
		initializeOn: anApplicationEnvironment;
		yourself
]

{ #category : #'gt views' }
LcsBaseApplicationEnvironmentStatus >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: [ 
			BlElement new
				layout: BlFrameLayout new;
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ];
				addChild: (
					BlElement new
						aptitude: BrShadowAptitude new;
						background: Color white;
						constraintsDo: [ :c |
							c frame horizontal alignCenter.
							c frame vertical alignCenter.
							c horizontal fitContent.
							c vertical fitContent ];
						layout: BlLinearLayout horizontal;
						addChild: (BlElement new background: self gtLiveBackground; constraintsDo: [:c | c vertical matchParent. c horizontal exact: 30 ]);
						addChild: (BrLabel new
							text: self statusName;
							aptitude: BrGlamorousLabelAptitude;
							layout: BlLinearLayout vertical alignCenter;
							padding: (BlInsets all: 10))) ]
]

{ #category : #initialize }
LcsBaseApplicationEnvironmentStatus >> initializeOn: anApplicationEnvironment [ 
	self parent: anApplicationEnvironment
]

{ #category : #testing }
LcsBaseApplicationEnvironmentStatus >> isInActiveStatus [
	^ false
]

{ #category : #testing }
LcsBaseApplicationEnvironmentStatus >> isInSuspendedStatus [
	^ false
]

{ #category : #accessing }
LcsBaseApplicationEnvironmentStatus >> parent [
	^ parent
]

{ #category : #accessing }
LcsBaseApplicationEnvironmentStatus >> parent: anApplicationEnvironment [ 
	parent := anApplicationEnvironment
]

{ #category : #api }
LcsBaseApplicationEnvironmentStatus >> restoreApplicationEnvironment [
]

{ #category : #accessing }
LcsBaseApplicationEnvironmentStatus >> statusName [
	^ 'Base Status'
]

{ #category : #api }
LcsBaseApplicationEnvironmentStatus >> suspendApplicationEnvironment [
]
