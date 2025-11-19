Trait {
	#name : 'LtSmalltalkCollection',
	#traits : 'LtCollection',
	#classTraits : 'LtCollection classTrait',
	#category : 'LcsBase-Traits',
	#package : 'LcsBase',
	#tag : 'Traits'
}

{ #category : 'accessing' }
LtSmalltalkCollection >> collection [
	^ collection
]

{ #category : 'accessing' }
LtSmalltalkCollection >> collection: anObject [
	collection := anObject
]

{ #category : 'configuration' }
LtSmalltalkCollection >> collectionClass [
	^ self class collectionClass
]

{ #category : 'initialize\t' }
LtSmalltalkCollection >> initialize [ 

	super initialize.
	self collection: self collectionClass new
]
