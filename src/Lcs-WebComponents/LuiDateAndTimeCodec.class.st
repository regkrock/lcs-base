Class {
	#name : 'LuiDateAndTimeCodec',
	#superclass : 'LuiCodec',
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'testing' }
LuiDateAndTimeCodec >> canCreate:  anObject [
	^ anObject isKindOf: DateAndTime
]

{ #category : 'converting' }
LuiDateAndTimeCodec >> decode: aDateAndTime [
	"Return string of format: '2026-07-18T07:06:25.315818-04:00'"
	^ aDateAndTime greaseString
]

{ #category : 'converting' }
LuiDateAndTimeCodec >> encode: aString [
	aString isString ifFalse: [ ^ '' ].
	^ [ DateAndTime readFromString: aString ]
		on: DateError
		do: [ :s | s return: '' ]
]
