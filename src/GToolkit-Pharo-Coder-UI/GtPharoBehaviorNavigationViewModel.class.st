Class {
	#name : #GtPharoBehaviorNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoBehaviorCoderModel',
	#classTraits : 'TGtWithPharoBehaviorCoderModel classTrait',
	#instVars : [
		'announcer',
		'parentPharoBehaviorsNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - announcer' }
GtPharoBehaviorNavigationViewModel >> announce: arg1 [
	| tmp1 |
	(tmp1 := announcer) ifNotNil: [ tmp1 announce: arg1 ].
	self hasParentPharoBehaviorsNavigationViewModel
		ifTrue: [ self parentPharoBehaviorsNavigationViewModel announce: arg1 ]
]

{ #category : #'api - selection' }
GtPharoBehaviorNavigationViewModel >> deselectOtherEntities [
	<propertyUnsetOthers: #selectedBehaviorViewModel>
	
]

{ #category : #'api - selection' }
GtPharoBehaviorNavigationViewModel >> hasOtherSelectedEntities [
	<return: #Boolean>
	<propertyTestOthers: #selectedBehaviorViewModel>
	^ false
]

{ #category : #'api - accessing' }
GtPharoBehaviorNavigationViewModel >> hasParentPharoBehaviorsNavigationViewModel [
	<return: #Boolean>
	<parentViewModelTester: #behaviors>
	^ parentPharoBehaviorsNavigationViewModel notNil
]

{ #category : #'api - selection' }
GtPharoBehaviorNavigationViewModel >> isOnlySelectedBehavior [
	<return: #Boolean>
	^ self isSelectedBehavior and: [ self hasOtherSelectedEntities not ]
]

{ #category : #'api - testing' }
GtPharoBehaviorNavigationViewModel >> isPharoBehaviorNavigationViewModel [
	<return: #Boolean>
	^ true
]

{ #category : #'api - testing' }
GtPharoBehaviorNavigationViewModel >> isPharoBehaviorsNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoBehaviorNavigationViewModel >> isPharoPackageNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoBehaviorNavigationViewModel >> isPharoPackagesNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoBehaviorNavigationViewModel >> isPharoTagNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoBehaviorNavigationViewModel >> isPharoTagsNavigationViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - selection' }
GtPharoBehaviorNavigationViewModel >> isSelectedBehavior [
	<return: #Boolean>
	^ self parentPharoBehaviorsNavigationViewModel hasSelectedBehaviorViewModel
		and: [ self parentPharoBehaviorsNavigationViewModel selectedBehaviorViewModel == self ]
]

{ #category : #'api - selection' }
GtPharoBehaviorNavigationViewModel >> notifyBehaviorDeselected [
	<propertyUnsetNotifier: #selectedBehaviorViewModel>
	self
		announce: (GtPharoBehaviorNavigationViewModelDeselected new behaviorViewModel: self)
]

{ #category : #'api - selection' }
GtPharoBehaviorNavigationViewModel >> notifyBehaviorSelected [
	<propertySetNotifier: #selectedBehaviorViewModel>
	self
		announce: (GtPharoBehaviorNavigationViewModelSelected new behaviorViewModel: self)
]

{ #category : #'api - accessing' }
GtPharoBehaviorNavigationViewModel >> parentPharoBehaviorsNavigationViewModel [
	<return: #GtPharoBehaviorsNavigationViewModel>
	<parentViewModelGetter: #behaviors>
	self
		assert: [ parentPharoBehaviorsNavigationViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].
	^ parentPharoBehaviorsNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoBehaviorNavigationViewModel >> parentPharoBehaviorsNavigationViewModel: arg1 [
	<parentViewModelSetter: #behaviors>
	self
		assert: [ arg1 notNil ]
		description: [ 'Parent view model must not be nil' ].
	parentPharoBehaviorsNavigationViewModel := arg1
]

{ #category : #printing }
GtPharoBehaviorNavigationViewModel >> printOn: arg1 [
	arg1 print: self pharoBehaviorCoderModel
]

{ #category : #'api - selection' }
GtPharoBehaviorNavigationViewModel >> selectBehavior [
	<propertySetter: #selectedBehaviorViewModel>
	self parentPharoBehaviorsNavigationViewModel selectBehaviorViewModel: self
]

{ #category : #'api - selection' }
GtPharoBehaviorNavigationViewModel >> selectBehaviorWithoutOtherEntities [
	self
		deselectOtherEntities;
		selectBehavior
]

{ #category : #'api - announcer' }
GtPharoBehaviorNavigationViewModel >> unsubscribe: arg1 [
	| tmp1 tmp3 |
	tmp3 := tmp1 := announcer.
	^ tmp3 ifNotNil: [ tmp1 unsubscribe: arg1 ]
]

{ #category : #'api - accessing' }
GtPharoBehaviorNavigationViewModel >> viewModelName [
	<return: #Symbol>
	^ #behavior
]

{ #category : #'api - announcer' }
GtPharoBehaviorNavigationViewModel >> when: arg1 do: arg2 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ])
		when: arg1
		do: arg2
]

{ #category : #'api - announcer' }
GtPharoBehaviorNavigationViewModel >> when: arg1 send: arg2 to: arg3 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ]) weak
		when: arg1
		send: arg2
		to: arg3
]
