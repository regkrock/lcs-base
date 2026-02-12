Class {
	#name : 'LcsValueObjectSuperClassBuilder',
	#superclass : 'LcsBaseClassBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'configuration' }
LcsValueObjectSuperClassBuilder class >> targetSuperclassName [
	^ 'LcsValueObject'
]

{ #category : 'verification' }
LcsValueObjectSuperClassBuilder >> _verifyCodeInstallation [
	super _verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self targetSuperclassName
]

{ #category : 'initialize' }
LcsValueObjectSuperClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class targetSuperclassName
]

{ #category : 'verification' }
LcsValueObjectSuperClassBuilder >> verifyUninstall [
	super verifyUninstall.
	self assert: self installedClass isNil
]
