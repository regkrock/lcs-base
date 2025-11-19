Class {
	#name : 'LcsDomainClassBuilder',
	#superclass : 'LcsBaseClassBuilder',
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'accessing' }
LcsDomainClassBuilder class >> defaultTargetSuperclassName [
	^ 'LcsDomainObject'
]

{ #category : 'accessing' }
LcsDomainClassBuilder >> _verifyCodeInstallation [
	super _verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self targetSuperclassName
]

{ #category : 'accessing' }
LcsDomainClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class defaultTargetSuperclassName
]
