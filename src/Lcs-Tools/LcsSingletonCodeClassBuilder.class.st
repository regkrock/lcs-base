Class {
	#name : #LcsSingletonCodeClassBuilder,
	#superclass : #LcsCodeClassBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #refactoring }
LcsSingletonCodeClassBuilder >> addDefaultCodeDescriptionRefactoring [
	^ RBAddMethodChange
		compile: self defaultCodeDescriptionSource
		in: self installedClass class
		classified: #defaults
]

{ #category : #refactoring }
LcsSingletonCodeClassBuilder >> addDefaultCodeNameRefactoring [
	^ RBAddMethodChange
		compile: self defaultCodeNameSource
		in: self installedClass class
		classified: #defaults
]

{ #category : #refactoring }
LcsSingletonCodeClassBuilder >> addDefaultInstanceRefactoring [
	^ RBAddMethodChange
		compile: self defaultInstanceSource
		in: self installedClass class
		classified: #defaults
]

{ #category : #refactoring }
LcsSingletonCodeClassBuilder >> addDefaultShortNameRefactoring [
	^ RBAddMethodChange
		compile: self defaultShortNameSource
		in: self installedClass class
		classified: #defaults
]

{ #category : #'method code source' }
LcsSingletonCodeClassBuilder >> defaultCodeDescriptionSource [
	^ 'defaultCodeDescription
	^ ''' , self codeDescription , ''''
]

{ #category : #private }
LcsSingletonCodeClassBuilder >> defaultCodeName [
	^ self codeName first asLowercase asString
		, (self codeName copyFrom: 2 to: self codeName size)
]

{ #category : #'method code source' }
LcsSingletonCodeClassBuilder >> defaultCodeNameSource [
	^ 'defaultCodeName
	^ ' ,self defaultCodeName printString
]

{ #category : #'method code source' }
LcsSingletonCodeClassBuilder >> defaultInstanceSource [
	^ 'defaultInstance
	^ ' , self defaultInstance asString
]

{ #category : #'method code source' }
LcsSingletonCodeClassBuilder >> defaultShortNameSource [
	^ 'defaultShortName
	^ ''' , self shortName , ''''
]

{ #category : #install }
LcsSingletonCodeClassBuilder >> installCode [
	super installCode.
	self addCompletedRefactoring: self addDefaultShortNameRefactoring execute.
	self addCompletedRefactoring: self addDefaultCodeDescriptionRefactoring execute.
	self addCompletedRefactoring: self addDefaultCodeNameRefactoring execute.
	self addCompletedRefactoring: self addDefaultInstanceRefactoring execute
]

{ #category : #accessing }
LcsSingletonCodeClassBuilder >> populateSlotModel [
	self installedClass new
]

{ #category : #verification }
LcsSingletonCodeClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self targetSuperclassName.
	self assert: self installedClass defaultCodeDescription equals: self codeDescription.
	self assert: self installedClass defaultCodeName equals: self codeName.
	self assert: self installedClass defaultShortName equals: self shortName.
]
