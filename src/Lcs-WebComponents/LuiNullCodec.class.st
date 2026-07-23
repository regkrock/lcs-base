Class {
	#name : 'LuiNullCodec',
	#superclass : 'LuiCodec',
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'testing' }
LuiNullCodec >> canCreate: anObject [
	^ anObject isString
]

{ #category : 'converting' }
LuiNullCodec >> decode: aString [
	^ aString
]

{ #category : 'converting' }
LuiNullCodec >> encode: aString [
	^ aString
]
