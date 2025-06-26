Class {
	#name : #LcsValueObjectsCollectionClassBuilder,
	#superclass : #LcsBaseClassBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #accessing }
LcsValueObjectsCollectionClassBuilder class >> targetSuperclassName [
	^ 'LcsValueObjects'
]

{ #category : #accessing }
LcsValueObjectsCollectionClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: 'LcsValueObjects'
]
