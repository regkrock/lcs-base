Class {
	#name : #LcsUnitOfWork,
	#superclass : #LcsBaseUnitOfWork,
	#category : #'Lcs-UnitOfWOrk'
}

{ #category : #accessing }
LcsUnitOfWork >> applyChanges [
	self addedObjects values do: [:each | each applyChanges].
	self changedObjects do: [:each | each applyChanges ].
	self clearUnitOfWork
]
