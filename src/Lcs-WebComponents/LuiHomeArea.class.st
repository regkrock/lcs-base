Class {
	#name : #LuiHomeArea,
	#superclass : #LuiApplicationArea,
	#instVars : [
		'greeting',
		'body',
		'homeMessage'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #accessing }
LuiHomeArea >> body [
	^ body
]

{ #category : #accessing }
LuiHomeArea >> body: anObject [
	body := anObject
]

{ #category : #accessing }
LuiHomeArea >> greeting [
	^ greeting
]

{ #category : #accessing }
LuiHomeArea >> greeting: anObject [
	greeting := anObject
]

{ #category : #accessing }
LuiHomeArea >> homeMessage [
	^ homeMessage ifNil: [ '' ]
]

{ #category : #accessing }
LuiHomeArea >> homeMessage: anObject [
	homeMessage := anObject
]

{ #category : #rendering }
LuiHomeArea >> renderApplicationAreaContentOn: html [
	super renderApplicationAreaContentOn: html.
	html paragraph: self homeMessage
]
