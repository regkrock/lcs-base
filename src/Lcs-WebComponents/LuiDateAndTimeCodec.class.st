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
LuiDateAndTimeCodec >> decode: aString [
	"Return string of format: '2026-07-18T07:06:25.315818-04:00'"
	^ DateAndTime fromString: aString
]

{ #category : 'converting' }
LuiDateAndTimeCodec >> encode: aDateAndTime [
	aDateAndTime class = DateAndTime ifFalse: [ ^ '' ].
	^ aDateAndTime greaseString
]
