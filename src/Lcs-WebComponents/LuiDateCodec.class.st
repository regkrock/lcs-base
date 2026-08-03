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
LuiDateCodec >> decode: aString [
	^ [ Date readFrom: aString pattern: 'y-m-d' ] on: Error do: [ :s | s return: nil ]
]

{ #category : 'converting' }
LuiDateCodec >> encode: aDate [
	(aDate isKindOf: Date) 
		ifTrue: [ ^ aDate yyyymmdd ].
	^'' 
]
