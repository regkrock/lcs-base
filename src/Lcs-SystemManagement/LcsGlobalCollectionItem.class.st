Class {
	#name : #LcsGlobalCollectionItem,
	#superclass : #LcsViewItem,
	#category : #'Lcs-SystemManagement-Core'
}

{ #category : #defaults }
LcsGlobalCollectionItem class >> defaultChildrenSelector [
	^ #globalCollections
]

{ #category : #accessing }
LcsGlobalCollectionItem >> numberOfPendingAdds [
	^ (self currentSystem unitOfWork pendingAddsFor: self) size
]

{ #category : #accessing }
LcsGlobalCollectionItem >> numberOfPendingRemovals [
	"^ self currentSystem currentUnitOfWork pendingRemovalsFor: self."
	^ 0
]
