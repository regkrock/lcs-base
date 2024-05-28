Trait {
	#name : #TGtWithPharoBehaviorNavigationViewModel,
	#instVars : [
		'pharoBehaviorNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - pharo behavior navigation view model' }
TGtWithPharoBehaviorNavigationViewModel >> hasPharoBehaviorNavigationViewModel [
	<return: #Boolean>
	^ pharoBehaviorNavigationViewModel notNil
]

{ #category : #'api - pharo behavior navigation view model' }
TGtWithPharoBehaviorNavigationViewModel >> onPharoBehaviorNavigationViewModelChanged [
	self explicitRequirement
]

{ #category : #'api - pharo behavior navigation view model' }
TGtWithPharoBehaviorNavigationViewModel >> onPostPharoBehaviorNavigationViewModelChanged [
	
]

{ #category : #'api - pharo behavior navigation view model' }
TGtWithPharoBehaviorNavigationViewModel >> pharoBehaviorNavigationViewModel [
	self
		assert: [ pharoBehaviorNavigationViewModel notNil ]
		description: [ 'pharoBehaviorNavigation view model should be initialized' ].
	^ pharoBehaviorNavigationViewModel
]

{ #category : #'api - pharo behavior navigation view model' }
TGtWithPharoBehaviorNavigationViewModel >> pharoBehaviorNavigationViewModel: arg1 [
	self
		assert: [ arg1 notNil ]
		description: [ 'pharoBehaviorNavigation view model must not be nil' ].
	pharoBehaviorNavigationViewModel == arg1 ifTrue: [ ^ self ].
	pharoBehaviorNavigationViewModel
		ifNotNil: [ self unsubscribeFromPharoBehaviorNavigationViewModel ].
	pharoBehaviorNavigationViewModel := arg1.
	self
		onPharoBehaviorNavigationViewModelChanged;
		subscribeToPharoBehaviorNavigationViewModel;
		onPostPharoBehaviorNavigationViewModelChanged
]

{ #category : #'api - pharo behavior navigation view model' }
TGtWithPharoBehaviorNavigationViewModel >> subscribeToPharoBehaviorNavigationViewModel [
	
]

{ #category : #'api - pharo behavior navigation view model' }
TGtWithPharoBehaviorNavigationViewModel >> unsubscribeFromPharoBehaviorNavigationViewModel [
	
]
