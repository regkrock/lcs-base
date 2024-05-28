Class {
	#name : #GtPharoPackageTagsCoderViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackageTagsCoderModel',
	#classTraits : 'TGtWithPharoPackageTagsCoderModel classTrait',
	#instVars : [
		'announcer',
		'pharoPackageTagCoderViewModels',
		'parentPharoPackageCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-View Models'
}

{ #category : #'api - announcer' }
GtPharoPackageTagsCoderViewModel >> announce: arg1 [
	| tmp1 |
	(tmp1 := announcer) ifNotNil: [ tmp1 announce: arg1 ].
	self hasParentPharoPackageCoderViewModel
		ifTrue: [ self parentPharoPackageCoderViewModel announce: arg1 ]
]

{ #category : #'private - instance creation' }
GtPharoPackageTagsCoderViewModel >> createPharoPackageTagCoderViewModels [
	<return: #Collection of: #GtPharoPackageTagCoderViewModel>
	^ self pharoPackageTagsCoderModel coders
		collect: [ :arg1 | 
			| tmp1 |
			tmp1 := GtPharoPackageTagCoderViewModel new.
			tmp1
				parentPharoPackageTagsCoderViewModel: self;
				pharoPackageTagCoderModel: arg1 ]
		as: Array
]

{ #category : #'api - accessing' }
GtPharoPackageTagsCoderViewModel >> hasParentPharoPackageCoderViewModel [
	<return: #Boolean>
	<parentViewModelTester: #package>
	^ parentPharoPackageCoderViewModel notNil
]

{ #category : #'api - testing' }
GtPharoPackageTagsCoderViewModel >> isPharoPackageCoderViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoPackageTagsCoderViewModel >> isPharoPackageTagCoderViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoPackageTagsCoderViewModel >> isPharoPackageTagsCoderViewModel [
	<return: #Boolean>
	^ true
]

{ #category : #'api - testing' }
GtPharoPackageTagsCoderViewModel >> isPharoPackagesCoderViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - accessing' }
GtPharoPackageTagsCoderViewModel >> parentPharoPackageCoderViewModel [
	<return: #GtPharoPackageCoderViewModel>
	<parentViewModelGetter: #package>
	self
		assert: [ parentPharoPackageCoderViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].
	^ parentPharoPackageCoderViewModel
]

{ #category : #'api - accessing' }
GtPharoPackageTagsCoderViewModel >> parentPharoPackageCoderViewModel: arg1 [
	<parentViewModelSetter: #package>
	self
		assert: [ arg1 notNil ]
		description: [ 'Parent view model must not be nil' ].
	parentPharoPackageCoderViewModel := arg1
]

{ #category : #'api - accessing' }
GtPharoPackageTagsCoderViewModel >> pharoPackageTagCoderViewModels [
	<return: #Collection of: #GtPharoPackageTagCoderViewModel>
	^ pharoPackageTagCoderViewModels
		ifNil: [ pharoPackageTagCoderViewModels := self createPharoPackageTagCoderViewModels ]
		ifNotNil: [ pharoPackageTagCoderViewModels ]
]

{ #category : #printing }
GtPharoPackageTagsCoderViewModel >> printOn: arg1 [
	arg1 print: self pharoPackageTagsCoderModel
]

{ #category : #'api - announcer' }
GtPharoPackageTagsCoderViewModel >> unsubscribe: arg1 [
	| tmp1 tmp3 |
	tmp3 := tmp1 := announcer.
	^ tmp3 ifNotNil: [ tmp1 unsubscribe: arg1 ]
]

{ #category : #'api - accessing' }
GtPharoPackageTagsCoderViewModel >> viewModelName [
	<return: #Symbol>
	^ #packageTags
]

{ #category : #'api - announcer' }
GtPharoPackageTagsCoderViewModel >> when: arg1 do: arg2 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ])
		when: arg1
		do: arg2
]

{ #category : #'api - announcer' }
GtPharoPackageTagsCoderViewModel >> when: arg1 send: arg2 to: arg3 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ]) weak
		when: arg1
		send: arg2
		to: arg3
]
