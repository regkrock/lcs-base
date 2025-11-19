Class {
	#name : 'LcsGlobalCollectionItem',
	#superclass : 'LcsViewItem',
	#category : 'Lcs-SystemManagement-Core',
	#package : 'Lcs-SystemManagement',
	#tag : 'Core'
}

{ #category : 'defaults' }
LcsGlobalCollectionItem class >> defaultChildrenSelector [
	^ #globalCollections
]

{ #category : 'accessing' }
LcsGlobalCollectionItem >> numberOfPendingAdds [
	^ (self currentSystem ifNil: [ 0 ]
		ifNotNil: [ :s | s unitOfWork pendingAddsFor: self ]) size
]

{ #category : 'accessing' }
LcsGlobalCollectionItem >> numberOfPendingRemovals [
	"^ self currentSystem currentUnitOfWork pendingRemovalsFor: self."
	^ 0
]
