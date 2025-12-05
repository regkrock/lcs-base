Class {
	#name : 'LxxOrderedCollection',
	#superclass : 'LcsObject',
	#traits : 'LtOrderedCollection',
	#classTraits : 'LtOrderedCollection classTrait',
	#category : 'Lcs-BaseTests-Tests',
	#package : 'Lcs-BaseTests',
	#tag : 'Tests'
}

{ #category : 'collection' }
LxxOrderedCollection >> includes: anObject [
	^ self collection includes: anObject
]
