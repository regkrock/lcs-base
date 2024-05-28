Trait {
	#name : #TGtPharoWithSelectedPackageViewModel,
	#instVars : [
		'selectedPackageViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - selected package view model' }
TGtPharoWithSelectedPackageViewModel >> deselectPackageViewModel [
	<propertyUnsetter: #selectedPackageViewModel>
	| tmp1 |
	selectedPackageViewModel ifNil: [ ^ self ].
	tmp1 := selectedPackageViewModel.
	selectedPackageViewModel := nil.
	self
		onPreviousSelectedPackageViewModelUnset: tmp1;
		notifySelectedPackageViewModelChanged
]

{ #category : #'api - selected package view model' }
TGtPharoWithSelectedPackageViewModel >> hasSelectedPackageViewModel [
	<return: #Boolean>
	<propertyTester: #selectedPackageViewModel>
	^ selectedPackageViewModel notNil
]

{ #category : #'api - selected package view model' }
TGtPharoWithSelectedPackageViewModel >> notifySelectedPackageViewModelChanged [
	<propertyChangeNotifier: #selectedPackageViewModel>
	
]

{ #category : #'api - selected package view model' }
TGtPharoWithSelectedPackageViewModel >> onNewSelectedPackageViewModelSet: arg1 [
	<propertySetHook: #selectedPackageViewModel>
	
]

{ #category : #'api - selected package view model' }
TGtPharoWithSelectedPackageViewModel >> onPreviousSelectedPackageViewModelUnset: arg1 [
	<propertyUnsetHook: #selectedPackageViewModel>
	
]

{ #category : #'api - selected package view model' }
TGtPharoWithSelectedPackageViewModel >> selectPackageViewModel: arg1 [
	<propertySetter: #selectedPackageViewModel>
	| tmp1 |
	self selectedPackageViewModel = arg1 ifTrue: [ ^ self ].
	self hasSelectedPackageViewModel
		ifTrue: [ tmp1 := selectedPackageViewModel.
			selectedPackageViewModel := nil.
			self onPreviousSelectedPackageViewModelUnset: tmp1 ].
	selectedPackageViewModel := arg1.
	self
		onNewSelectedPackageViewModelSet: arg1;
		notifySelectedPackageViewModelChanged
]

{ #category : #'api - selected package view model' }
TGtPharoWithSelectedPackageViewModel >> selectedPackageViewModel [
	<return: #GtPharoPackageNavigationViewModel>
	<propertyGetter: #selectedPackageViewModel>
	^ selectedPackageViewModel
]
