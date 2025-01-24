Class {
	#name : #LcsDomainClassBuilder,
	#superclass : #LcsBaseClassBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #accessing }
LcsDomainClassBuilder class >> defaultTargetSuperclassName [
	^ 'LcsDomainObject'
]

{ #category : #accessing }
LcsDomainClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class defaultTargetSuperclassName
]

{ #category : #accessing }
LcsDomainClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self targetSuperclassName
]
