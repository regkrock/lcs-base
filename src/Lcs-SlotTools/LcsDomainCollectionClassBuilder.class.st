Class {
	#name : 'LcsDomainCollectionClassBuilder',
	#superclass : 'LcsBaseClassBuilder',
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'accessing' }
LcsDomainCollectionClassBuilder class >> targetSuperclassName [
	^ 'LcsDomainCollection'
]

{ #category : 'accessing' }
LcsDomainCollectionClassBuilder >> _verifyCodeInstallation [
	super _verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self targetSuperclassName
]

{ #category : 'accessing' }
LcsDomainCollectionClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class targetSuperclassName
]
