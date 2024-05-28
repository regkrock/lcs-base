Class {
	#name : #GtPharoNavigationElement,
	#superclass : #BrPager,
	#traits : 'TGtWithPharoPackagesNavigationViewModel',
	#classTraits : 'TGtWithPharoPackagesNavigationViewModel classTrait',
	#instVars : [
		'packagesPage',
		'packagesNavigationElement',
		'behaivorsNavigationElement',
		'behaviorsPage'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Views'
}

{ #category : #initialization }
GtPharoNavigationElement >> initialize [
	| tmp2 tmp4 |
	super initialize.
	self
		aptitude: BrProportionalHorizontalPagerAptitude;
		matchParent.
	packagesNavigationElement := GtPharoPackagesNavigationElement new.
	behaivorsNavigationElement := GtPharoBehaviorsNavigationElement new.
	tmp2 := BlElement new.
	tmp2
		viewModel: BrPagerPageModel new;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :arg1 | 
				arg1 horizontal matchParent.
				arg1 vertical matchParent ].
	packagesPage := tmp2 addChild: packagesNavigationElement.
	tmp4 := BlElement new.
	tmp4
		viewModel: BrPagerPageModel new;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :arg2 | 
				arg2 horizontal matchParent.
				arg2 vertical matchParent ].
	behaviorsPage := tmp4 addChild: behaivorsNavigationElement.
	self
		addPage: packagesPage;
		addPage: behaviorsPage
]

{ #category : #'private - event handling' }
GtPharoNavigationElement >> onPharoPackageNavigationSelected: arg1 [
	behaivorsNavigationElement
		pharoBehaviorsNavigationViewModel: arg1 packageViewModel pharoBehaviorsNavigationViewModel
]

{ #category : #'api - pharo packages navigation view model' }
GtPharoNavigationElement >> onPharoPackagesNavigationViewModelChanged [
	packagesNavigationElement
		pharoPackagesNavigationViewModel: self pharoPackagesNavigationViewModel
]

{ #category : #'private - event handling' }
GtPharoNavigationElement >> onPharoTagNavigationDeselected: arg1 [
	behaivorsNavigationElement
		pharoBehaviorsNavigationViewModel: arg1 tagViewModel parentPharoTagsNavigationViewModel
				parentPharoPackageNavigationViewModel pharoBehaviorsNavigationViewModel
]

{ #category : #'private - event handling' }
GtPharoNavigationElement >> onPharoTagNavigationSelected: arg1 [
	behaivorsNavigationElement
		pharoBehaviorsNavigationViewModel: arg1 tagViewModel pharoBehaviorsNavigationViewModel
]

{ #category : #'api - pharo packages navigation view model' }
GtPharoNavigationElement >> subscribeToPharoPackagesNavigationViewModel [
	| tmp2 |
	tmp2 := self pharoPackagesNavigationViewModel.
	tmp2
		when: GtPharoTagNavigationViewModelSelected
			send: #onPharoTagNavigationSelected:
			to: self;
		when: GtPharoTagNavigationViewModelDeselected
			send: #onPharoTagNavigationDeselected:
			to: self;
		when: GtPharoPackageNavigationViewModelSelected
			send: #onPharoPackageNavigationSelected:
			to: self
]

{ #category : #'api - pharo packages navigation view model' }
GtPharoNavigationElement >> unsubscribeFromPharoPackagesNavigationViewModel [
	self pharoPackagesNavigationViewModel unsubscribe: self
]
