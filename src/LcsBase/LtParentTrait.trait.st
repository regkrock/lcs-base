Trait {
	#name : 'LtParentTrait',
	#instVars : [
		'parent'
	],
	#category : 'LcsBase-Traits',
	#package : 'LcsBase',
	#tag : 'Traits'
}

{ #category : 'instance creation' }
LtParentTrait classSide >> newOn: anObject [
	^ self new
		initializeOn: anObject;
		yourself
]

{ #category : 'instance creation' }
LtParentTrait >> initializeOn: anObject [ 
	self parent: anObject
]

{ #category : 'accessing' }
LtParentTrait >> parent [
	^ parent
]

{ #category : 'accessing' }
LtParentTrait >> parent: anObject [
	parent := anObject
]
