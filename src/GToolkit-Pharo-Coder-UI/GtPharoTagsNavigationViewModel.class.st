Class {
	#name : #GtPharoTagsNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackageTagsCoderModel + TGtPharoWithSelectedTagViewModel',
	#classTraits : 'TGtWithPharoPackageTagsCoderModel classTrait + TGtPharoWithSelectedTagViewModel classTrait',
	#instVars : [
		'announcer',
		'pharoTagNavigationViewModels',
		'parentPharoPackageNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - announcer' }
GtPharoTagsNavigationViewModel >> announce: arg1 [
	| tmp1 |
	(tmp1 := announcer) ifNotNil: [ tmp1 announce: arg1 ].
	self hasParentPharoPackageNavigationViewModel
		ifTrue: [ self parentPharoPackageNavigationViewModel announce: arg1 ]
]

{ #category : #'private - instance creation' }
GtPharoTagsNavigationViewModel >> createPharoTagNavigationViewModels [
	<return: #Collection of: #GtPharoTagNavigationViewModel>
	^ self pharoPackageTagsCoderModel coders
		collect: [ :arg1 | 
			| tmp1 |
			tmp1 := GtPharoTagNavigationViewModel new.
			tmp1
				parentPharoTagsNavigationViewModel: self;
				pharoPackageTagCoderModel: arg1 ]
		as: Array
]

{ #category : #'gt-extentions' }
GtPharoTagsNavigationViewModel >> gtTagsListViewFor: arg1 [
	<gtView>
	| tmp2 |
	tmp2 := arg1 list.
	tmp2
		priority: 5;
		title: 'Tags'.
	^ tmp2 items: [ self pharoTagNavigationViewModels ]
]

{ #category : #'api - accessing' }
GtPharoTagsNavigationViewModel >> hasParentPharoPackageNavigationViewModel [
	<return: #Boolean>
	<parentViewModelTester: #package>
	^ parentPharoPackageNavigationViewModel notNil
]

{ #category : #'api - testing' }
GtPharoTagsNavigationViewModel >> isPharoBehaviorNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoTagsNavigationViewModel >> isPharoBehaviorsNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoTagsNavigationViewModel >> isPharoPackageNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoTagsNavigationViewModel >> isPharoPackagesNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoTagsNavigationViewModel >> isPharoTagNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoTagsNavigationViewModel >> isPharoTagsNavigationViewModel [
	<return: #Boolean>
	^ true
]

{ #category : #'api - selected tag view model' }
GtPharoTagsNavigationViewModel >> notifySelectedTagViewModelChanged [
	<propertyChangeNotifier: #selectedTagViewModel>
	self announce: GtPharoNavigationSelectedTagViewModelChanged new
]

{ #category : #'api - selected tag view model' }
GtPharoTagsNavigationViewModel >> onNewSelectedTagViewModelSet: arg1 [
	<propertySetHook: #selectedTagViewModel>
	self hasParentPharoPackageNavigationViewModel
		ifTrue: [ self parentPharoPackageNavigationViewModel selectPackageWithExtension ].
	arg1 notifyTagSelected
]

{ #category : #'api - selected tag view model' }
GtPharoTagsNavigationViewModel >> onPreviousSelectedTagViewModelUnset: arg1 [
	<propertyUnsetHook: #selectedTagViewModel>
	arg1
		deselectOtherEntities;
		notifyTagDeselected
]

{ #category : #'api - accessing' }
GtPharoTagsNavigationViewModel >> parentPharoPackageNavigationViewModel [
	<return: #GtPharoPackageNavigationViewModel>
	<parentViewModelGetter: #package>
	self
		assert: [ parentPharoPackageNavigationViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].
	^ parentPharoPackageNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoTagsNavigationViewModel >> parentPharoPackageNavigationViewModel: arg1 [
	<parentViewModelSetter: #package>
	self
		assert: [ arg1 notNil ]
		description: [ 'Parent view model must not be nil' ].
	parentPharoPackageNavigationViewModel := arg1
]

{ #category : #'api - accessing' }
GtPharoTagsNavigationViewModel >> pharoTagNavigationViewModels [
	<return: #Collection of: #GtPharoTagNavigationViewModel>
	^ pharoTagNavigationViewModels
		ifNil: [ pharoTagNavigationViewModels := self createPharoTagNavigationViewModels ]
		ifNotNil: [ pharoTagNavigationViewModels ]
]

{ #category : #printing }
GtPharoTagsNavigationViewModel >> printOn: arg1 [
	arg1 print: self pharoPackageTagsCoderModel
]

{ #category : #'api - announcer' }
GtPharoTagsNavigationViewModel >> unsubscribe: arg1 [
	| tmp1 tmp3 |
	tmp3 := tmp1 := announcer.
	^ tmp3 ifNotNil: [ tmp1 unsubscribe: arg1 ]
]

{ #category : #'api - accessing' }
GtPharoTagsNavigationViewModel >> viewModelName [
	<return: #Symbol>
	^ #tags
]

{ #category : #'api - announcer' }
GtPharoTagsNavigationViewModel >> when: arg1 do: arg2 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ])
		when: arg1
		do: arg2
]

{ #category : #'api - announcer' }
GtPharoTagsNavigationViewModel >> when: arg1 send: arg2 to: arg3 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ]) weak
		when: arg1
		send: arg2
		to: arg3
]
