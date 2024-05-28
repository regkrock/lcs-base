Trait {
	#name : #TGtWithPharoPackageNavigationViewModel,
	#instVars : [
		'pharoPackageNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - pharo package navigation view model' }
TGtWithPharoPackageNavigationViewModel >> hasPharoPackageNavigationViewModel [
	<return: #Boolean>
	^ pharoPackageNavigationViewModel notNil
]

{ #category : #'api - pharo package navigation view model' }
TGtWithPharoPackageNavigationViewModel >> onPharoPackageNavigationViewModelChanged [
	self explicitRequirement
]

{ #category : #'api - pharo package navigation view model' }
TGtWithPharoPackageNavigationViewModel >> onPostPharoPackageNavigationViewModelChanged [
	
]

{ #category : #'api - pharo package navigation view model' }
TGtWithPharoPackageNavigationViewModel >> pharoPackageNavigationViewModel [
	self
		assert: [ pharoPackageNavigationViewModel notNil ]
		description: [ 'pharoPackageNavigation view model should be initialized' ].
	^ pharoPackageNavigationViewModel
]

{ #category : #'api - pharo package navigation view model' }
TGtWithPharoPackageNavigationViewModel >> pharoPackageNavigationViewModel: arg1 [
	self
		assert: [ arg1 notNil ]
		description: [ 'pharoPackageNavigation view model must not be nil' ].
	pharoPackageNavigationViewModel == arg1 ifTrue: [ ^ self ].
	pharoPackageNavigationViewModel
		ifNotNil: [ self unsubscribeFromPharoPackageNavigationViewModel ].
	pharoPackageNavigationViewModel := arg1.
	self
		onPharoPackageNavigationViewModelChanged;
		subscribeToPharoPackageNavigationViewModel;
		onPostPharoPackageNavigationViewModelChanged
]

{ #category : #'api - pharo package navigation view model' }
TGtWithPharoPackageNavigationViewModel >> subscribeToPharoPackageNavigationViewModel [
	
]

{ #category : #'api - pharo package navigation view model' }
TGtWithPharoPackageNavigationViewModel >> unsubscribeFromPharoPackageNavigationViewModel [
	
]
