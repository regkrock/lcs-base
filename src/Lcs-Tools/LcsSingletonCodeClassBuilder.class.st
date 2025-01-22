Class {
	#name : #LcsSingletonCodeClassBuilder,
	#superclass : #LcsCodeClassBuilder,
	#instVars : [
		'shortName',
		'codeName',
		'codeDescription'
	],
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

{ #category : #printing }
LcsSingletonCodeClassBuilder >> addRefactoringTextDetailsTo: aStream [
	super addRefactoringTextDetailsTo: aStream.
	aStream 
		cr; cr; nextPutAll: 'Create Class Methods:';
		cr; cr; nextPutAll: self defaultCodeNameSource;
		cr; cr; nextPutAll: self defaultCodeDescriptionSource;
		cr; cr; nextPutAll: self defaultShortNameSource;
		cr; cr; nextPutAll: self defaultCodeDescriptionSource
]

{ #category : #accessing }
LcsSingletonCodeClassBuilder >> codeDescription [
	^ codeDescription ifNil: [ codeDescription := self rootName ]
]

{ #category : #accessing }
LcsSingletonCodeClassBuilder >> codeDescription: aString [
	codeDescription := aString
]

{ #category : #accessing }
LcsSingletonCodeClassBuilder >> codeName [
	^ codeName
		ifNil: [ self codeDescription first asLowercase asString
				, (self codeDescription copyFrom: 2 to: self rootName size) ]
]

{ #category : #accessing }
LcsSingletonCodeClassBuilder >> codeName: aString [
	codeName := aString
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
	self addRefactoring: self addDefaultShortNameRefactoring execute.
	self addRefactoring: self addDefaultCodeDescriptionRefactoring execute.
	self addRefactoring: self addDefaultCodeNameRefactoring execute.
	self addRefactoring: self addDefaultInstanceRefactoring execute.
	self beCodeInstalled
]

{ #category : #command }
LcsSingletonCodeClassBuilder >> populateSlotModel [
	self installedClass new
]

{ #category : #accessing }
LcsSingletonCodeClassBuilder >> shortName [
	^ shortName ifNil: [ shortName := self codeDescription ]
]

{ #category : #accessing }
LcsSingletonCodeClassBuilder >> shortName: aString [
	shortName := aString
]

{ #category : #verification }
LcsSingletonCodeClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self targetSuperclassName.
	self assert: self installedClass defaultCodeDescription equals: self codeDescription.
	self assert: self installedClass defaultCodeName equals: self codeName.
	self assert: self installedClass defaultShortName equals: self shortName.
]
