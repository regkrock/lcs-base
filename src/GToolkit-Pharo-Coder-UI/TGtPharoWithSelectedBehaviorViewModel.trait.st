Trait {
	#name : #TGtPharoWithSelectedBehaviorViewModel,
	#instVars : [
		'selectedBehaviorViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - selected behavior view model' }
TGtPharoWithSelectedBehaviorViewModel >> deselectBehaviorViewModel [
	<propertyUnsetter: #selectedBehaviorViewModel>
	| tmp1 |
	selectedBehaviorViewModel ifNil: [ ^ self ].
	tmp1 := selectedBehaviorViewModel.
	selectedBehaviorViewModel := nil.
	self
		onPreviousSelectedBehaviorViewModelUnset: tmp1;
		notifySelectedBehaviorViewModelChanged
]

{ #category : #'api - selected behavior view model' }
TGtPharoWithSelectedBehaviorViewModel >> hasSelectedBehaviorViewModel [
	<return: #Boolean>
	<propertyTester: #selectedBehaviorViewModel>
	^ selectedBehaviorViewModel notNil
]

{ #category : #'api - selected behavior view model' }
TGtPharoWithSelectedBehaviorViewModel >> notifySelectedBehaviorViewModelChanged [
	<propertyChangeNotifier: #selectedBehaviorViewModel>
	
]

{ #category : #'api - selected behavior view model' }
TGtPharoWithSelectedBehaviorViewModel >> onNewSelectedBehaviorViewModelSet: arg1 [
	<propertySetHook: #selectedBehaviorViewModel>
	
]

{ #category : #'api - selected behavior view model' }
TGtPharoWithSelectedBehaviorViewModel >> onPreviousSelectedBehaviorViewModelUnset: arg1 [
	<propertyUnsetHook: #selectedBehaviorViewModel>
	
]

{ #category : #'api - selected behavior view model' }
TGtPharoWithSelectedBehaviorViewModel >> selectBehaviorViewModel: arg1 [
	<propertySetter: #selectedBehaviorViewModel>
	| tmp1 |
	self selectedBehaviorViewModel = arg1 ifTrue: [ ^ self ].
	self hasSelectedBehaviorViewModel
		ifTrue: [ tmp1 := selectedBehaviorViewModel.
			selectedBehaviorViewModel := nil.
			self onPreviousSelectedBehaviorViewModelUnset: tmp1 ].
	selectedBehaviorViewModel := arg1.
	self
		onNewSelectedBehaviorViewModelSet: arg1;
		notifySelectedBehaviorViewModelChanged
]

{ #category : #'api - selected behavior view model' }
TGtPharoWithSelectedBehaviorViewModel >> selectedBehaviorViewModel [
	<return: #GtPharoBehaviorNavigationViewModel>
	<propertyGetter: #selectedBehaviorViewModel>
	^ selectedBehaviorViewModel
]
