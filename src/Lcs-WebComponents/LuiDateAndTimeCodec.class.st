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
LuiDateAndTimeCodec >> dateAndTimeAsString: aDateAndTime [ 
	"Return string of format: '2026-07-18T07:06:25.315818-04:00'"
	^ aDateAndTime greaseString 
]

{ #category : 'converting' }
LuiDateAndTimeCodec >> decode: anObject [
	(anObject isKindOf: Date) 
		ifTrue: [ ^ self dateAndTimeAsString: anObject ].
	(anObject isKindOf: DateAndTime) 
		ifTrue: [ ^self dateAndTimeAsString:anObject ].
	^''
]

{ #category : 'converting' }
LuiDateAndTimeCodec >> encode: aDateAndTime [
	(aDateAndTime isKindOf: DateAndTime) 
		ifTrue: [ ^self dateAndTimeAsString:aDateAndTime ].
	^''
]
