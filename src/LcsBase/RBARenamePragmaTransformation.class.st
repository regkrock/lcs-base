Class {
	#name : 'RBARenamePragmaTransformation',
	#superclass : 'RBMethodTransformation',
	#instVars : [
		'pragma',
		'newPragma'
	],
	#category : 'LcsBase-Refactoring',
	#package : 'LcsBase',
	#tag : 'Refactoring'
}

{ #category : 'api' }
RBARenamePragmaTransformation class >> replacePragma: aCurentString with: aNewString inMethod: aSelector inClass: aClassName [

	^ self new
		replacePragma: aCurentString 
		with: aNewString
		inMethod: aSelector
		inClass: aClassName;
		yourself
]

{ #category : 'preconditions' }
RBARenamePragmaTransformation >> applicabilityPreconditions [
	^ self classExist
		& self methodExists
		& self methodHasPragma
]

{ #category : 'preconditions' }
RBARenamePragmaTransformation >> classExist [

	^ RBCondition
		  withBlock: [ self definingClass isNotNil ]
		  errorString:
		  ('Class named <1s> does not exist' expandMacrosWith: className)
]

{ #category : 'preconditions' }
RBARenamePragmaTransformation >> methodExists [
	^ RBCondition
		withBlock: [ self definingClass canUnderstand: selector ]
		errorString: ('Method named <1s> does not exist' expandMacrosWith: selector)
]

{ #category : 'preconditions' }
RBARenamePragmaTransformation >> methodHasPragma [
	^ RBCondition
		withBlock: [ 
			self definingMethod pragmas
				anySatisfy: [ :e | e selector = pragma selector ] ]
		errorString: ('Method named <1s> does not have a pragma named <2s>'
				expandMacrosWith: selector
				with: pragma selector)
]

{ #category : 'executing' }
RBARenamePragmaTransformation >> privateTransform [
	"the transformation is straighforward: just add the node at the last position of the method.
	 #todo the case in which the context is a block"

	| methodTree pragmaNode |
	methodTree := self definingMethod.
	pragmaNode := self parserClass parsePragma: pragma formattedCode.
	methodTree removePragma: pragmaNode.
	methodTree addPragma: newPragma.
	self definingClass compileTree: methodTree
]

{ #category : 'api' }
RBARenamePragmaTransformation >> replacePragma: aCurrentString with: aNewString inMethod: aSelector inClass: aClassName [
	self className: aClassName.
	selector := aSelector.
	pragma := RBPragmaNode new
			selector: aCurrentString;
			arguments: #().
	newPragma := RBPragmaNode new
			selector: aNewString;
			arguments: #()
]

{ #category : 'storing' }
RBARenamePragmaTransformation >> storeOn: aStream [

	aStream nextPut: $(.
	self class storeOn: aStream.
	aStream
		nextPutAll: ' pragma: ''';
		nextPutAll: pragma;
		nextPutAll: ''' inMethod: ''';
		nextPutAll: selector;
		nextPutAll: ''' inClass: '.
	class storeOn: aStream.
	aStream nextPut: $)
]
