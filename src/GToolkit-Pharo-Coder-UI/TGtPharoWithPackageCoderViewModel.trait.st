Trait {
	#name : #TGtPharoWithPackageCoderViewModel,
	#instVars : [
		'packageCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-View Models'
}

{ #category : #'api - package coder view model' }
TGtPharoWithPackageCoderViewModel >> hasPackageCoderViewModel [
	<return: #Boolean>
	^ packageCoderViewModel notNil
]

{ #category : #'api - package coder view model' }
TGtPharoWithPackageCoderViewModel >> onPackageCoderViewModelChanged [
	self explicitRequirement
]

{ #category : #'api - package coder view model' }
TGtPharoWithPackageCoderViewModel >> onPostPackageCoderViewModelChanged [
	
]

{ #category : #'api - package coder view model' }
TGtPharoWithPackageCoderViewModel >> packageCoderViewModel [
	self
		assert: [ packageCoderViewModel notNil ]
		description: [ 'packageCoder view model should be initialized' ].
	^ packageCoderViewModel
]

{ #category : #'api - package coder view model' }
TGtPharoWithPackageCoderViewModel >> packageCoderViewModel: arg1 [
	<viewModelSetter>
	self
		assert: [ arg1 notNil ]
		description: [ 'packageCoder view model must not be nil' ].
	packageCoderViewModel == arg1 ifTrue: [ ^ self ].
	packageCoderViewModel ifNotNil: [ self unsubscribeFromPackageCoderViewModel ].
	packageCoderViewModel := arg1.
	self
		onPackageCoderViewModelChanged;
		subscribeToPackageCoderViewModel;
		onPostPackageCoderViewModelChanged
]

{ #category : #'api - package coder view model' }
TGtPharoWithPackageCoderViewModel >> subscribeToPackageCoderViewModel [
	
]

{ #category : #'api - package coder view model' }
TGtPharoWithPackageCoderViewModel >> unsubscribeFromPackageCoderViewModel [
	
]
