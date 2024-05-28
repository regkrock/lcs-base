Class {
	#name : #GtPackageCreationForm,
	#superclass : #GtCreationForm,
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtPackageCreationForm class >> componentName [
	^ 'Package'
]

{ #category : #accessing }
GtPackageCreationForm class >> priority [
	^ 3
]

{ #category : #callbacks }
GtPackageCreationForm >> commit [
	^ self commitPackage package
]

{ #category : #magritte }
GtPackageCreationForm >> packageAndTagDescription [
	<magritteDescription>
	^ super packageAndTagDescription
		addCondition: [ :arg1 | 
			| tmp1 |
			tmp1 := arg1 packageName asPackageIfAbsent: [  ].
			tmp1 == nil
				or: [ arg1 tagName
						ifEmpty: [ false ]
						ifNotEmpty: [ (tmp1 classTagNamed: arg1 tagName ifAbsent: [  ]) isNil ] ] ]
		labelled: 'Package and tag exist'
]

{ #category : #accessing }
GtPackageCreationForm >> selectInNavigationModel: arg1 anInstance: arg2 [
	^ self packageAndTagName tagName
		ifEmpty: [ arg1 selectPackage: arg2 ]
		ifNotEmpty: [ arg1 selectPackageTag: (arg2 classTagNamed: self packageAndTagName tagName) ]
]

{ #category : #accessing }
GtPackageCreationForm >> toolFor: arg1 [
	^ GtPackageCoderTool package: arg1
]
