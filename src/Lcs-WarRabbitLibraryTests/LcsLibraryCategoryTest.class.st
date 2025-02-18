Class {
	#name : #LcsLibraryCategoryTest,
	#superclass : #LcsTestWithTestSystemSetUpForTest,
	#category : #'Lcs-WarRabbitLibraryTests'
}

{ #category : #setUp }
LcsLibraryCategoryTest >> setupSunitSystem [
	LcsWarRabbitLibrary new
]

{ #category : #tests }
LcsLibraryCategoryTest >> testCreationAndAddingToParentCollection [
	| libraryCategory |
	libraryCategory := LcsLibraryCategory new categoryName: 'Test'.
	self assert: libraryCategory categoryName equals: 'Test'.
	self assert: libraryCategory parent notNil.
	
	self currentSystem relatedUnitOfWork applyChanges.
	
	self assert: (self currentSystem libraryCategories includes: libraryCategory).
	self assert: libraryCategory parent identicalTo: self currentSystem libraryCategories.
	
]
