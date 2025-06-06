Class {
	#name : #LcsValueObjectSuperClassBuilder,
	#superclass : #LcsBaseClassBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsValueObjectSuperClassBuilder class >> targetSuperclassName [
	^ 'LcsValueObject'
]

{ #category : #initialize }
LcsValueObjectSuperClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class targetSuperclassName
]

{ #category : #verification }
LcsValueObjectSuperClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self targetSuperclassName
]

{ #category : #verification }
LcsValueObjectSuperClassBuilder >> verifyUninstall [
	super verifyUninstall.
	self assert: self installedClass isNil
]
