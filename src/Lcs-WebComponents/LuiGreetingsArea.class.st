Class {
	#name : #LuiGreetingsArea,
	#superclass : #LuiApplicationArea,
	#instVars : [
		'greeting',
		'body'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #accessing }
LuiGreetingsArea >> body [
	^ body
]

{ #category : #accessing }
LuiGreetingsArea >> body: anObject [
	body := anObject
]

{ #category : #accessing }
LuiGreetingsArea >> greeting [
	^ greeting
]

{ #category : #accessing }
LuiGreetingsArea >> greeting: anObject [
	greeting := anObject
]
