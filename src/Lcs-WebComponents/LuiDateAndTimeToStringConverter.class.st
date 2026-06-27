Class {
	#name : 'LuiDateAndTimeToStringConverter',
	#superclass : 'LuiDisplayConverter',
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'converting' }
LuiDateAndTimeToStringConverter >> convertToString: anObject [
	(anObject isKindOf: Date) 
		ifTrue: [ ^ self dateAndTimeAsString: anObject ].
	(anObject isKindOf: DateAndTime) 
		ifTrue: [ ^self dateAndTimeAsString:anObject ].
	^''
]

{ #category : 'converting' }
LuiDateAndTimeToStringConverter >> dateAndTimeAsString: aDateAndTime [
	^ aDateAndTime printString
]
