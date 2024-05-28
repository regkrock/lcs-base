Trait {
	#name : #TGtWithPharoPackagesNavigationViewModel,
	#instVars : [
		'pharoPackagesNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - pharo packages navigation view model' }
TGtWithPharoPackagesNavigationViewModel >> hasPharoPackagesNavigationViewModel [
	<return: #Boolean>
	^ pharoPackagesNavigationViewModel notNil
]

{ #category : #'api - pharo packages navigation view model' }
TGtWithPharoPackagesNavigationViewModel >> onPharoPackagesNavigationViewModelChanged [
	self explicitRequirement
]

{ #category : #'api - pharo packages navigation view model' }
TGtWithPharoPackagesNavigationViewModel >> onPostPharoPackagesNavigationViewModelChanged [
	
]

{ #category : #'api - pharo packages navigation view model' }
TGtWithPharoPackagesNavigationViewModel >> pharoPackagesNavigationViewModel [
	self
		assert: [ pharoPackagesNavigationViewModel notNil ]
		description: [ 'pharoPackagesNavigation view model should be initialized' ].
	^ pharoPackagesNavigationViewModel
]

{ #category : #'api - pharo packages navigation view model' }
TGtWithPharoPackagesNavigationViewModel >> pharoPackagesNavigationViewModel: arg1 [
	self
		assert: [ arg1 notNil ]
		description: [ 'pharoPackagesNavigation view model must not be nil' ].
	pharoPackagesNavigationViewModel == arg1 ifTrue: [ ^ self ].
	pharoPackagesNavigationViewModel
		ifNotNil: [ self unsubscribeFromPharoPackagesNavigationViewModel ].
	pharoPackagesNavigationViewModel := arg1.
	self
		onPharoPackagesNavigationViewModelChanged;
		subscribeToPharoPackagesNavigationViewModel;
		onPostPharoPackagesNavigationViewModelChanged
]

{ #category : #'api - pharo packages navigation view model' }
TGtWithPharoPackagesNavigationViewModel >> subscribeToPharoPackagesNavigationViewModel [
	
]

{ #category : #'api - pharo packages navigation view model' }
TGtWithPharoPackagesNavigationViewModel >> unsubscribeFromPharoPackagesNavigationViewModel [
	
]
