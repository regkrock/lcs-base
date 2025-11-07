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
LcsValueObjectsCollectionClassBuilder >> _verifyCodeInstallation [
	super _verifyCodeInstallation.
	self assert: self installedClass superclass name equals: 'LcsValueObjects'
]
