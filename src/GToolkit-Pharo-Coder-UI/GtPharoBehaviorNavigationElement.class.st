Class {
	#name : #GtPharoBehaviorNavigationElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtWithPharoBehaviorNavigationViewModel',
	#classTraits : 'TGtWithPharoBehaviorNavigationViewModel classTrait',
	#instVars : [
		'classNameLabel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Views'
}

{ #category : #initialization }
GtPharoBehaviorNavigationElement >> createNameLabel [
	| tmp2 |
	tmp2 := BrLabel new.
	tmp2 aptitude: BrGlamorousLabelAptitude.
	^ tmp2 beSmallSize
]

{ #category : #initialization }
GtPharoBehaviorNavigationElement >> initialize [
	super initialize.
	self
		hMatchParent;
		vFitContent;
		addAptitude: BrGlamorousListItemAptitude.
	classNameLabel := self createNameLabel.
	self
		addChild: classNameLabel;
		when: BlClickEvent
			do: [ :arg1 | 
					arg1 consumed: true.
					arg1 currentTarget pharoBehaviorNavigationViewModel
						selectBehaviorWithoutOtherEntities ]
]

{ #category : #'api - pharo behavior navigation view model' }
GtPharoBehaviorNavigationElement >> onPharoBehaviorNavigationViewModelChanged [
	classNameLabel
		text: self pharoBehaviorNavigationViewModel pharoBehaviorCoderModel name.
	self updateClassSelection
]

{ #category : #'api - pharo behavior navigation view model' }
GtPharoBehaviorNavigationElement >> subscribeToPharoBehaviorNavigationViewModel [
	self pharoBehaviorNavigationViewModel
		when: GtPharoBehaviorNavigationViewModelSelected
				, GtPharoBehaviorNavigationViewModelDeselected
		send: #updateClassSelection
		to: self
]

{ #category : #'api - pharo behavior navigation view model' }
GtPharoBehaviorNavigationElement >> unsubscribeFromPharoBehaviorNavigationViewModel [
	self pharoBehaviorNavigationViewModel unsubscribe: self
]

{ #category : #'private - update' }
GtPharoBehaviorNavigationElement >> updateClassSelection [
	self pharoBehaviorNavigationViewModel isOnlySelectedBehavior
		ifTrue: [ self states addState: BlElementState selected ]
		ifFalse: [ self states removeState: BlElementState selected ]
]
