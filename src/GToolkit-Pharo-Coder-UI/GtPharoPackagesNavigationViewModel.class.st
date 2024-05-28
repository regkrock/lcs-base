Class {
	#name : #GtPharoPackagesNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackagesCoderModel + TGtPharoWithSelectedPackageViewModel',
	#classTraits : 'TGtWithPharoPackagesCoderModel classTrait + TGtPharoWithSelectedPackageViewModel classTrait',
	#instVars : [
		'announcer',
		'pharoPackageNavigationViewModels'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - announcer' }
GtPharoPackagesNavigationViewModel >> announce: arg1 [
	| tmp1 |
	(tmp1 := announcer) ifNotNil: [ tmp1 announce: arg1 ]
]

{ #category : #'private - instance creation' }
GtPharoPackagesNavigationViewModel >> createPharoPackageNavigationViewModels [
	<return: #Collection of: #GtPharoPackageNavigationViewModel>
	^ self pharoPackagesCoderModel coders
		collect: [ :arg1 | 
			| tmp1 |
			tmp1 := GtPharoPackageNavigationViewModel new.
			tmp1
				parentPharoPackagesNavigationViewModel: self;
				pharoPackageCoderModel: arg1 ]
		as: Array
]

{ #category : #'gt-extentions' }
GtPharoPackagesNavigationViewModel >> gtPackagesListViewFor: arg1 [
	<gtView>
	| tmp2 |
	tmp2 := arg1 list.
	tmp2
		priority: 5;
		title: 'Packages'.
	^ tmp2 items: [ self pharoPackageNavigationViewModels ]
]

{ #category : #'api - testing' }
GtPharoPackagesNavigationViewModel >> isPharoBehaviorNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoPackagesNavigationViewModel >> isPharoBehaviorsNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoPackagesNavigationViewModel >> isPharoPackageNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoPackagesNavigationViewModel >> isPharoPackagesNavigationViewModel [
	<return: #Boolean>
	^ true
]

{ #category : #'api - testing' }
GtPharoPackagesNavigationViewModel >> isPharoTagNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoPackagesNavigationViewModel >> isPharoTagsNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - selected package view model' }
GtPharoPackagesNavigationViewModel >> notifySelectedPackageViewModelChanged [
	<propertyChangeNotifier: #selectedPackageViewModel>
	self announce: GtPharoNavigationSelectedPackageViewModelChanged new
]

{ #category : #'api - selected package view model' }
GtPharoPackagesNavigationViewModel >> onNewSelectedPackageViewModelSet: arg1 [
	<propertySetHook: #selectedPackageViewModel>
	arg1 notifyPackageSelected
]

{ #category : #'api - selected package view model' }
GtPharoPackagesNavigationViewModel >> onPreviousSelectedPackageViewModelUnset: arg1 [
	<propertyUnsetHook: #selectedPackageViewModel>
	arg1
		deselectOtherEntities;
		notifyPackageDeselected
]

{ #category : #'api - accessing' }
GtPharoPackagesNavigationViewModel >> pharoPackageNavigationViewModels [
	<return: #Collection of: #GtPharoPackageNavigationViewModel>
	^ pharoPackageNavigationViewModels
		ifNil: [ pharoPackageNavigationViewModels := self
					createPharoPackageNavigationViewModels ]
		ifNotNil: [ pharoPackageNavigationViewModels ]
]

{ #category : #printing }
GtPharoPackagesNavigationViewModel >> printOn: arg1 [
	arg1 print: self pharoPackagesCoderModel
]

{ #category : #'api - announcer' }
GtPharoPackagesNavigationViewModel >> unsubscribe: arg1 [
	| tmp1 tmp3 |
	tmp3 := tmp1 := announcer.
	^ tmp3 ifNotNil: [ tmp1 unsubscribe: arg1 ]
]

{ #category : #'api - accessing' }
GtPharoPackagesNavigationViewModel >> viewModelName [
	<return: #Symbol>
	^ #packages
]

{ #category : #'api - announcer' }
GtPharoPackagesNavigationViewModel >> when: arg1 do: arg2 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ])
		when: arg1
		do: arg2
]

{ #category : #'api - announcer' }
GtPharoPackagesNavigationViewModel >> when: arg1 send: arg2 to: arg3 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ]) weak
		when: arg1
		send: arg2
		to: arg3
]
