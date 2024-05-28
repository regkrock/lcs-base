Class {
	#name : #GtPharoPackageNavigationElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtWithPharoPackageNavigationViewModel',
	#classTraits : 'TGtWithPharoPackageNavigationViewModel classTrait',
	#instVars : [
		'packageNameLabel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Views'
}

{ #category : #initialization }
GtPharoPackageNavigationElement >> createPackageNameLabel [
	| tmp2 |
	tmp2 := BrLabel new.
	tmp2 aptitude: BrGlamorousLabelAptitude.
	^ tmp2 beSmallSize
]

{ #category : #initialization }
GtPharoPackageNavigationElement >> initialize [
	super initialize.
	self
		hMatchParent;
		vFitContent;
		addAptitude: BrGlamorousListItemAptitude.
	packageNameLabel := self createPackageNameLabel.
	self
		addChild: packageNameLabel;
		when: BlClickEvent
			do: [ :arg1 | 
					arg1 consumed: true.
					arg1 currentTarget pharoPackageNavigationViewModel
						selectPackageWithoutOtherEntities ]
]

{ #category : #'api - pharo package navigation view model' }
GtPharoPackageNavigationElement >> onPharoPackageNavigationViewModelChanged [
	packageNameLabel
		text: self pharoPackageNavigationViewModel pharoPackageCoderModel packageName.
	self updatePackageSelection
]

{ #category : #'api - pharo package navigation view model' }
GtPharoPackageNavigationElement >> subscribeToPharoPackageNavigationViewModel [
	self pharoPackageNavigationViewModel
		when: GtPharoPackageNavigationViewModelSelected
				, GtPharoPackageNavigationViewModelDeselected
		send: #updatePackageSelection
		to: self.
	self pharoPackageNavigationViewModel pharoTagsNavigationViewModel
		when: GtPharoNavigationSelectedTagViewModelChanged
		send: #updatePackageSelection
		to: self
]

{ #category : #'api - pharo package navigation view model' }
GtPharoPackageNavigationElement >> unsubscribeFromPharoPackageNavigationViewModel [
	self pharoPackageNavigationViewModel unsubscribe: self.
	self pharoPackageNavigationViewModel pharoTagsNavigationViewModel
		unsubscribe: self
]

{ #category : #'private - update' }
GtPharoPackageNavigationElement >> updatePackageSelection [
	self pharoPackageNavigationViewModel isOnlySelectedPackage
		ifTrue: [ self states addState: BlElementState selected ]
		ifFalse: [ self states removeState: BlElementState selected ]
]
