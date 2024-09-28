Class {
	#name : #LuiRootComponent,
	#superclass : #LuiComponent,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #initialize }
LuiRootComponent class >> initialize [
	WAAdmin register: self asApplicationAt: 'seas'
]

{ #category : #'as yet unclassified' }
LuiRootComponent >> initialize [
	super initialize.
	self addComponent: (LuiMainPage named: 'root' on: self)
]

{ #category : #rendering }
LuiRootComponent >> renderComponentOn: html [
	html heading
		level: 1;
		with: 'Hello Seas Members'.
	html break.
	self renderSubcomponentsOn: html
]
