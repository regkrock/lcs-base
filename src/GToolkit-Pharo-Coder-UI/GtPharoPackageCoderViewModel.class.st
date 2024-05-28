Class {
	#name : #GtPharoPackageCoderViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackageCoderModel',
	#classTraits : 'TGtWithPharoPackageCoderModel classTrait',
	#instVars : [
		'announcer',
		'pharoPackageTagsCoderViewModel',
		'parentPharoPackagesCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-View Models'
}

{ #category : #'api - announcer' }
GtPharoPackageCoderViewModel >> announce: arg1 [
	| tmp1 |
	(tmp1 := announcer) ifNotNil: [ tmp1 announce: arg1 ].
	self hasParentPharoPackagesCoderViewModel
		ifTrue: [ self parentPharoPackagesCoderViewModel announce: arg1 ]
]

{ #category : #accessing }
GtPharoPackageCoderViewModel >> asElement [
	^ GtPharoPackageCoderElement new coderViewModel: self
]

{ #category : #accessing }
GtPharoPackageCoderViewModel >> coder [
	^ self pharoPackageCoderModel
]

{ #category : #'private - instance creation' }
GtPharoPackageCoderViewModel >> createPharoPackageTagsCoderViewModel [
	<return: #GtPharoPackageTagsCoderViewModel>
	| tmp1 |
	tmp1 := GtPharoPackageTagsCoderViewModel new.
	tmp1
		parentPharoPackageCoderViewModel: self;
		pharoPackageTagsCoderModel: self pharoPackageTagCoderModel packageTagsCoder.
	^ tmp1
]

{ #category : #accessing }
GtPharoPackageCoderViewModel >> elementClass [
	^ GtPharoPackageCoderElement
]

{ #category : #'api - accessing' }
GtPharoPackageCoderViewModel >> hasParentPharoPackagesCoderViewModel [
	<return: #Boolean>
	<parentViewModelTester: #packages>
	^ parentPharoPackagesCoderViewModel notNil
]

{ #category : #'api - testing' }
GtPharoPackageCoderViewModel >> isPharoPackageCoderViewModel [
	<return: #Boolean>
	^ true
]

{ #category : #'api - testing' }
GtPharoPackageCoderViewModel >> isPharoPackageTagCoderViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoPackageCoderViewModel >> isPharoPackageTagsCoderViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoPackageCoderViewModel >> isPharoPackagesCoderViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - accessing' }
GtPharoPackageCoderViewModel >> parentPharoPackagesCoderViewModel [
	<return: #GtPharoPackagesCoderViewModel>
	<parentViewModelGetter: #packages>
	self
		assert: [ parentPharoPackagesCoderViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].
	^ parentPharoPackagesCoderViewModel
]

{ #category : #'api - accessing' }
GtPharoPackageCoderViewModel >> parentPharoPackagesCoderViewModel: arg1 [
	<parentViewModelSetter: #packages>
	self
		assert: [ arg1 notNil ]
		description: [ 'Parent view model must not be nil' ].
	parentPharoPackagesCoderViewModel := arg1
]

{ #category : #'api - accessing' }
GtPharoPackageCoderViewModel >> pharoPackageTagsCoderViewModel [
	<return: #GtPharoPackageTagsCoderViewModel>
	^ pharoPackageTagsCoderViewModel
		ifNil: [ pharoPackageTagsCoderViewModel := self createPharoPackageTagsCoderViewModel ]
		ifNotNil: [ pharoPackageTagsCoderViewModel ]
]

{ #category : #printing }
GtPharoPackageCoderViewModel >> printOn: arg1 [
	arg1 print: self pharoPackageTagCoderModel
]

{ #category : #'api - announcer' }
GtPharoPackageCoderViewModel >> unsubscribe: arg1 [
	| tmp1 tmp3 |
	tmp3 := tmp1 := announcer.
	^ tmp3 ifNotNil: [ tmp1 unsubscribe: arg1 ]
]

{ #category : #'api - accessing' }
GtPharoPackageCoderViewModel >> viewModelName [
	<return: #Symbol>
	^ #package
]

{ #category : #'api - announcer' }
GtPharoPackageCoderViewModel >> when: arg1 do: arg2 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ])
		when: arg1
		do: arg2
]

{ #category : #'api - announcer' }
GtPharoPackageCoderViewModel >> when: arg1 send: arg2 to: arg3 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ]) weak
		when: arg1
		send: arg2
		to: arg3
]
