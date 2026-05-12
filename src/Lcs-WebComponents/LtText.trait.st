Trait {
	#name : 'LtText',
	#instVars : [
		'cachedValue',
		'valueBlock'
	],
	#category : 'Lcs-WebComponents-Traits',
	#package : 'Lcs-WebComponents',
	#tag : 'Traits'
}

{ #category : 'accessing' }
LtText >> cachedValue [
	^ cachedValue ifNil: [ cachedValue := self valueBlock value ]
]

{ #category : 'accessing' }
LtText >> cachedValue: anObject [
	cachedValue := anObject
]

{ #category : 'accessing' }
LtText >> clearCache [
	self cachedValue: nil
]

{ #category : 'accessing' }
LtText >> text [
	^ self cachedValue
]

{ #category : 'accessing' }
LtText >> text: aString [
	self cachedValue: [ aString ].
	self clearCache
]

{ #category : 'accessing' }
LtText >> valueBlock [
	^ valueBlock
]

{ #category : 'accessing' }
LtText >> valueBlock: anObject [
	valueBlock := anObject
]
