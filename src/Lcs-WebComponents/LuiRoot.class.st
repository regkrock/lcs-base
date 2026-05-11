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

{ #category : 'initialize' }
LuiRoot >> initialize [
	super initialize.
	self componentName: 'root'.
	self componentId: 'root'
]
