Class {
	#name : #GtPharoPackagesCoderViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackagesCoderModel',
	#classTraits : 'TGtWithPharoPackagesCoderModel classTrait',
	#instVars : [
		'announcer',
		'pharoPackageCoderViewModels'
	],
	#category : #'GToolkit-Pharo-Coder-UI-View Models'
}

{ #category : #'api - announcer' }
GtPharoPackagesCoderViewModel >> announce: arg1 [
	| tmp1 |
	(tmp1 := announcer) ifNotNil: [ tmp1 announce: arg1 ]
]

{ #category : #converting }
GtPharoPackagesCoderViewModel >> asElement [
	^ GtPackagesCoderElement new codersUIModel: self
]

{ #category : #deprecated }
GtPharoPackagesCoderViewModel >> coder [
	^ self pharoPackagesCoderModel
]

{ #category : #'private - instance creation' }
GtPharoPackagesCoderViewModel >> createPharoPackageCoderViewModels [
	<return: #Collection of: #GtPharoPackageCoderViewModel>
	^ self pharoPackagesCoderModel coders
		collect: [ :arg1 | 
			| tmp1 |
			tmp1 := GtPharoPackageCoderViewModel new.
			tmp1
				parentPharoPackagesCoderViewModel: self;
				pharoPackageTagCoderModel: arg1 ]
		as: Array
]

{ #category : #'api - testing' }
GtPharoPackagesCoderViewModel >> isPharoPackageCoderViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoPackagesCoderViewModel >> isPharoPackageTagCoderViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoPackagesCoderViewModel >> isPharoPackageTagsCoderViewModel [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPharoPackagesCoderViewModel >> isPharoPackagesCoderViewModel [
	<return: #Boolean>
	^ true
]

{ #category : #'api - accessing' }
GtPharoPackagesCoderViewModel >> pharoPackageCoderViewModels [
	<return: #Collection of: #GtPharoPackageCoderViewModel>
	^ pharoPackageCoderViewModels
		ifNil: [ pharoPackageCoderViewModels := self createPharoPackageCoderViewModels ]
		ifNotNil: [ pharoPackageCoderViewModels ]
]

{ #category : #printing }
GtPharoPackagesCoderViewModel >> printOn: arg1 [
	arg1 print: self pharoPackagesCoderModel
]

{ #category : #'api - announcer' }
GtPharoPackagesCoderViewModel >> unsubscribe: arg1 [
	| tmp1 tmp3 |
	tmp3 := tmp1 := announcer.
	^ tmp3 ifNotNil: [ tmp1 unsubscribe: arg1 ]
]

{ #category : #'api - accessing' }
GtPharoPackagesCoderViewModel >> viewModelName [
	<return: #Symbol>
	^ #packages
]

{ #category : #'api - announcer' }
GtPharoPackagesCoderViewModel >> when: arg1 do: arg2 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ])
		when: arg1
		do: arg2
]

{ #category : #'api - announcer' }
GtPharoPackagesCoderViewModel >> when: arg1 send: arg2 to: arg3 [
	(announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ]) weak
		when: arg1
		send: arg2
		to: arg3
]
