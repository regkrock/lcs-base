Trait {
	#name : #TGtWithPharoTagNavigationViewModel,
	#instVars : [
		'pharoTagNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - pharo tag navigation view model' }
TGtWithPharoTagNavigationViewModel >> hasPharoTagNavigationViewModel [
	<return: #Boolean>
	^ pharoTagNavigationViewModel notNil
]

{ #category : #'api - pharo tag navigation view model' }
TGtWithPharoTagNavigationViewModel >> onPharoTagNavigationViewModelChanged [
	self explicitRequirement
]

{ #category : #'api - pharo tag navigation view model' }
TGtWithPharoTagNavigationViewModel >> onPostPharoTagNavigationViewModelChanged [
	
]

{ #category : #'api - pharo tag navigation view model' }
TGtWithPharoTagNavigationViewModel >> pharoTagNavigationViewModel [
	self
		assert: [ pharoTagNavigationViewModel notNil ]
		description: [ 'pharoTagNavigation view model should be initialized' ].
	^ pharoTagNavigationViewModel
]

{ #category : #'api - pharo tag navigation view model' }
TGtWithPharoTagNavigationViewModel >> pharoTagNavigationViewModel: arg1 [
	self
		assert: [ arg1 notNil ]
		description: [ 'pharoTagNavigation view model must not be nil' ].
	pharoTagNavigationViewModel == arg1 ifTrue: [ ^ self ].
	pharoTagNavigationViewModel
		ifNotNil: [ self unsubscribeFromPharoTagNavigationViewModel ].
	pharoTagNavigationViewModel := arg1.
	self
		onPharoTagNavigationViewModelChanged;
		subscribeToPharoTagNavigationViewModel;
		onPostPharoTagNavigationViewModelChanged
]

{ #category : #'api - pharo tag navigation view model' }
TGtWithPharoTagNavigationViewModel >> subscribeToPharoTagNavigationViewModel [
	
]

{ #category : #'api - pharo tag navigation view model' }
TGtWithPharoTagNavigationViewModel >> unsubscribeFromPharoTagNavigationViewModel [
	
]
