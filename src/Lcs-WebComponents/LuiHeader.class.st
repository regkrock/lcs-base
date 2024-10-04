Class {
	#name : #LuiHeader,
	#superclass : #LuiComponent,
	#instVars : [
		'level'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #'as yet unclassified' }
LuiHeader >> defaultCssClasses [
	^ OrderedCollection with: 'applicationArea'
]

{ #category : #rendering }
LuiHeader >> renderComponentOn: html [
	html header 
		id: self componentId asString;
		class: self cssClassesString;
		dataName: self componentName;
		dataStClass: self;
		with: [
			self renderSubcomponentsOn: html]
]
