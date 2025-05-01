Class {
	#name : #LcsCodesLoaderClassBuilder,
	#superclass : #LcsBaseClassBuilder,
	#instVars : [
		'protoCodes',
		'codeClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsCodesLoaderClassBuilder class >> targetSuperclassName [
	^ 'LcsCodesLoader'
]

{ #category : #printing }
LcsCodesLoaderClassBuilder >> addRefactoringTextDetailsTo: aStream [
	super addRefactoringTextDetailsTo: aStream.
	aStream cr; cr.
	aStream nextPutAll: self targetClassMethodSource.
	aStream cr; cr.
	aStream nextPutAll: self dataMethodSource.
	
]

{ #category : #accessing }
LcsCodesLoaderClassBuilder >> codeClassName [
	^ codeClassName
]

{ #category : #accessing }
LcsCodesLoaderClassBuilder >> codeClassName: anObject [
	codeClassName := anObject
]

{ #category : #build }
LcsCodesLoaderClassBuilder >> dataMethodSource [
	^ 'data
	^ ''<1s>''' expandMacrosWith: self protoCodesAsJsonString
]

{ #category : #initialize }
LcsCodesLoaderClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class targetSuperclassName
]

{ #category : #build }
LcsCodesLoaderClassBuilder >> installCode [
	self installClass.
	self installDataMethod.
	self installTargetClassMethod.
	self beCodeInstalled
]

{ #category : #build }
LcsCodesLoaderClassBuilder >> installDataMethod [
	self addRefactoring: (
		RBAddMethodChange
			compile: self dataMethodSource
			in: self installedClass
			classified: #data) execute.
]

{ #category : #build }
LcsCodesLoaderClassBuilder >> installTargetClassMethod [
	self addRefactoring: (
		RBAddMethodChange
			compile: self targetClassMethodSource
			in: self installedClass
			classified: #configuration) execute.
]

{ #category : #accessing }
LcsCodesLoaderClassBuilder >> protoCodes [
	^ protoCodes
]

{ #category : #accessing }
LcsCodesLoaderClassBuilder >> protoCodes: anObject [
	protoCodes := anObject
]

{ #category : #build }
LcsCodesLoaderClassBuilder >> protoCodesAsJsonString [
	^ String streamContents: [ :stream |
		(NeoJSONWriter on: stream)
			mapInstVarsFor: LcsProtoCode;
			nextPut: self protoCodes ].
]

{ #category : #build }
LcsCodesLoaderClassBuilder >> targetClassMethodSource [
	^ 'targetClass
	^ ' , self codeClassName
]

{ #category : #verification }
LcsCodesLoaderClassBuilder >> verifyClassAddedToSystemModel [
	"Currently the loader is not part of model."
]

{ #category : #verification }
LcsCodesLoaderClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self class targetSuperclassName
]

{ #category : #verification }
LcsCodesLoaderClassBuilder >> verifySlotModelUpdatesMadeByBuilder [
	"Currently the loader is not part of model."
]

{ #category : #verification }
LcsCodesLoaderClassBuilder >> verifyUnistall [
	super verifyUnistall.
	self assert: self installedClass isNil
]
