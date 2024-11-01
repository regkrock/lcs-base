Class {
	#name : #LuiDateToStringConverter,
	#superclass : #LuiDisplayConverter,
	#category : #'Lcs-WebComponents-Transformers'
}

{ #category : #converting }
LuiDateToStringConverter >> dateAsString: aDate [
	^aDate yyyymmdd
]

{ #category : #converting }
LuiDateToStringConverter >> value: anObject [
	(anObject isKindOf: Date) 
		ifTrue: [ ^ self dateAsString: anObject ].
	(anObject isKindOf: DateAndTime) 
		ifTrue: [ ^self dateAsString:anObject asDate ].
	^''
]
