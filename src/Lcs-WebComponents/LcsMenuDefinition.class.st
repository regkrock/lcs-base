Class {
	#name : 'LcsMenuDefinition',
	#superclass : 'LcsObject',
	#instVars : [
		'parent',
		'cssClasses'
	],
	#category : 'Lcs-WebComponents-Menus',
	#package : 'Lcs-WebComponents',
	#tag : 'Menus'
}

{ #category : 'asking' }
LcsMenuDefinition >> componentName [
	self subclassResponsibility
]

{ #category : 'accessing' }
LcsMenuDefinition >> cssClasses [
	^ cssClasses
]

{ #category : 'as yet unclassified' }
LcsMenuDefinition >> cssClasses: aString [
	cssClasses := aString
]

{ #category : 'gt views' }
LcsMenuDefinition >> gtCompoentsFor: aView [
	<gtView>
	
	^ aView columnedTree
		title: 'Components';
		priority: 10;
		expandUpTo: 4;
		items: [ { self } ];
		children: #menuComponentDefintions;
		column: 'Definition Class' text: [ :aComponent | aComponent class name ];
		column: 'Component Name' text: [ :aComponent | aComponent componentName displayString ];
		column: 'Label' text: [ :aComponent | aComponent label displayString ]
]

{ #category : 'printing' }
LcsMenuDefinition >> gtDisplayOn: stream [
	super gtDisplayOn: stream.
	stream 
		nextPutAll: '(';
		nextPutAll: self componentName asString;
		nextPutAll: ')'
]

{ #category : 'as yet unclassified' }
LcsMenuDefinition >> initialize [
	super initialize.
	self cssClasses: ''
]

{ #category : 'accessing' }
LcsMenuDefinition >> menuComponentDefintions [
	^ OrderedCollection new
]

{ #category : 'accessing' }
LcsMenuDefinition >> parent [
	^ parent
]

{ #category : 'accessing' }
LcsMenuDefinition >> parent: anObject [
	parent := anObject
]
