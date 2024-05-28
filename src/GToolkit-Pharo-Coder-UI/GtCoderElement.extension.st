Extension { #name : #GtCoderElement }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderElement class >> forAllPackages [
	^ self forCoder: GtPharoPackagesCoder forAllPackages
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderElement class >> forClass: arg1 [
	^ self forCoder: (GtPharoBehaviorCoder forClass: arg1)
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderElement class >> forCoder: arg1 [
	| tmp2 |
	tmp2 := self basicNew initialize.
	tmp2 navigationModel: GtCoderNavigationModel default.
	^ tmp2 pushCoder: arg1
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderElement class >> forMethod: arg1 [
	| tmp1 tmp2 |
	tmp1 := GtPharoBehaviorCoder forClass: arg1 methodClass instanceSide.
	tmp2 := self forCoder: tmp1.
	tmp1 withSelectedMethod: arg1.
	^ tmp2
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderElement class >> forObject: arg1 [
	^ self forCoder: (GtPharoBehaviorCoder forObject: arg1)
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderElement class >> forPackage: arg1 [
	^ self forCoder: (GtPharoPackageCoder forPackage: arg1)
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderElement class >> forPackageTag: arg1 [
	^ self forCoder: (GtPharoPackageTagCoder forPackageTag: arg1)
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderElement class >> new [
	^ self forCoder: GtPharoPackagesCoder forAllPackages
]
