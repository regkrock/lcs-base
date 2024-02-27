Class {
	#name : #LcsModules,
	#superclass : LcsObject, 
	#category : #'Lcs-System'
}

{ #category : #accessing }
LcsModules class >> collectionClass [
	^LcsSmalltalkConfiguration stringDictionaryClass
]

{ #category : #accessing }
LcsModules >> buildModuleFor: eachModuleClass [

	| module |
	module := eachModuleClass new.
	module parent: self.
	self collection at: module moduleName put: module.
]

{ #category : #accessing }
LcsModules >> moduleNamed: aString [
	^self moduleNamed: aString ifAbsent: [self error: 'Module not found: ' , aString asString]
]

{ #category : #accessing }
LcsModules >> moduleNamed: aString ifAbsent: aBlock [
	^self collection at: aString ifAbsent: aBlock
]
