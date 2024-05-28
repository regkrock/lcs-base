Class {
	#name : #GtPharoBehaviorsNavigationElement,
	#superclass : #BrSimpleTree,
	#traits : 'TGtWithPharoBehaviorsNavigationViewModel',
	#classTraits : 'TGtWithPharoBehaviorsNavigationViewModel classTrait',
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Views'
}

{ #category : #initialization }
GtPharoBehaviorsNavigationElement >> initialize [
	super initialize.
	self
		withoutSelection;
		nodeType: [ :arg1 :arg2 | GtPharoBehaviorNavigationElement ];
		nodeStencil: [ :arg3 | arg3 new ];
		nodeDataBinder: [ :arg4 :arg5 | arg4 pharoBehaviorNavigationViewModel: arg5 value ]
]

{ #category : #'api - pharo behaviors navigation view model' }
GtPharoBehaviorsNavigationElement >> onPharoBehaviorsNavigationViewModelChanged [
	self
		items: self pharoBehaviorsNavigationViewModel pharoBehaviorNavigationViewModels
		lazy: [ :arg1 | #() ]
]
