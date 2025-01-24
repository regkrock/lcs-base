Class {
	#name : #LcsCodeSuperClassBuilder,
	#superclass : #LcsBaseClassBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #accessing }
LcsCodeSuperClassBuilder class >> targetSuperclassName [
	^ 'LcsCode'
]

{ #category : #'gt view' }
LcsCodeSuperClassBuilder >> addModelClassesTo: aCollection [
	aCollection addAll: self targetSuperclassName asClass withAllSuperclasses
]

{ #category : #accessing }
LcsCodeSuperClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class targetSuperclassName
]

{ #category : #accessing }
LcsCodeSuperClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self targetSuperclassName
]

{ #category : #accessing }
LcsCodeSuperClassBuilder >> verifyUnistall [
	super verifyUnistall.
	self assert: self installedClass isNil
]
