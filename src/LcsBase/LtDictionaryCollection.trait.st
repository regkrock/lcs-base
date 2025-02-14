Trait {
	#name : #LtDictionaryCollection,
	#instVars : [
		'collection'
	],
	#traits : 'LtSmalltalkCollection',
	#classTraits : 'LtSmalltalkCollection classTrait',
	#category : #'LcsBase-Traits'
}

{ #category : #configuration }
LtDictionaryCollection classSide >> collectionClass [
	^ Dictionary
]

{ #category : #collection }
LtDictionaryCollection >> at: aKey [
	^ self collection at: aKey
]

{ #category : #collection }
LtDictionaryCollection >> at: aKey ifAbsent: aBlock [
	^ self collection at: aKey ifAbsent: aBlock
]

{ #category : #collection }
LtDictionaryCollection >> at: aKey put: anObject [
	^ self collection at: aKey put: anObject
]

{ #category : #collection }
LtDictionaryCollection >> keys [
	^ self collection keys
]

{ #category : #collection }
LtDictionaryCollection >> keysAndValuesDo: aBlock [
	^ self collection keysAndValuesDo: aBlock
]

{ #category : #collection }
LtDictionaryCollection >> keysDo: aBlock [
	^ self collection keysDo: aBlock
]

{ #category : #collection }
LtDictionaryCollection >> removeKey: aKey [
	^ self collection removeKey: aKey
]

{ #category : #collection }
LtDictionaryCollection >> removeKey: aKey ifAbsent: aBlock [
	^ self collection removeKey: aKey ifAbsent: aBlock
]

{ #category : #collection }
LtDictionaryCollection >> values [
	^ self collection values
]
