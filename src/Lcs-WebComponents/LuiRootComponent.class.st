Class {
	#name : #LuiRootComponent,
	#superclass : #WAComponent,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #initialize }
LuiRootComponent class >> initialize [
	WAAdmin register: self asApplicationAt: 'seas'
]

{ #category : #rendering }
LuiRootComponent >> renderingContentOn: html [
	html with: 'hello'
	"html heading
		level: 1;
		with: 'Hello Seas Members'"
]
