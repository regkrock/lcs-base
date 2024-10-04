Class {
	#name : #LuiHeading,
	#superclass : #LuiComponent,
	#instVars : [
		'level'
	],
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #initialize }
LuiHeading >> initialize [
	super initialize.
	self level: 1
]

{ #category : #rendering }
LuiHeading >> level [
	^ level
]

{ #category : #rendering }
LuiHeading >> level: anInteger [
	level := anInteger
]

{ #category : #rendering }
LuiHeading >> renderComponentOn: html [
	html heading 
		class: self cssClassesString;
		dataName: self componentName;
		dataStClass: self;
		level: self level;
		with: [
			html text: self domainObject asString.
			self renderSubcomponentsOn: html]
]
