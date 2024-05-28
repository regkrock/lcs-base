Trait {
	#name : #TGtWithPharoTagsNavigationViewModel,
	#instVars : [
		'pharoTagsNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - pharo tags navigation view model' }
TGtWithPharoTagsNavigationViewModel >> hasPharoTagsNavigationViewModel [
	<return: #Boolean>
	^ pharoTagsNavigationViewModel notNil
]

{ #category : #'api - pharo tags navigation view model' }
TGtWithPharoTagsNavigationViewModel >> onPharoTagsNavigationViewModelChanged [
	self explicitRequirement
]

{ #category : #'api - pharo tags navigation view model' }
TGtWithPharoTagsNavigationViewModel >> onPostPharoTagsNavigationViewModelChanged [
	
]

{ #category : #'api - pharo tags navigation view model' }
TGtWithPharoTagsNavigationViewModel >> pharoTagsNavigationViewModel [
	self
		assert: [ pharoTagsNavigationViewModel notNil ]
		description: [ 'pharoTagsNavigation view model should be initialized' ].
	^ pharoTagsNavigationViewModel
]

{ #category : #'api - pharo tags navigation view model' }
TGtWithPharoTagsNavigationViewModel >> pharoTagsNavigationViewModel: arg1 [
	self
		assert: [ arg1 notNil ]
		description: [ 'pharoTagsNavigation view model must not be nil' ].
	pharoTagsNavigationViewModel == arg1 ifTrue: [ ^ self ].
	pharoTagsNavigationViewModel
		ifNotNil: [ self unsubscribeFromPharoTagsNavigationViewModel ].
	pharoTagsNavigationViewModel := arg1.
	self
		onPharoTagsNavigationViewModelChanged;
		subscribeToPharoTagsNavigationViewModel;
		onPostPharoTagsNavigationViewModelChanged
]

{ #category : #'api - pharo tags navigation view model' }
TGtWithPharoTagsNavigationViewModel >> subscribeToPharoTagsNavigationViewModel [
	
]

{ #category : #'api - pharo tags navigation view model' }
TGtWithPharoTagsNavigationViewModel >> unsubscribeFromPharoTagsNavigationViewModel [
	
]
