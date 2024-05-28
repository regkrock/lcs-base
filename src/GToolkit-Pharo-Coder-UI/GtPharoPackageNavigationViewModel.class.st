Class {
	#name : #GtPharoPackageNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackageCoderModel',
	#classTraits : 'TGtWithPharoPackageCoderModel classTrait',
	#instVars : [
		'announcer',
		'pharoBehaviorsNavigationViewModel',
		'pharoTagsNavigationViewModel',
		'parentPharoPackagesNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - announcer' }
GtPharoPackageNavigationViewModel >> announce: arg1 [
	| tmp1 |
	(tmp1 := announcer) ifNotNil: [ tmp1 announce: arg1 ].
	self hasParentPharoPackagesNavigationViewModel
		ifTrue: [ self parentPharoPackagesNavigationViewModel announce: arg1 ]
]

{ #category : #'private - instance creation' }
GtPharoPackageNavigationViewModel >> createPharoBehaviorsNavigationViewModel [
	<return: #GtPharoBehaviorsNavigationViewModel>
	| tmp1 |
	tmp1 := GtPharoBehaviorsNavigationViewModel new.
	tmp1
		parentPharoPackageNavigationViewModel: self;
		pharoClassesCoderModel: self pharoPackageCoderModel classesCoder.
	^ tmp1
]

{ #category : #'private - instance creation' }
GtPharoPackageNavigationViewModel >> createPharoTagsNavigationViewModel [
	<return: #GtPharoTagsNavigationViewModel>
	| tmp1 |
	tmp1 := GtPharoTagsNavigationViewModel new.
	tmp1
		parentPharoPackageNavigationViewModel: self;
		pharoPackageTagsCoderModel: self pharoPackageCoderModel packageTagsCoder.
	^ tmp1
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> deselectOtherEntities [
	<propertyUnsetOthers: #selectedPackageViewModel>
	self pharoBehaviorsNavigationViewModel deselectBehaviorViewModel.
	self pharoTagsNavigationViewModel deselectTagViewModel
]

{ #category : #'gt-extentions' }
GtPharoPackageNavigationViewModel >> gtBehaviorsListViewFor: arg1 [
	<gtView>
	| tmp2 |
	tmp2 := arg1 list.
	tmp2
		priority: 5;
		title: 'Behaviors'.
	^ tmp2
		items: [ self pharoBehaviorsNavigationViewModel pharoBehaviorNavigationViewModels ]
]

{ #category : #'gt-extentions' }
GtPharoPackageNavigationViewModel >> gtTagsListViewFor: arg1 [
	<gtView>
	| tmp2 |
	tmp2 := arg1 list.
	tmp2
		priority: 5;
		title: 'Tags'.
	^ tmp2
		items: [ self pharoTagsNavigationViewModel pharoTagNavigationViewModels ]
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> hasOtherSelectedEntities [
	<return: #Boolean>
	<propertyTestOthers: #selectedPackageViewModel>
	^ self pharoBehaviorsNavigationViewModel hasSelectedBehaviorViewModel
		or: [ self pharoTagsNavigationViewModel hasSelectedTagViewModel ]
]

{ #category : #'api - accessing' }
GtPharoPackageNavigationViewModel >> hasParentPharoPackagesNavigationViewModel [
	<return: #Boolean>
	<parentViewModelTester: #packages>
	^ parentPharoPackagesNavigationViewModel notNil
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> isOnlySelectedPackage [
	<return: #Boolean>
	^ self isSelectedPackage and: [ self hasOtherSelectedEntities not ]
]

{ #category : #'api - testing' }
GtPharoPackageNavigationViewModel >> isPharoBehaviorNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoPackageNavigationViewModel >> isPharoBehaviorsNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoPackageNavigationViewModel >> isPharoPackageNavigationViewModel [
	<return: #Boolean>
	^ true
]

{ #category : #'api - testing' }
GtPharoPackageNavigationViewModel >> isPharoPackagesNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoPackageNavigationViewModel >> isPharoTagNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoPackageNavigationViewModel >> isPharoTagsNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> isSelectedPackage [
	<return: #Boolean>
	^ self parentPharoPackagesNavigationViewModel hasSelectedPackageViewModel
		and: [ self parentPharoPackagesNavigationViewModel selectedPackageViewModel == self ]
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> notifyPackageDeselected [
	<propertyUnsetNotifier: #selectedPackageViewModel>
	self
		announce: (GtPharoPackageNavigationViewModelDeselected new packageViewModel: self)
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> notifyPackageSelected [
	<propertySetNotifier: #selectedPackageViewModel>
	self
		announce: (GtPharoPackageNavigationViewModelSelected new packageViewModel: self)
]

{ #category : #'api - accessing' }
GtPharoPackageNavigationViewModel >> parentPharoPackagesNavigationViewModel [
	<return: #GtPharoPackagesNavigationViewModel>
	<parentViewModelGetter: #packages>
	self
		assert: [ parentPharoPackagesNavigationViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].
	^ parentPharoPackagesNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoPackageNavigationViewModel >> parentPharoPackagesNavigationViewModel: arg1 [
	<parentViewModelSetter: #packages>
	self
		assert: [ arg1 notNil ]
		description: [ 'Parent view model must not be nil' ].
	parentPharoPackagesNavigationViewModel := arg1
]

{ #category : #'api - accessing' }
GtPharoPackageNavigationViewModel >> pharoBehaviorsNavigationViewModel [
	<return: #GtPharoBehaviorsNavigationViewModel>
	^ pharoBehaviorsNavigationViewModel
		ifNil: [ pharoBehaviorsNavigationViewModel := self
					createPharoBehaviorsNavigationViewModel ]
		ifNotNil: [ pharoBehaviorsNavigationViewModel ]
]

{ #category : #'api - accessing' }
GtPharoPackageNavigationViewModel >> pharoTagsNavigationViewModel [
	<return: #GtPharoTagsNavigationViewModel>
	^ pharoTagsNavigationViewModel
		ifNil: [ pharoTagsNavigationViewModel := self createPharoTagsNavigationViewModel ]
		ifNotNil: [ pharoTagsNavigationViewModel ]
]

{ #category : #printing }
GtPharoPackageNavigationViewModel >> printOn: arg1 [
	arg1 print: self pharoPackageCoderModel
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> selectPackageWithExtension [
	<propertySetter: #selectedPackageViewModel>
	self parentPharoPackagesNavigationViewModel selectPackageViewModel: self
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> selectPackageWithoutOtherEntities [
	self
		deselectOtherEntities;
		selectPackageWithExtension
]

{ #category : #'api - announcer' }
GtPharoPackageNavigationViewModel >> unsubscribe: arg1 [
	| tmp1 tmp3 |
	tmp3 := tmp1 := announcer.
	^ tmp3 ifNotNil: [ tmp1 unsubscribe: arg1 ]
]

{ #category : #'api - accessing' }
GtPharoPackageNavigationViewModel >> viewModelName [
	<return: #Symbol>
	^ #package
]

{ #category : #'api - announcer' }
GtPharoPackageNavigationViewModel >> when: arg1 do: arg2 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ])
		when: arg1
		do: arg2
]

{ #category : #'api - announcer' }
GtPharoPackageNavigationViewModel >> when: arg1 send: arg2 to: arg3 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ]) weak
		when: arg1
		send: arg2
		to: arg3
]
