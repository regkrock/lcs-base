Class {
	#name : 'LuiTimeCodec',
	#superclass : 'LuiCodec',
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'testing' }
LuiTimeCodec >> canCreate: anObject [
	^ anObject isKindOf: Time
]

{ #category : 'converting' }
LuiTimeCodec >> decode: aString [
	^ [ Time fromString: aString ] on: Error do: [ :s | s return: nil ]
]

{ #category : 'converting' }
LuiTimeCodec >> encode: aTime [
	^ aTime greaseString
]
