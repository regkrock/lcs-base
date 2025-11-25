Class {
	#name : 'LcsLocalCollectionViewItem',
	#superclass : 'LcsViewItem',
	#category : 'Lcs-SystemManagement-View',
	#package : 'Lcs-SystemManagement',
	#tag : 'View'
}

{ #category : 'defaults' }
LcsLocalCollectionViewItem class >> defaultChildrenSelector [
	^ #localCollections
]

{ #category : 'asking' }
LcsLocalCollectionViewItem >> collectionSize [
	(self item class inheritsFrom: LcsDomainCollection)
			ifTrue: [ ^ self item collectionSize ].
			
	 ^ self item size 
]

{ #category : 'accessing' }
LcsLocalCollectionViewItem >> numberOfPendingAdds [
	^ (self currentSystem unitOfWork pendingAddsFor: self) size
]

{ #category : 'accessing' }
LcsLocalCollectionViewItem >> numberOfPendingRemovals [
	"^ self currentSystem currentUnitOfWork pendingRemovalsFor: self."
	^ 0
]
