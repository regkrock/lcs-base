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

{ #category : 'updating' }
LuiRoot >> applicationTitle [
]

{ #category : 'updating' }
LuiRoot >> initialize [
	super initialize.
	self componentName: 'root'.
	self componentId: 'root'
]

{ #category : 'updating' }
LuiRoot >> updateFilesInRoot: aRoot [ 
]

{ #category : 'updating' }
LuiRoot >> updateRoot: aRoot [
	super updateRoot: aRoot.
	aRoot title: self applicationTitle.
	aRoot meta
		name: 'viewport';
		content: 'width=device-width, initial-scale=1.0'.
	self updateFilesInRoot: aRoot
]
