Trait {
	#name : #TGtPharoWithSelectedTagViewModel,
	#instVars : [
		'selectedTagViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - selected tag view model' }
TGtPharoWithSelectedTagViewModel >> deselectTagViewModel [
	<propertyUnsetter: #selectedTagViewModel>
	| tmp1 |
	selectedTagViewModel ifNil: [ ^ self ].
	tmp1 := selectedTagViewModel.
	selectedTagViewModel := nil.
	self
		onPreviousSelectedTagViewModelUnset: tmp1;
		notifySelectedTagViewModelChanged
]

{ #category : #'api - selected tag view model' }
TGtPharoWithSelectedTagViewModel >> hasSelectedTagViewModel [
	<return: #Boolean>
	<propertyTester: #selectedTagViewModel>
	^ selectedTagViewModel notNil
]

{ #category : #'api - selected tag view model' }
TGtPharoWithSelectedTagViewModel >> notifySelectedTagViewModelChanged [
	<propertyChangeNotifier: #selectedTagViewModel>
	
]

{ #category : #'api - selected tag view model' }
TGtPharoWithSelectedTagViewModel >> onNewSelectedTagViewModelSet: arg1 [
	<propertySetHook: #selectedTagViewModel>
	
]

{ #category : #'api - selected tag view model' }
TGtPharoWithSelectedTagViewModel >> onPreviousSelectedTagViewModelUnset: arg1 [
	<propertyUnsetHook: #selectedTagViewModel>
	
]

{ #category : #'api - selected tag view model' }
TGtPharoWithSelectedTagViewModel >> selectTagViewModel: arg1 [
	<propertySetter: #selectedTagViewModel>
	| tmp1 |
	self selectedTagViewModel = arg1 ifTrue: [ ^ self ].
	self hasSelectedTagViewModel
		ifTrue: [ tmp1 := selectedTagViewModel.
			selectedTagViewModel := nil.
			self onPreviousSelectedTagViewModelUnset: tmp1 ].
	selectedTagViewModel := arg1.
	self
		onNewSelectedTagViewModelSet: arg1;
		notifySelectedTagViewModelChanged
]

{ #category : #'api - selected tag view model' }
TGtPharoWithSelectedTagViewModel >> selectedTagViewModel [
	<return: #GtPharoTagNavigationViewModel>
	<propertyGetter: #selectedTagViewModel>
	^ selectedTagViewModel
]
