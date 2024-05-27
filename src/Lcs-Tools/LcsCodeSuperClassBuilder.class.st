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
LcsCodeSuperClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self superclassName
]
