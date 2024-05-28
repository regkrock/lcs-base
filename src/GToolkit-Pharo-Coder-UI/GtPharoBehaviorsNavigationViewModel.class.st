Class {
	#name : #GtPharoBehaviorsNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoClassesCoderModel + TGtPharoWithSelectedBehaviorViewModel',
	#classTraits : 'TGtWithPharoClassesCoderModel classTrait + TGtPharoWithSelectedBehaviorViewModel classTrait',
	#instVars : [
		'announcer',
		'pharoBehaviorNavigationViewModels',
		'parentPharoPackageNavigationViewModel',
		'parentPharoTagNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - announcer' }
GtPharoBehaviorsNavigationViewModel >> announce: arg1 [
	| tmp1 |
	(tmp1 := announcer) ifNotNil: [ tmp1 announce: arg1 ].
	self hasParentPharoPackageNavigationViewModel
		ifTrue: [ self parentPharoPackageNavigationViewModel announce: arg1 ].
	self hasParentPharoTagNavigationViewModel
		ifTrue: [ self parentPharoTagNavigationViewModel announce: arg1 ]
]

{ #category : #'private - instance creation' }
GtPharoBehaviorsNavigationViewModel >> createPharoBehaviorNavigationViewModels [
	<return: #Collection of: #GtPharoBehaviorNavigationViewModel>
	^ self pharoClassesCoderModel coders
		collect: [ :arg1 | 
			| tmp1 |
			tmp1 := GtPharoBehaviorNavigationViewModel new.
			tmp1
				parentPharoBehaviorsNavigationViewModel: self;
				pharoBehaviorCoderModel: arg1 ]
		as: Array
]

{ #category : #'gt-extentions' }
GtPharoBehaviorsNavigationViewModel >> gtBehaviorsListViewFor: arg1 [
	<gtView>
	| tmp2 |
	tmp2 := arg1 list.
	tmp2
		priority: 5;
		title: 'Behaviors'.
	^ tmp2 items: [ self pharoBehaviorNavigationViewModels ]
]

{ #category : #'api - accessing' }
GtPharoBehaviorsNavigationViewModel >> hasParentPharoPackageNavigationViewModel [
	<return: #Boolean>
	<parentViewModelTester: #package>
	^ parentPharoPackageNavigationViewModel notNil
]

{ #category : #'api - accessing' }
GtPharoBehaviorsNavigationViewModel >> hasParentPharoTagNavigationViewModel [
	<return: #Boolean>
	<parentViewModelTester: #tag>
	^ parentPharoTagNavigationViewModel notNil
]

{ #category : #'api - testing' }
GtPharoBehaviorsNavigationViewModel >> isPharoBehaviorNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoBehaviorsNavigationViewModel >> isPharoBehaviorsNavigationViewModel [
	<return: #Boolean>
	^ true
]

{ #category : #'api - testing' }
GtPharoBehaviorsNavigationViewModel >> isPharoPackageNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoBehaviorsNavigationViewModel >> isPharoPackagesNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoBehaviorsNavigationViewModel >> isPharoTagNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoBehaviorsNavigationViewModel >> isPharoTagsNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - selected behavior view model' }
GtPharoBehaviorsNavigationViewModel >> notifySelectedBehaviorViewModelChanged [
	<propertyChangeNotifier: #selectedBehaviorViewModel>
	self announce: GtPharoNavigationSelectedBehaviorViewModelChanged new
]

{ #category : #'api - selected behavior view model' }
GtPharoBehaviorsNavigationViewModel >> onNewSelectedBehaviorViewModelSet: arg1 [
	<propertySetHook: #selectedBehaviorViewModel>
	self hasParentPharoPackageNavigationViewModel
		ifTrue: [ self parentPharoPackageNavigationViewModel selectPackageWithExtension ].
	self hasParentPharoTagNavigationViewModel
		ifTrue: [ self parentPharoTagNavigationViewModel selectTag ].
	arg1 notifyBehaviorSelected
]

{ #category : #'api - selected behavior view model' }
GtPharoBehaviorsNavigationViewModel >> onPreviousSelectedBehaviorViewModelUnset: arg1 [
	<propertyUnsetHook: #selectedBehaviorViewModel>
	arg1
		deselectOtherEntities;
		notifyBehaviorDeselected
]

{ #category : #'api - accessing' }
GtPharoBehaviorsNavigationViewModel >> parentPharoPackageNavigationViewModel [
	<return: #GtPharoPackageNavigationViewModel>
	<parentViewModelGetter: #package>
	self
		assert: [ parentPharoPackageNavigationViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].
	^ parentPharoPackageNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoBehaviorsNavigationViewModel >> parentPharoPackageNavigationViewModel: arg1 [
	<parentViewModelSetter: #package>
	self
		assert: [ arg1 notNil ]
		description: [ 'Parent view model must not be nil' ].
	parentPharoPackageNavigationViewModel := arg1
]

{ #category : #'api - accessing' }
GtPharoBehaviorsNavigationViewModel >> parentPharoTagNavigationViewModel [
	<return: #GtPharoTagNavigationViewModel>
	<parentViewModelGetter: #tag>
	self
		assert: [ parentPharoTagNavigationViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].
	^ parentPharoTagNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoBehaviorsNavigationViewModel >> parentPharoTagNavigationViewModel: arg1 [
	<parentViewModelSetter: #tag>
	self
		assert: [ arg1 notNil ]
		description: [ 'Parent view model must not be nil' ].
	parentPharoTagNavigationViewModel := arg1
]

{ #category : #'api - accessing' }
GtPharoBehaviorsNavigationViewModel >> pharoBehaviorNavigationViewModels [
	<return: #Collection of: #GtPharoBehaviorNavigationViewModel>
	^ pharoBehaviorNavigationViewModels
		ifNil: [ pharoBehaviorNavigationViewModels := self
					createPharoBehaviorNavigationViewModels ]
		ifNotNil: [ pharoBehaviorNavigationViewModels ]
]

{ #category : #printing }
GtPharoBehaviorsNavigationViewModel >> printOn: arg1 [
	arg1 print: self pharoClassesCoderModel
]

{ #category : #'api - announcer' }
GtPharoBehaviorsNavigationViewModel >> unsubscribe: arg1 [
	| tmp1 tmp3 |
	tmp3 := tmp1 := announcer.
	^ tmp3 ifNotNil: [ tmp1 unsubscribe: arg1 ]
]

{ #category : #'api - accessing' }
GtPharoBehaviorsNavigationViewModel >> viewModelName [
	<return: #Symbol>
	^ #behaviors
]

{ #category : #'api - announcer' }
GtPharoBehaviorsNavigationViewModel >> when: arg1 do: arg2 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ])
		when: arg1
		do: arg2
]

{ #category : #'api - announcer' }
GtPharoBehaviorsNavigationViewModel >> when: arg1 send: arg2 to: arg3 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ]) weak
		when: arg1
		send: arg2
		to: arg3
]
