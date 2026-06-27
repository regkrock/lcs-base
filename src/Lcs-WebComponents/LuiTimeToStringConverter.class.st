Class {
	#name : 'LuiTimeToStringConverter',
	#superclass : 'LuiDisplayConverter',
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'converting' }
LuiTimeToStringConverter >> convertToString: anObject [
	^ anObject greaseString
]

{ #category : 'converting' }
LuiTimeToStringConverter >> value: anObject [
	(anObject isKindOf: Date) 
		ifTrue: [ ^ self dateAsString: anObject ].
	(anObject isKindOf: DateAndTime) 
		ifTrue: [ ^self dateAsString:anObject asDate ].
	^''
]
