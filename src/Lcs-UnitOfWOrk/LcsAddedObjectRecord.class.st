Class {
	#name : #LcsAddedObjectRecord,
	#superclass : #LcsObjectChangeRecord,
	#category : #'Lcs-UnitOfWOrk'
}

{ #category : #api }
LcsAddedObjectRecord >> applyChanges [

	self domainObject parent isNil ifTrue: [
		(self domainObject slotDefinitionNamed: 'parent') persistValue: self domainObject ]
]
