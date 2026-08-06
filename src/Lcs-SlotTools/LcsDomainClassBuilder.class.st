Class {
	#name : 'LcsDomainClassBuilder',
	#superclass : 'LcsBaseClassBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'accessing' }
LcsDomainClassBuilder class >> defaultTargetSuperclassName [
	^ 'LcsDomainObject'
]

{ #category : 'accessing' }
LcsDomainClassBuilder >> _verifyCodeInstallation [
	| classForVerification |
	super _verifyCodeInstallation.
	classForVerification := self installedClass ifNil: [ self newClassName asClass ].
	self assert: classForVerification superclass name equals: self targetSuperclassName
]

{ #category : 'accessing' }
LcsDomainClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class defaultTargetSuperclassName
]
