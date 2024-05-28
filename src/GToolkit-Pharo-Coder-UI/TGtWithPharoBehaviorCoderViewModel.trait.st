Trait {
	#name : #TGtWithPharoBehaviorCoderViewModel,
	#instVars : [
		'pharoBehaviorCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! View Models'
}

{ #category : #'api - pharo behavior coder view model' }
TGtWithPharoBehaviorCoderViewModel >> hasPharoBehaviorCoderViewModel [
	<return: #Boolean>
	^ pharoBehaviorCoderViewModel notNil
]

{ #category : #'api - pharo behavior coder view model' }
TGtWithPharoBehaviorCoderViewModel >> onPharoBehaviorCoderViewModelChanged [
	self explicitRequirement
]

{ #category : #'api - pharo behavior coder view model' }
TGtWithPharoBehaviorCoderViewModel >> onPostPharoBehaviorCoderViewModelChanged [
	
]

{ #category : #'api - pharo behavior coder view model' }
TGtWithPharoBehaviorCoderViewModel >> pharoBehaviorCoderViewModel [
	self
		assert: [ pharoBehaviorCoderViewModel notNil ]
		description: [ 'pharoBehaviorCoder view model should be initialized' ].
	^ pharoBehaviorCoderViewModel
]

{ #category : #'api - pharo behavior coder view model' }
TGtWithPharoBehaviorCoderViewModel >> pharoBehaviorCoderViewModel: arg1 [
	self
		assert: [ arg1 notNil ]
		description: [ 'pharoBehaviorCoder view model must not be nil' ].
	pharoBehaviorCoderViewModel == arg1 ifTrue: [ ^ self ].
	pharoBehaviorCoderViewModel
		ifNotNil: [ self unsubscribeFromPharoBehaviorCoderViewModel ].
	pharoBehaviorCoderViewModel := arg1.
	self
		onPharoBehaviorCoderViewModelChanged;
		subscribeToPharoBehaviorCoderViewModel;
		onPostPharoBehaviorCoderViewModelChanged
]

{ #category : #'api - pharo behavior coder view model' }
TGtWithPharoBehaviorCoderViewModel >> subscribeToPharoBehaviorCoderViewModel [
	
]

{ #category : #'api - pharo behavior coder view model' }
TGtWithPharoBehaviorCoderViewModel >> unsubscribeFromPharoBehaviorCoderViewModel [
	
]
