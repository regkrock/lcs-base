Trait {
	#name : #TGtWithPharoBehaviorsNavigationViewModel,
	#instVars : [
		'pharoBehaviorsNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - pharo behaviors navigation view model' }
TGtWithPharoBehaviorsNavigationViewModel >> hasPharoBehaviorsNavigationViewModel [
	<return: #Boolean>
	^ pharoBehaviorsNavigationViewModel notNil
]

{ #category : #'api - pharo behaviors navigation view model' }
TGtWithPharoBehaviorsNavigationViewModel >> onPharoBehaviorsNavigationViewModelChanged [
	self explicitRequirement
]

{ #category : #'api - pharo behaviors navigation view model' }
TGtWithPharoBehaviorsNavigationViewModel >> onPostPharoBehaviorsNavigationViewModelChanged [
	
]

{ #category : #'api - pharo behaviors navigation view model' }
TGtWithPharoBehaviorsNavigationViewModel >> pharoBehaviorsNavigationViewModel [
	self
		assert: [ pharoBehaviorsNavigationViewModel notNil ]
		description: [ 'pharoBehaviorsNavigation view model should be initialized' ].
	^ pharoBehaviorsNavigationViewModel
]

{ #category : #'api - pharo behaviors navigation view model' }
TGtWithPharoBehaviorsNavigationViewModel >> pharoBehaviorsNavigationViewModel: arg1 [
	self
		assert: [ arg1 notNil ]
		description: [ 'pharoBehaviorsNavigation view model must not be nil' ].
	pharoBehaviorsNavigationViewModel == arg1 ifTrue: [ ^ self ].
	pharoBehaviorsNavigationViewModel
		ifNotNil: [ self unsubscribeFromPharoBehaviorsNavigationViewModel ].
	pharoBehaviorsNavigationViewModel := arg1.
	self
		onPharoBehaviorsNavigationViewModelChanged;
		subscribeToPharoBehaviorsNavigationViewModel;
		onPostPharoBehaviorsNavigationViewModelChanged
]

{ #category : #'api - pharo behaviors navigation view model' }
TGtWithPharoBehaviorsNavigationViewModel >> subscribeToPharoBehaviorsNavigationViewModel [
	
]

{ #category : #'api - pharo behaviors navigation view model' }
TGtWithPharoBehaviorsNavigationViewModel >> unsubscribeFromPharoBehaviorsNavigationViewModel [
	
]
