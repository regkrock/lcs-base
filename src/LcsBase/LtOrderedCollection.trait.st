Trait {
	#name : #LtOrderedCollection,
	#instVars : [
		'collection'
	],
	#traits : 'LtSmalltalkCollection',
	#classTraits : 'LtSmalltalkCollection classTrait',
	#category : #'LcsBase-Traits'
}

{ #category : #configuration }
LtOrderedCollection classSide >> collectionClass [
	^ OrderedCollection
]

{ #category : #collection }
LtOrderedCollection >> removeDuplicates [
	self collection removeDuplicates
]
