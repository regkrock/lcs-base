"
This determines if a component will be rendered. If the component is hidden, it is rendered by the property is set to hidden. A hidden component is in the DOM tree and takes of browser space.
"
Class {
	#name : #LuiRenderingProperty,
	#superclass : #LuiComponentProperty,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #constant }
LuiRenderingProperty class >> propertyName [
	^ 'Renderable'
]

{ #category : #command }
LuiRenderingProperty >> beNotRenderable [
	self valueBlock: [ false ]
]

{ #category : #command }
LuiRenderingProperty >> beRenderable [
	self valueBlock: [ true ]
]

{ #category : #'as yet unclassified' }
LuiRenderingProperty >> initialize [
	super initialize.
	self valueBlock: [ true ]
]

{ #category : #'as yet unclassified' }
LuiRenderingProperty >> isNotRenderable [
	^ self isRenderable not
]

{ #category : #'as yet unclassified' }
LuiRenderingProperty >> isRenderable [
	^ self propertyValue == true 
]
