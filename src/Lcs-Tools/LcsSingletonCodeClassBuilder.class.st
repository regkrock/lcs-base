Class {
	#name : #LcsSingletonCodeClassBuilder,
	#superclass : #LcsCodeClassBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #refactoring }
LcsSingletonCodeClassBuilder >> addDefaultInstanceRefactoring [
	^ RBAddMethodChange
		compile: self defaultInstanceSource
		in: self installedClass class
		classified: #defaults
]

{ #category : #'method code source' }
LcsSingletonCodeClassBuilder >> defaultInstanceSource [
	^ 'defaultInstance
	^ ' , self defaultInstance asString
]

{ #category : #install }
LcsSingletonCodeClassBuilder >> installCode [
	super installCode.
	self addCompletedRefactoring: self addDefaultInstanceRefactoring execute
]

{ #category : #accessing }
LcsSingletonCodeClassBuilder >> populateSlotModel [
	self installedClass new
]

{ #category : #verification }
LcsSingletonCodeClassBuilder >> verifyInstallation [
	super verifyInstallation.
	self assert: self installedClass defaultInstance equals: self defaultInstance
]
