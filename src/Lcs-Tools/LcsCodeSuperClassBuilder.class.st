Class {
	#name : #LcsCodeSuperClassBuilder,
	#superclass : #LcsBaseCodeClassBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsCodeSuperClassBuilder class >> superclassName [
	^ 'LcsCode'
]

{ #category : #accessing }
LcsCodeSuperClassBuilder >> verifyInstallation [
	super verifyInstallation.
	self assert: self installedClass superclass name equals: 'LcsCode'
]
