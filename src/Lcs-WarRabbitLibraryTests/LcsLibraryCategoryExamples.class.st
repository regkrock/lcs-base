Class {
	#name : 'LcsLibraryCategoryExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-WarRabbitLibraryTests-Examples',
	#package : 'Lcs-WarRabbitLibraryTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsLibraryCategoryExamples >> newLibraryCategory [
	| libraryCategory |
	self ensureCurrentSystemIsWarRabbitLibrarySystem.
	libraryCategory := LcsLibraryCategory new categoryName: 'Test'.
	self assert: libraryCategory categoryName equals: 'Test'.
	self assert: libraryCategory parent notNil.
	
	self currentSystem relatedUnitOfWork applyChanges.
	
	self assert: (self currentSystem libraryCategories includes: libraryCategory).
	self assert: libraryCategory parent identicalTo: self currentSystem libraryCategories.
	
]
