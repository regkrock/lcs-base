Class {
	#name : 'LuiDateCodec',
	#superclass : 'LuiCodec',
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'testing' }
LuiDateCodec >> canCreate: anObject [
	^ anObject isDate or: [ anObject isKindOf: Date ]
]

{ #category : 'converting' }
LuiDateCodec >> dateAsString: aDate [
	"Returns a string like: '2026-07-18'"
	^aDate yyyymmdd
]

{ #category : 'converting' }
LuiDateCodec >> decode: aString [
	^ [ Date fromString: aString ] on: Error do: [ :s | s return: nil ]
]

{ #category : 'converting' }
LuiDateCodec >> encode: aDate [
	(aDate isKindOf: Date) 
		ifTrue: [ ^ self dateAsString: aDate ].
	^''
]
