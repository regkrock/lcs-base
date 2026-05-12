"
This determines if a component will be rendered. If the component is hidden, it is rendered by the property is set to hidden. A hidden component is in the DOM tree and takes of browser space.
"
Class {
	#name : 'LuiRenderingAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constant' }
LuiRenderingAttribute class >> attributeName [
	^ 'Renderable'
]

{ #category : 'command' }
LuiRenderingAttribute >> beNotRenderable [
	self valueBlock: [ false ]
]

{ #category : 'command' }
LuiRenderingAttribute >> beRenderable [
	self valueBlock: [ true ]
]

{ #category : 'as yet unclassified' }
LuiRenderingAttribute >> initialize [
	super initialize.
	self valueBlock: [ true ]
]

{ #category : 'as yet unclassified' }
LuiRenderingAttribute >> isNotRenderable [
	^ self isRenderable not
]

{ #category : 'as yet unclassified' }
LuiRenderingAttribute >> isRenderable [
	^ self attributeValue == true 
]
