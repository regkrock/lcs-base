Class {
	#name : 'LuiRoot',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constant' }
LuiRoot class >> browserTabName [
	"Subclasses should implment this"
	^ self class name , '-RootComponent'
]

{ #category : 'testing' }
LuiRoot class >> canBeRoot [
	^ true
]

{ #category : 'rendering' }
LuiRoot >> renderComponentOn: html [
	html div 
		addCommonProperties: self;
		with: [
			self renderSubcomponentsOn: html ]
]
