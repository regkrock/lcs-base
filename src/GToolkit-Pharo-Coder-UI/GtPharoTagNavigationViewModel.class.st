Class {
	#name : #GtPharoTagNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackageTagCoderModel',
	#classTraits : 'TGtWithPharoPackageTagCoderModel classTrait',
	#instVars : [
		'announcer',
		'pharoBehaviorsNavigationViewModel',
		'parentPharoTagsNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - announcer' }
GtPharoTagNavigationViewModel >> announce: arg1 [
	| tmp1 |
	(tmp1 := announcer) ifNotNil: [ tmp1 announce: arg1 ].
	self hasParentPharoTagsNavigationViewModel
		ifTrue: [ self parentPharoTagsNavigationViewModel announce: arg1 ]
]

{ #category : #'private - instance creation' }
GtPharoTagNavigationViewModel >> createPharoBehaviorsNavigationViewModel [
	<return: #GtPharoBehaviorsNavigationViewModel>
	| tmp1 |
	tmp1 := GtPharoBehaviorsNavigationViewModel new.
	tmp1
		parentPharoTagNavigationViewModel: self;
		pharoClassesCoderModel: self pharoPackageTagCoderModel classesCoder.
	^ tmp1
]

{ #category : #'api - selection' }
GtPharoTagNavigationViewModel >> deselectOtherEntities [
	<propertyUnsetOthers: #selectedTagViewModel>
	self pharoBehaviorsNavigationViewModel deselectBehaviorViewModel
]

{ #category : #'gt-extentions' }
GtPharoTagNavigationViewModel >> gtBehaviorsListViewFor: arg1 [
	<gtView>
	| tmp2 |
	tmp2 := arg1 list.
	tmp2
		priority: 5;
		title: 'Behaviors'.
	^ tmp2
		items: [ self pharoBehaviorsNavigationViewModel pharoBehaviorNavigationViewModels ]
]

{ #category : #'api - selection' }
GtPharoTagNavigationViewModel >> hasOtherSelectedEntities [
	<return: #Boolean>
	<propertyTestOthers: #selectedTagViewModel>
	^ self pharoBehaviorsNavigationViewModel hasSelectedBehaviorViewModel
]

{ #category : #'api - accessing' }
GtPharoTagNavigationViewModel >> hasParentPharoTagsNavigationViewModel [
	<return: #Boolean>
	<parentViewModelTester: #tags>
	^ parentPharoTagsNavigationViewModel notNil
]

{ #category : #'api - selection' }
GtPharoTagNavigationViewModel >> isOnlySelectedTag [
	<return: #Boolean>
	^ self isSelectedTag and: [ self hasOtherSelectedEntities not ]
]

{ #category : #'api - testing' }
GtPharoTagNavigationViewModel >> isPharoBehaviorNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoTagNavigationViewModel >> isPharoBehaviorsNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoTagNavigationViewModel >> isPharoPackageNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoTagNavigationViewModel >> isPharoPackagesNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoTagNavigationViewModel >> isPharoTagNavigationViewModel [
	<return: #Boolean>
	^ true
]

{ #category : #'api - testing' }
GtPharoTagNavigationViewModel >> isPharoTagsNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - selection' }
GtPharoTagNavigationViewModel >> isSelectedTag [
	<return: #Boolean>
	^ self parentPharoTagsNavigationViewModel hasSelectedTagViewModel
		and: [ self parentPharoTagsNavigationViewModel selectedTagViewModel == self ]
]

{ #category : #'api - selection' }
GtPharoTagNavigationViewModel >> notifyTagDeselected [
	<propertyUnsetNotifier: #selectedTagViewModel>
	self announce: (GtPharoTagNavigationViewModelDeselected new tagViewModel: self)
]

{ #category : #'api - selection' }
GtPharoTagNavigationViewModel >> notifyTagSelected [
	<propertySetNotifier: #selectedTagViewModel>
	self announce: (GtPharoTagNavigationViewModelSelected new tagViewModel: self)
]

{ #category : #'api - accessing' }
GtPharoTagNavigationViewModel >> parentPharoTagsNavigationViewModel [
	<return: #GtPharoTagsNavigationViewModel>
	<parentViewModelGetter: #tags>
	self
		assert: [ parentPharoTagsNavigationViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].
	^ parentPharoTagsNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoTagNavigationViewModel >> parentPharoTagsNavigationViewModel: arg1 [
	<parentViewModelSetter: #tags>
	self
		assert: [ arg1 notNil ]
		description: [ 'Parent view model must not be nil' ].
	parentPharoTagsNavigationViewModel := arg1
]

{ #category : #'api - accessing' }
GtPharoTagNavigationViewModel >> pharoBehaviorsNavigationViewModel [
	<return: #GtPharoBehaviorsNavigationViewModel>
	^ pharoBehaviorsNavigationViewModel
		ifNil: [ pharoBehaviorsNavigationViewModel := self
					createPharoBehaviorsNavigationViewModel ]
		ifNotNil: [ pharoBehaviorsNavigationViewModel ]
]

{ #category : #printing }
GtPharoTagNavigationViewModel >> printOn: arg1 [
	arg1 print: self pharoPackageTagCoderModel
]

{ #category : #'api - selection' }
GtPharoTagNavigationViewModel >> selectTag [
	<propertySetter: #selectedTagViewModel>
	self parentPharoTagsNavigationViewModel selectTagViewModel: self
]

{ #category : #'api - selection' }
GtPharoTagNavigationViewModel >> selectTagWithoutOtherEntities [
	self
		deselectOtherEntities;
		selectTag
]

{ #category : #'api - announcer' }
GtPharoTagNavigationViewModel >> unsubscribe: arg1 [
	| tmp1 tmp3 |
	tmp3 := tmp1 := announcer.
	^ tmp3 ifNotNil: [ tmp1 unsubscribe: arg1 ]
]

{ #category : #'api - accessing' }
GtPharoTagNavigationViewModel >> viewModelName [
	<return: #Symbol>
	^ #tag
]

{ #category : #'api - announcer' }
GtPharoTagNavigationViewModel >> when: arg1 do: arg2 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ])
		when: arg1
		do: arg2
]

{ #category : #'api - announcer' }
GtPharoTagNavigationViewModel >> when: arg1 send: arg2 to: arg3 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ]) weak
		when: arg1
		send: arg2
		to: arg3
]
