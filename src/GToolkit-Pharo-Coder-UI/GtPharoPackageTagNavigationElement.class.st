Class {
	#name : #GtPharoPackageTagNavigationElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtWithPharoTagNavigationViewModel',
	#classTraits : 'TGtWithPharoTagNavigationViewModel classTrait',
	#instVars : [
		'packageTagNameLabel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Views'
}

{ #category : #initialization }
GtPharoPackageTagNavigationElement >> createPackageTagNameLabel [
	| tmp2 |
	tmp2 := BrLabel new.
	tmp2 aptitude: BrGlamorousLabelAptitude.
	^ tmp2 beSmallSize
]

{ #category : #initialization }
GtPharoPackageTagNavigationElement >> initialize [
	super initialize.
	self
		hMatchParent;
		vFitContent;
		addAptitude: BrGlamorousListItemAptitude.
	packageTagNameLabel := self createPackageTagNameLabel.
	self
		addChild: packageTagNameLabel;
		when: BlClickEvent
			do: [ :arg1 | 
					arg1 consumed: true.
					arg1 currentTarget pharoTagNavigationViewModel
						selectTagWithoutOtherEntities ]
]

{ #category : #'api - pharo tag navigation view model' }
GtPharoPackageTagNavigationElement >> onPharoTagNavigationViewModelChanged [
	packageTagNameLabel
		text: self pharoTagNavigationViewModel pharoPackageTagCoderModel packageTagName.
	self updateTagSelection
]

{ #category : #'api - pharo tag navigation view model' }
GtPharoPackageTagNavigationElement >> subscribeToPharoTagNavigationViewModel [
	self pharoTagNavigationViewModel
		when: GtPharoTagNavigationViewModelSelected
				, GtPharoTagNavigationViewModelDeselected
		send: #updateTagSelection
		to: self
]

{ #category : #'api - pharo tag navigation view model' }
GtPharoPackageTagNavigationElement >> unsubscribeFromPharoTagNavigationViewModel [
	self pharoTagNavigationViewModel unsubscribe: self
]

{ #category : #'private - update' }
GtPharoPackageTagNavigationElement >> updateTagSelection [
	self pharoTagNavigationViewModel isSelectedTag
		ifTrue: [ self states addState: BlElementState selected ]
		ifFalse: [ self states removeState: BlElementState selected ]
]
