Class {
	#name : 'LxxOrderedCollection',
	#superclass : 'LcsObject',
	#traits : 'LtOrderedCollection',
	#classTraits : 'LtOrderedCollection classTrait',
	#category : 'Lcs-BaseTests-Support',
	#package : 'Lcs-BaseTests',
	#tag : 'Support'
}

{ #category : 'collection' }
LxxOrderedCollection >> includes: anObject [
	^ self collection includes: anObject
]
