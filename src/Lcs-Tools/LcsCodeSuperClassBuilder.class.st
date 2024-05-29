Class {
	#name : #LcsCodeSuperClassBuilder,
	#superclass : #LcsBaseCodeClassBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsCodeSuperClassBuilder class >> defaultSuperclassName [
	^ 'LcsCode'
]

{ #category : #accessing }
LcsCodeSuperClassBuilder >> initialize [
	super initialize.
	self superclassName: self class defaultSuperclassName
]

{ #category : #accessing }
LcsCodeSuperClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self superclassName
]
