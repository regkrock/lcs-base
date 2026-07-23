Class {
	#name : 'LuiBooleanCodec',
	#superclass : 'LuiCodec',
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'testing' }
LuiBooleanCodec >> canCreate:  anObject [
	^ anObject isKindOf: DateAndTime
]

{ #category : 'converting' }
LuiBooleanCodec >> decode: aString [
	^ aString = 'on'
]

{ #category : 'converting' }
LuiBooleanCodec >> encode: aBoolean [
	^ aBoolean == true ifTrue: [ 'on' ] ifFalse: [ 'off' ]
]
