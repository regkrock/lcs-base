Class {
	#name : #GtPharoPackageTagCoderViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackageTagCoderModel',
	#classTraits : 'TGtWithPharoPackageTagCoderModel classTrait',
	#instVars : [
		'announcer',
		'parentPharoPackageTagsCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-View Models'
}

{ #category : #'api - announcer' }
GtPharoPackageTagCoderViewModel >> announce: arg1 [
	| tmp1 |
	(tmp1 := announcer) ifNotNil: [ tmp1 announce: arg1 ].
	self hasParentPharoPackageTagsCoderViewModel
		ifTrue: [ self parentPharoPackageTagsCoderViewModel announce: arg1 ]
]

{ #category : #'api - accessing' }
GtPharoPackageTagCoderViewModel >> hasParentPharoPackageTagsCoderViewModel [
	<return: #Boolean>
	<parentViewModelTester: #packageTags>
	^ parentPharoPackageTagsCoderViewModel notNil
]

{ #category : #'api - testing' }
GtPharoPackageTagCoderViewModel >> isPharoPackageCoderViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoPackageTagCoderViewModel >> isPharoPackageTagCoderViewModel [
	<return: #Boolean>
	^ true
]

{ #category : #'api - testing' }
GtPharoPackageTagCoderViewModel >> isPharoPackageTagsCoderViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoPackageTagCoderViewModel >> isPharoPackagesCoderViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - accessing' }
GtPharoPackageTagCoderViewModel >> parentPharoPackageTagsCoderViewModel [
	<return: #GtPharoPackageTagsCoderViewModel>
	<parentViewModelGetter: #packageTags>
	self
		assert: [ parentPharoPackageTagsCoderViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].
	^ parentPharoPackageTagsCoderViewModel
]

{ #category : #'api - accessing' }
GtPharoPackageTagCoderViewModel >> parentPharoPackageTagsCoderViewModel: arg1 [
	<parentViewModelSetter: #packageTags>
	self
		assert: [ arg1 notNil ]
		description: [ 'Parent view model must not be nil' ].
	parentPharoPackageTagsCoderViewModel := arg1
]

{ #category : #printing }
GtPharoPackageTagCoderViewModel >> printOn: arg1 [
	arg1 print: self pharoPackageTagCoderModel
]

{ #category : #'api - announcer' }
GtPharoPackageTagCoderViewModel >> unsubscribe: arg1 [
	| tmp1 tmp3 |
	tmp3 := tmp1 := announcer.
	^ tmp3 ifNotNil: [ tmp1 unsubscribe: arg1 ]
]

{ #category : #'api - accessing' }
GtPharoPackageTagCoderViewModel >> viewModelName [
	<return: #Symbol>
	^ #packageTag
]

{ #category : #'api - announcer' }
GtPharoPackageTagCoderViewModel >> when: arg1 do: arg2 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ])
		when: arg1
		do: arg2
]

{ #category : #'api - announcer' }
GtPharoPackageTagCoderViewModel >> when: arg1 send: arg2 to: arg3 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ]) weak
		when: arg1
		send: arg2
		to: arg3
]
