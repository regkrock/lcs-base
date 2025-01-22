Class {
	#name : #LcsCodeCollectionClassBuilder,
	#superclass : #LcsBaseClassBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsCodeCollectionClassBuilder class >> targetSuperclassName [
	^ 'LcsCodes'
]

{ #category : #accessing }
LcsCodeCollectionClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: 'LcsCodes'
]
