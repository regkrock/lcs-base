Class {
	#name : #LuiRootComponent,
	#superclass : #LuiComponent,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #initialize }
LuiRootComponent class >> initialize [
	WAAdmin register: self asApplicationAt: 'seas'
]

{ #category : #rendering }
LuiRootComponent >> renderContentOn: html [
	html heading
		level: 1;
		with: 'Hello Seas Members'.
]
