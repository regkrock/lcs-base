Trait {
	#name : 'LtOrderedCollection',
	#instVars : [
		'collection'
	],
	#traits : 'LtSmalltalkCollection',
	#classTraits : 'LtSmalltalkCollection classTrait',
	#category : 'LcsBase-Traits',
	#package : 'LcsBase',
	#tag : 'Traits'
}

{ #category : 'configuration' }
LtOrderedCollection classSide >> collectionClass [
	^ OrderedCollection
]

{ #category : 'collection' }
LtOrderedCollection >> removeDuplicates [
	self collection removeDuplicates
]
