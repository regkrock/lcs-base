Class {
	#name : #LcsCodeSuperClassBuilder,
	#superclass : #LcsBaseClassBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsCodeSuperClassBuilder class >> targetSuperclassName [
	^ 'LcsCode'
]

{ #category : #initialize }
LcsCodeSuperClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class targetSuperclassName
]

{ #category : #verification }
LcsCodeSuperClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self targetSuperclassName
]

{ #category : #verification }
LcsCodeSuperClassBuilder >> verifyUnistall [
	super verifyUnistall.
	self assert: self installedClass isNil
]
