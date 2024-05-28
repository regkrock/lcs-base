Trait {
	#name : #TGtWithPharoBehaviorProtocolCoderViewModel,
	#instVars : [
		'pharoBehaviorProtocolCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! View Models'
}

{ #category : #'api - pharo behavior protocol coder view model' }
TGtWithPharoBehaviorProtocolCoderViewModel >> hasPharoBehaviorProtocolCoderViewModel [
	<return: #Boolean>
	^ pharoBehaviorProtocolCoderViewModel notNil
]

{ #category : #'api - pharo behavior protocol coder view model' }
TGtWithPharoBehaviorProtocolCoderViewModel >> onPharoBehaviorProtocolCoderViewModelChanged [
	self explicitRequirement
]

{ #category : #'api - pharo behavior protocol coder view model' }
TGtWithPharoBehaviorProtocolCoderViewModel >> onPostPharoBehaviorProtocolCoderViewModelChanged [
	
]

{ #category : #'api - pharo behavior protocol coder view model' }
TGtWithPharoBehaviorProtocolCoderViewModel >> pharoBehaviorProtocolCoderViewModel [
	self
		assert: [ pharoBehaviorProtocolCoderViewModel notNil ]
		description: [ 'pharoBehaviorProtocolCoder view model should be initialized' ].
	^ pharoBehaviorProtocolCoderViewModel
]

{ #category : #'api - pharo behavior protocol coder view model' }
TGtWithPharoBehaviorProtocolCoderViewModel >> pharoBehaviorProtocolCoderViewModel: arg1 [
	self
		assert: [ arg1 notNil ]
		description: [ 'pharoBehaviorProtocolCoder view model must not be nil' ].
	pharoBehaviorProtocolCoderViewModel == arg1 ifTrue: [ ^ self ].
	pharoBehaviorProtocolCoderViewModel
		ifNotNil: [ self unsubscribeFromPharoBehaviorProtocolCoderViewModel ].
	pharoBehaviorProtocolCoderViewModel := arg1.
	self
		onPharoBehaviorProtocolCoderViewModelChanged;
		subscribeToPharoBehaviorProtocolCoderViewModel;
		onPostPharoBehaviorProtocolCoderViewModelChanged
]

{ #category : #'api - pharo behavior protocol coder view model' }
TGtWithPharoBehaviorProtocolCoderViewModel >> subscribeToPharoBehaviorProtocolCoderViewModel [
	
]

{ #category : #'api - pharo behavior protocol coder view model' }
TGtWithPharoBehaviorProtocolCoderViewModel >> unsubscribeFromPharoBehaviorProtocolCoderViewModel [
	
]
