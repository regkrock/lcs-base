Class {
	#name : #LcsCodesCollectionClassBuilder,
	#superclass : #LcsBaseClassBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #accessing }
LcsCodesCollectionClassBuilder class >> targetSuperclassName [
	^ 'LcsValueObjects'
]

{ #category : #accessing }
LcsCodesCollectionClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: 'LcsValueObjects'
]
