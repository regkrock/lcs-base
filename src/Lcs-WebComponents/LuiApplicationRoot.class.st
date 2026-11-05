Class {
	#name : 'LuiApplicationRoot',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constant' }
LuiApplicationRoot class >> browserTabName [
	"Subclasses should implment this"
	^ self class name , '-RootComponent'
]

{ #category : 'testing' }
LuiApplicationRoot class >> canBeRoot [
	"This can be the top component"
	^ true
]

{ #category : 'register' }
LuiApplicationRoot class >> registerApplication: aString [
	WAAdmin applicationDefaults removeParent: WADevelopmentConfiguration instance.
	(WAAdmin register: self asApplicationAt: aString)
		sessionClass: WAExpirySession;
		scriptGeneratorClass: JQScriptGenerator;
		addLibrary: JQDeploymentLibrary
]

{ #category : 'updating' }
LuiApplicationRoot >> applicationTitle [
]

{ #category : 'updating' }
LuiApplicationRoot >> initialize [
	super initialize.
	self componentName: self rootComponentName.
	self componentId: self rootComponentId.
	self cssClass: self rootComponentCssClassName
]

{ #category : 'updating' }
LuiApplicationRoot >> updateFilesInRoot: anHtmlRoot [ 
	"anHtmlRoot javascript url: JQDeploymentLibrary"
]

{ #category : 'updating' }
LuiApplicationRoot >> updateRoot: aRoot [
	super updateRoot: aRoot.
	aRoot title: self applicationTitle.
	aRoot meta
		name: 'viewport';
		content: 'width=device-width, initial-scale=1.0'.
	self updateFilesInRoot: aRoot
]
