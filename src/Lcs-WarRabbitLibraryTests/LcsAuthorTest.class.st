Class {
	#name : #LcsAuthorTest,
	#superclass : #LcsTestWithTestSystemSetUpForTest,
	#category : #'Lcs-WarRabbitLibraryTests'
}

{ #category : #setUp }
LcsAuthorTest >> setupSunitSystem [
	LcsWarRabbitLibrary new
]

{ #category : #tests }
LcsAuthorTest >> testCreationAndAddingToParentCollection [
	| author person |
	person := LcsPerson new
					surname: 'Freeman';
					firstName: 'Jack';
					middleNames: 'Edward';
					yourself.
	author := LcsAuthor new .
	
	self assert: author surname equals: 'Freeman'.
	self assert: author firstName equals: 'Jack'.
	self assert: author middleNames equals: 'Edward'.
	self assert: author parent isNil.
	
	self currentSystem relatedUnitOfWork applyChanges.
	
	self assert: (self currentSystem authors includes: author).
	self assert: author parent identicalTo: self currentSystem authors.
	self assert: author parent parent identicalTo: self currentSystem
	
]
