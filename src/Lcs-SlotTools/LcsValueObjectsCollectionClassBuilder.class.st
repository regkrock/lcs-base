Class {
	#name : 'LcsValueObjectsCollectionClassBuilder',
	#superclass : 'LcsBaseClassBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'accessing' }
LcsValueObjectsCollectionClassBuilder class >> targetSuperclassName [
	^ 'LcsValueObjects'
]

{ #category : 'accessing' }
LcsValueObjectsCollectionClassBuilder >> _verifyCodeInstallation [
	super _verifyCodeInstallation.
	self assert: self installedClass superclass name equals: 'LcsValueObjects'
]
