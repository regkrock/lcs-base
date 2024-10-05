Class {
	#name : #LuiHomeArea,
	#superclass : #LuiApplicationArea,
	#instVars : [
		'greeting',
		'body'
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

{ #category : #rendering }
LuiHomeArea >> renderApplicationAreaContentOn: html [
	super renderApplicationAreaContentOn: html
]
