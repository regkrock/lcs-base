Class {
	#name : #GtChangesElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'changesTree',
		'changes'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #executing }
GtChangesElement >> applyChanges [
	^ self applyChangesWithProgress: [  ]
]

{ #category : #executing }
GtChangesElement >> applyChangesWithProgress: arg1 [
	| tmp1 tmp2 |
	tmp1 := RBCompositeRefactoryChange named: changes name.
	tmp2 := (changesTree viewModel root value flatCollect: #allChanges)
			reject: [ :arg2 | arg2 isEnabled ].
	tmp1
		changes: (changesTree viewModel root value collect: [ :arg3 | arg3 change copy ])
				asOrderedCollection.
	tmp2 do: [ :arg4 | tmp1 recursivelyRemoveChange: arg4 change ].
	^ tmp1 gtExecuteWithNotificationWithProgress: arg1
]

{ #category : #accessing }
GtChangesElement >> changes [
	^ changes
]

{ #category : #accessing }
GtChangesElement >> changes: arg1 [
	changes := arg1.
	changesTree
		items: {GtUserActivatableChange fromChange: changes}
		lazy: [ :arg2 | arg2 changes ]
]

{ #category : #accessing }
GtChangesElement >> expandUpTo: arg1 [
	changesTree expandUpTo: arg1
]

{ #category : #initialization }
GtChangesElement >> initialize [
	| tmp2 |
	super initialize.
	self
		layout: BlLinearLayout vertical;
		matchParent;
		padding: (BlInsets all: 10).
	tmp2 := BrSimpleTree new.
	tmp2
		nodeType: [ :arg1 :arg2 | arg2 value elementClass ];
		nodeStencil: [ :arg3 | arg3 new ];
		nodeDataBinder: [ :arg4 :arg5 | arg4 activatableChange: arg5 ].
	changesTree := tmp2 yourself.
	self
		addAptitude: (BrLayoutResizerAptitude new inherit: changesTree);
		addChild: changesTree
]
