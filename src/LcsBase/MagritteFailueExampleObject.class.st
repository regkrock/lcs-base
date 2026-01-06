Class {
	#name : 'MagritteFailueExampleObject',
	#superclass : 'Object',
	#instVars : [
		'properties'
	],
	#category : 'LcsBase-Error Example',
	#package : 'LcsBase',
	#tag : 'Error Example'
}

{ #category : 'instance creation' }
MagritteFailueExampleObject class >> example [
	^ self new
	
]

{ #category : 'initialize' }
MagritteFailueExampleObject >> initialize [
	super initialize.
	self properties: Dictionary new.
	self postAddActions: OrderedCollection new
]

{ #category : 'properties' }
MagritteFailueExampleObject >> postAddActions [
	^ self properties at: 'postAddActions' ifAbsent: []
]

{ #category : 'properties' }
MagritteFailueExampleObject >> postAddActions: aPostAddActions [
	self properties at: 'postAddActions' put: aPostAddActions
]

{ #category : 'magritte' }
MagritteFailueExampleObject >> postAddActionsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		  accessor: (MAChainAccessor accessors: #(#postAddActions #collection ));
		  label: 'Post Add Actions';
		  default: #(  );
		  priority: 35;
		  beModifiable;
		  blocItemStencil: [ :anItemViewModel :anItemIndex | 
			  anItemViewModel asElement
				  fitContent;
				  border: (BlBorder
						   paint: BrGlamorousColors disabledButtonBorderColor
						   width: 1);
				  margin: (BlInsets
						   top: 0
						   right: 5
						   bottom: 5
						   left: 0);
				  padding: (BlInsets all: 5);
				  background: Color white ];
		  newItemStencil: [ String new ]
]

{ #category : 'accessing' }
MagritteFailueExampleObject >> properties [
	^ properties
]

{ #category : 'accessing' }
MagritteFailueExampleObject >> properties: anObject [
	properties := anObject
]
